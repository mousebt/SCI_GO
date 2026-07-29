from __future__ import annotations

import argparse
import csv
import json
import sys
from datetime import datetime, timezone
from pathlib import Path

HERE = Path(__file__).resolve().parent
SYSTEM = HERE.parent
sys.path.insert(0, str(SYSTEM / "app"))

from core import generate_report  # noqa: E402


def values(report: dict) -> dict:
    return {
        "patient_age": report["patient"]["age"].get("value"),
        "patient_sex": report["patient"]["sex"].get("value"),
        "contrast_product": report["contrast"]["product"].get("value"),
        "events": [item.get("original_wording") for item in report.get("events", []) if item.get("original_wording")],
        "onset_present": bool(report["onset"].get("value")),
        "management_present": bool(report.get("management_actions")),
        "outcome_present": bool(report.get("outcomes")),
    }


def score_case(case: dict, report: dict) -> dict:
    observed, gold = values(report), case["gold"]
    scalar = ["patient_age", "patient_sex", "contrast_product", "onset_present", "management_present", "outcome_present"]
    correct = sum(observed[field] == gold[field] for field in scalar)
    gold_events, predicted_events = set(gold["events"]), set(observed["events"])
    tp = len(gold_events & predicted_events)
    precision = tp / len(predicted_events) if predicted_events else (1.0 if not gold_events else 0.0)
    recall = tp / len(gold_events) if gold_events else 1.0
    f1 = 2 * precision * recall / (precision + recall) if precision + recall else 0.0
    output = json.dumps(report, ensure_ascii=False)
    forbidden_hits = [fact for fact in gold["forbidden_facts"] if fact in output]
    grounded = []

    def walk(value):
        if isinstance(value, dict):
            if value.get("value"):
                grounded.append(bool(value.get("source_text") and value["source_text"] in case["transcript"]))
            for child in value.values():
                walk(child)
        elif isinstance(value, list):
            for child in value:
                walk(child)

    walk(report)
    return {
        "case_id": case["case_id"],
        "core_field_accuracy": correct / len(scalar),
        "event_precision": precision,
        "event_recall": recall,
        "event_f1": f1,
        "source_fidelity": sum(grounded) / len(grounded) if grounded else 1.0,
        "unsupported_forbidden_fact_count": len(forbidden_hits),
        "forbidden_hits": "|".join(forbidden_hits),
        "safety_flag_count": len(report.get("safety_flags", [])),
        "model": report.get("run_metadata", {}).get("model", "unknown"),
        "provider": report.get("run_metadata", {}).get("provider", "unknown"),
        "knowledge_version": report.get("run_metadata", {}).get("knowledge_version", ""),
    }


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("--live-llm", action="store_true", help="Call configured LLM; synthetic cases only.")
    parser.add_argument("--output-dir", type=Path, default=SYSTEM / "runs")
    args = parser.parse_args()
    cases = json.loads((HERE / "synthetic_cases.json").read_text(encoding="utf-8"))
    reports, rows = [], []
    for case in cases:
        report = generate_report(case["transcript"], use_llm=args.live_llm)
        reports.append({"case_id": case["case_id"], "report": report})
        rows.append(score_case(case, report))
    mode = "live-llm" if args.live_llm else "deterministic"
    stamp = datetime.now(timezone.utc).strftime("%Y%m%dT%H%M%SZ")
    output = args.output_dir / f"{stamp}-{mode}"
    output.mkdir(parents=True, exist_ok=False)
    with (output / "case_metrics.csv").open("w", newline="", encoding="utf-8-sig") as handle:
        writer = csv.DictWriter(handle, fieldnames=list(rows[0]))
        writer.writeheader()
        writer.writerows(rows)
    (output / "reports.json").write_text(json.dumps(reports, ensure_ascii=False, indent=2), encoding="utf-8")
    summary = {
        "mode": mode,
        "n_cases": len(rows),
        "mean_core_field_accuracy": sum(row["core_field_accuracy"] for row in rows) / len(rows),
        "mean_event_f1": sum(row["event_f1"] for row in rows) / len(rows),
        "mean_source_fidelity": sum(row["source_fidelity"] for row in rows) / len(rows),
        "total_unsupported_forbidden_facts": sum(row["unsupported_forbidden_fact_count"] for row in rows),
        "interpretation": "Engineering verification on synthetic cases; not a clinical effectiveness result.",
    }
    (output / "summary.json").write_text(json.dumps(summary, ensure_ascii=False, indent=2), encoding="utf-8")
    print(json.dumps({"output": str(output), **summary}, ensure_ascii=False, indent=2))


if __name__ == "__main__":
    main()

