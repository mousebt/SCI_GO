from __future__ import annotations

import argparse
import json
import os
import sys
import time
from collections import Counter
from concurrent.futures import ThreadPoolExecutor, as_completed
from datetime import datetime, timezone
from pathlib import Path
from typing import Any


HERE = Path(__file__).resolve().parent
SYSTEM = HERE.parent
sys.path.insert(0, str(SYSTEM / "app"))

from core import generate_report  # noqa: E402
from providers import ProviderError  # noqa: E402


DEFAULT_INPUT = HERE / "expert_constructed_text_candidates_100.json"


def source_audit(report: dict[str, Any], transcript: str) -> tuple[int, int]:
    checked = 0
    unsupported = 0

    def walk(value: Any) -> None:
        nonlocal checked, unsupported
        if isinstance(value, dict):
            if {"value", "status", "source_text"}.issubset(value):
                fact = value.get("value")
                if fact:
                    checked += 1
                    source = value.get("source_text")
                    if not source or source not in transcript:
                        unsupported += 1
            for child in value.values():
                walk(child)
        elif isinstance(value, list):
            for child in value:
                walk(child)

    walk(report)
    for event in report.get("events", []):
        wording = event.get("original_wording")
        if wording:
            checked += 1
            source = event.get("source_text")
            if not source or source not in transcript:
                unsupported += 1
    return checked, unsupported


def summarize(records: list[dict[str, Any]], errors: list[dict[str, Any]], elapsed: float) -> dict[str, Any]:
    tier_success = Counter(item["input"]["difficulty_level"] for item in records)
    missing = Counter()
    source_checked = 0
    unsupported = 0
    safety_flags = 0
    review_violations = 0
    auto_submit_violations = 0
    providers = Counter()
    models = Counter()

    for item in records:
        report = item["report"]
        transcript = item["input"]["transcript"]
        checked, failed = source_audit(report, transcript)
        source_checked += checked
        unsupported += failed
        safety_flags += len(report.get("safety_flags", []))
        missing.update(report.get("missing_required_fields", []))
        review_violations += report.get("review_status") != "pending_human_review"
        auto_submit_violations += report.get("automated_submission_permitted") is not False
        metadata = report.get("run_metadata", {})
        providers[metadata.get("provider", "unknown")] += 1
        models[metadata.get("model", "unknown")] += 1

    return {
        "run_type": "synthetic_text_corpus_parsing",
        "interpretation": (
            "Engineering parsing run on fully synthetic text candidates. "
            "No expert-adjudicated gold standard was available, so accuracy, recall and F1 were not calculated."
        ),
        "n_requested": len(records) + len(errors),
        "n_success": len(records),
        "n_error": len(errors),
        "success_by_difficulty": {str(k): tier_success[k] for k in sorted(tier_success)},
        "provider_counts": dict(providers),
        "model_counts": dict(models),
        "source_supported_fact_checks": source_checked,
        "unsupported_nonempty_fact_count_after_guardrails": unsupported,
        "source_fidelity_after_guardrails": (
            (source_checked - unsupported) / source_checked if source_checked else 1.0
        ),
        "total_safety_flags": safety_flags,
        "review_status_violation_count": review_violations,
        "auto_submit_violation_count": auto_submit_violations,
        "missing_required_field_counts": dict(missing.most_common()),
        "elapsed_seconds": round(elapsed, 3),
        "mean_seconds_per_success": round(elapsed / len(records), 3) if records else None,
    }


def parse_case(
    case: dict[str, Any],
    retries: int,
    initial_backoff: float,
    max_backoff: float,
) -> tuple[dict[str, Any] | None, dict[str, Any] | None]:
    case_started = time.perf_counter()
    error: Exception | None = None
    retry_events: list[dict[str, Any]] = []
    for attempt in range(1, retries + 2):
        try:
            report = generate_report(case["transcript"], use_llm=True)
            return (
                {
                    "input": case,
                    "report": report,
                    "elapsed_seconds": round(time.perf_counter() - case_started, 3),
                    "attempts": attempt,
                    "retry_events": retry_events,
                },
                None,
            )
        except Exception as exc:
            error = exc
            retryable = isinstance(exc, ProviderError) and exc.retryable
            if not retryable or attempt > retries:
                break
            exponential = min(max_backoff, initial_backoff * (2 ** (attempt - 1)))
            advised = exc.retry_after if exc.retry_after is not None else 0.0
            delay = max(exponential, advised)
            retry_events.append(
                {
                    "attempt": attempt,
                    "error_type": type(exc).__name__,
                    "retry_after_seconds": round(delay, 3),
                    "server_retry_after_seconds": exc.retry_after,
                }
            )
            time.sleep(delay)
    assert error is not None
    return (
        None,
        {
            "case_id": case["case_id"],
            "difficulty_level": case["difficulty_level"],
            "error_type": type(error).__name__,
            "error": str(error),
            "retryable": isinstance(error, ProviderError) and error.retryable,
            "attempts": len(retry_events) + 1,
            "retry_events": retry_events,
            "elapsed_seconds": round(time.perf_counter() - case_started, 3),
        },
    )


def main() -> None:
    parser = argparse.ArgumentParser(description="Parse the 100-case synthetic text corpus with a configured LLM.")
    parser.add_argument("--input", type=Path, default=DEFAULT_INPUT)
    parser.add_argument("--output-dir", type=Path, default=SYSTEM / "runs")
    parser.add_argument("--provider", default="local")
    parser.add_argument("--limit", type=int, default=0, help="0 means all cases.")
    parser.add_argument("--retries", type=int, default=4, help="Retries for 429, 5xx and transient network errors only.")
    parser.add_argument("--initial-backoff", type=float, default=1.0)
    parser.add_argument("--max-backoff", type=float, default=60.0)
    parser.add_argument("--workers", type=int, default=1)
    args = parser.parse_args()

    os.environ["CONTRAST_RAG_LLM_PROVIDER"] = args.provider
    cases = json.loads(args.input.read_text(encoding="utf-8"))
    if args.limit > 0:
        cases = cases[: args.limit]

    stamp = datetime.now(timezone.utc).strftime("%Y%m%dT%H%M%SZ")
    suffix = f"{args.provider}-text-corpus-n{len(cases)}"
    output = args.output_dir / f"{stamp}-{suffix}"
    output.mkdir(parents=True, exist_ok=False)
    checkpoint = output / "reports.jsonl"
    error_path = output / "errors.jsonl"

    records: list[dict[str, Any]] = []
    errors: list[dict[str, Any]] = []
    started = time.perf_counter()
    completed = 0
    with ThreadPoolExecutor(max_workers=args.workers) as pool:
        future_map = {
            pool.submit(
                parse_case,
                case,
                args.retries,
                args.initial_backoff,
                args.max_backoff,
            ): case
            for case in cases
        }
        for future in as_completed(future_map):
            case = future_map[future]
            record, failed = future.result()
            if record is not None:
                records.append(record)
                with checkpoint.open("a", encoding="utf-8") as handle:
                    handle.write(json.dumps(record, ensure_ascii=False) + "\n")
                status = "ok"
                elapsed_case = record["elapsed_seconds"]
            else:
                assert failed is not None
                errors.append(failed)
                with error_path.open("a", encoding="utf-8") as handle:
                    handle.write(json.dumps(failed, ensure_ascii=False) + "\n")
                status = "error"
                elapsed_case = failed["elapsed_seconds"]
            completed += 1
            print(
                json.dumps(
                    {
                        "progress": f"{completed}/{len(cases)}",
                        "case_id": case["case_id"],
                        "status": status,
                        "elapsed_seconds": elapsed_case,
                    },
                    ensure_ascii=False,
                ),
                flush=True,
            )

    elapsed = time.perf_counter() - started
    records.sort(key=lambda item: item["input"]["case_id"])
    errors.sort(key=lambda item: item["case_id"])
    summary = summarize(records, errors, elapsed)
    (output / "reports.json").write_text(
        json.dumps(records, ensure_ascii=False, indent=2) + "\n", encoding="utf-8"
    )
    (output / "errors.json").write_text(
        json.dumps(errors, ensure_ascii=False, indent=2) + "\n", encoding="utf-8"
    )
    (output / "summary.json").write_text(
        json.dumps(summary, ensure_ascii=False, indent=2) + "\n", encoding="utf-8"
    )
    print(json.dumps({"output": str(output), **summary}, ensure_ascii=False, indent=2))
    if errors:
        raise SystemExit(2)


if __name__ == "__main__":
    main()
