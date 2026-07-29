from __future__ import annotations

import hashlib
import json
import math
import re
from collections import Counter
from datetime import datetime, timezone
from pathlib import Path
from typing import Any

from providers import ProviderError, chat_json


BASE = Path(__file__).resolve().parents[1]
KNOWLEDGE_PATH = BASE / "knowledge" / "knowledge.json"
SCHEMA_VERSION = "1.0.0"
CORE_FIELDS = [
    "patient_age",
    "patient_sex",
    "contrast_product",
    "administration_context",
    "event_description",
    "onset",
    "management",
    "outcome",
]


def _ngrams(text: str, n: int = 2) -> Counter[str]:
    cleaned = re.sub(r"\s+", "", text.lower())
    if len(cleaned) < n:
        return Counter([cleaned]) if cleaned else Counter()
    return Counter(cleaned[i : i + n] for i in range(len(cleaned) - n + 1))


def _cosine(left: Counter[str], right: Counter[str]) -> float:
    if not left or not right:
        return 0.0
    dot = sum(value * right.get(key, 0) for key, value in left.items())
    norm_l = math.sqrt(sum(value * value for value in left.values()))
    norm_r = math.sqrt(sum(value * value for value in right.values()))
    return dot / (norm_l * norm_r) if norm_l and norm_r else 0.0


class KnowledgeBase:
    def __init__(self, path: Path = KNOWLEDGE_PATH):
        self.path = path
        self.entries = json.loads(path.read_text(encoding="utf-8"))
        self.vectors = {
            entry["id"]: _ngrams(
                " ".join(
                    [
                        entry["title"],
                        entry["content"],
                        " ".join(entry.get("keywords", [])),
                    ]
                )
            )
            for entry in self.entries
        }
        self.version = hashlib.sha256(path.read_bytes()).hexdigest()[:12]

    def search(self, query: str, top_k: int = 6) -> list[dict[str, Any]]:
        qvec = _ngrams(query)
        scored = []
        for entry in self.entries:
            score = _cosine(qvec, self.vectors[entry["id"]])
            keyword_hits = sum(1 for term in entry.get("keywords", []) if term.lower() in query.lower())
            score += min(keyword_hits * 0.18, 0.54)
            scored.append({**entry, "score": round(score, 4)})
        scored.sort(key=lambda item: (-item["score"], item["id"]))
        selected = [item for item in scored[:top_k] if item["score"] > 0]
        required_types = {"field_definition", "guardrail"}
        present = {item["type"] for item in selected}
        for wanted in required_types - present:
            candidate = next((item for item in scored if item["type"] == wanted), None)
            if candidate and candidate not in selected:
                selected.append(candidate)
        return selected[: top_k + 2]


def empty_report(transcript: str, source_input_type: str = "voice_transcript") -> dict[str, Any]:
    return {
        "schema_version": SCHEMA_VERSION,
        "source_input_type": source_input_type,
        "transcript": transcript,
        "patient": {
            "age": grounded(None, "missing"),
            "sex": grounded(None, "missing"),
            "history": grounded(None, "missing"),
        },
        "contrast": {
            "product": grounded(None, "missing"),
            "dose": grounded(None, "missing"),
            "route": grounded(None, "missing"),
            "site": grounded(None, "missing"),
            "examination": grounded(None, "missing"),
            "administration_time": grounded(None, "missing"),
        },
        "events": [],
        "onset": grounded(None, "missing"),
        "vital_signs": [],
        "management_actions": [],
        "outcomes": [],
        "chronological_narrative": "",
        "missing_required_fields": CORE_FIELDS.copy(),
        "neutral_follow_up_questions": [],
        "source_conflicts": [],
        "safety_flags": [],
        "retrieval": [],
        "review_status": "pending_human_review",
        "automated_submission_permitted": False,
        "nurse_confirmation": None,
    }


def grounded(value: str | None, status: str, source_text: str | None = None, candidate: str | None = None) -> dict[str, Any]:
    return {
        "value": value,
        "status": status,
        "source_text": source_text,
        "normalized_candidate": candidate,
    }


def deterministic_baseline(transcript: str) -> dict[str, Any]:
    report = empty_report(transcript)
    patterns = {
        "age": r"(\d{1,3})\s*岁",
        "sex": r"(男|女)(?:性|患者)?",
        "product": r"(碘海醇|碘克沙醇|碘普罗胺|碘帕醇|造影剂)",
        "dose": r"(\d+(?:\.\d+)?)\s*(毫升|ml|mL)",
        "examination": r"(增强CT|CT增强|增强扫描|冠脉CTA|CTA|造影检查)",
        "onset": r"((?:注射|给药)(?:中|后|结束后)?[^，。；]{0,12}(?:分钟|小时|立即|马上|随后|不久))",
    }
    matches = {key: re.search(pattern, transcript, re.I) for key, pattern in patterns.items()}
    for key in ("age", "sex"):
        match = matches[key]
        if match:
            report["patient"][key] = grounded(match.group(1), "explicit", match.group(0))
    for key in ("product", "dose", "examination"):
        match = matches[key]
        if match:
            report["contrast"][key] = grounded(match.group(0), "explicit", match.group(0))
    if matches["onset"]:
        report["onset"] = grounded(matches["onset"].group(1), "explicit", matches["onset"].group(0))

    event_terms = {
        "恶心": "Nausea",
        "呕吐": "Vomiting",
        "皮疹": "Rash",
        "瘙痒": "Pruritus",
        "风团": "Urticaria",
        "咳嗽": "Cough",
        "打喷嚏": "Sneezing",
        "头晕": "Dizziness",
        "舌麻": "Paraesthesia oral",
        "外渗": "Extravasation",
        "肿胀": "Swelling",
        "喉部不适": "Throat irritation",
        "呼吸困难": "Dyspnoea",
    }
    for term, candidate in event_terms.items():
        if term in transcript:
            report["events"].append(
                {
                    "original_wording": term,
                    "status": "explicit",
                    "source_text": term,
                    "normalized_candidate": candidate,
                }
            )

    action_markers = ["停止注射", "停止给药", "抬高", "冷敷", "热敷", "吸氧", "观察", "通知医生", "静脉给药"]
    for marker in action_markers:
        if marker in transcript:
            report["management_actions"].append(grounded(marker, "explicit", marker))
    outcome_markers = ["缓解", "好转", "消失", "未缓解", "加重", "留观", "住院"]
    for marker in outcome_markers:
        if marker in transcript:
            report["outcomes"].append(grounded(marker, "explicit", marker))
    report["chronological_narrative"] = transcript.strip()
    return apply_guardrails(report, transcript)


SYSTEM_PROMPT = """你是造影剂相关不良事件护理记录抽取器。只输出JSON。
只抽取护士口述中明确出现的患者事实。知识库仅用于字段定义、同义词候选和中性追问，绝不能作为患者事实。
不得推断因果关系、诊断、严重程度、治疗建议或法定可报告性。
缺失内容必须为null且status为missing；模糊或冲突内容标为unclear。
每个非空值必须给出逐字source_text，且source_text必须是口述文本的连续子串。
标准术语只能放在normalized_candidate，不得替换original wording。
review_status固定为pending_human_review，automated_submission_permitted固定为false。
输出必须包含给定模板的所有顶层键。"""


def build_user_prompt(transcript: str, retrieval: list[dict[str, Any]]) -> str:
    compact = [
        {
            "id": item["id"],
            "type": item["type"],
            "content": item["content"],
            "source": item["source"],
            "use": item["use"],
        }
        for item in retrieval
    ]
    template = empty_report(transcript)
    return (
        "护士口述：\n"
        + transcript
        + "\n\n检索知识（只能作为结构和候选提示）：\n"
        + json.dumps(compact, ensure_ascii=False)
        + "\n\n必须遵循的输出模板：\n"
        + json.dumps(template, ensure_ascii=False)
    )


def generate_report(transcript: str, top_k: int = 6, use_llm: bool = True) -> dict[str, Any]:
    transcript = transcript.strip()
    if not transcript:
        raise ValueError("Transcript is empty")
    kb = KnowledgeBase()
    retrieval = kb.search(transcript, top_k=top_k)
    if use_llm:
        raw, model_meta = chat_json(SYSTEM_PROMPT, build_user_prompt(transcript, retrieval))
        raw = normalize_model_output(raw)
        report = merge_template(raw, empty_report(transcript))
        report = merge_deterministic_evidence(report, deterministic_baseline(transcript))
    else:
        report = deterministic_baseline(transcript)
        model_meta = {"provider": "deterministic_baseline", "model": "rules-v1"}
    report["retrieval"] = [
        {
            "id": item["id"],
            "title": item["title"],
            "type": item["type"],
            "source": item["source"],
            "score": item["score"],
        }
        for item in retrieval
    ]
    report["run_metadata"] = {
        **model_meta,
        "knowledge_version": kb.version,
        "schema_version": SCHEMA_VERSION,
        "temperature": 0,
        "generated_at": datetime.now(timezone.utc).isoformat(),
    }
    return apply_guardrails(report, transcript)


def merge_deterministic_evidence(report: dict[str, Any], baseline: dict[str, Any]) -> dict[str, Any]:
    """Backfill only verbatim, deterministic facts that the LLM omitted."""
    for section, fields in (("patient", ("age", "sex", "history")), ("contrast", ("product", "dose", "route", "site", "examination", "administration_time"))):
        for field in fields:
            if not report[section][field].get("value") and baseline[section][field].get("value"):
                report[section][field] = baseline[section][field]
    if not report["onset"].get("value") and baseline["onset"].get("value"):
        report["onset"] = baseline["onset"]
    baseline_events = baseline.get("events", [])
    combined = []
    for item in report.get("events", []):
        wording = item.get("original_wording") or ""
        if isinstance(wording, dict):
            nested = wording
            wording = nested.get("value") or nested.get("description") or ""
            item["original_wording"] = wording
            item.setdefault("status", nested.get("status", "unclear"))
            item.setdefault("source_text", nested.get("source_text"))
            item.setdefault("normalized_candidate", nested.get("normalized_candidate"))
        contained = [candidate for candidate in baseline_events if candidate.get("original_wording") in wording]
        if len(contained) < 2:
            combined.append(item)
    seen = {item.get("original_wording") for item in combined}
    combined.extend(item for item in baseline_events if item.get("original_wording") not in seen)
    report["events"] = combined
    return report

def normalize_model_output(raw: dict[str, Any]) -> dict[str, Any]:
    """Normalize common model key variants before schema merging."""
    for item in raw.get("events", []) if isinstance(raw.get("events"), list) else []:
        if "original_wording" not in item and "description" in item:
            item["original_wording"] = item.pop("description")
    for collection in ("management_actions", "outcomes", "vital_signs"):
        for item in raw.get(collection, []) if isinstance(raw.get(collection), list) else []:
            if "value" not in item and "description" in item:
                item["value"] = item.pop("description")
    return raw

def merge_template(value: Any, template: Any) -> Any:
    if isinstance(template, dict):
        source = value if isinstance(value, dict) else {}
        return {key: merge_template(source.get(key), sub) for key, sub in template.items()}
    if isinstance(template, list):
        return value if isinstance(value, list) else []
    return template if value is None and template is not None else value


def _walk_grounded(value: Any, path: str = ""):
    if isinstance(value, dict):
        if {"value", "status", "source_text"}.issubset(value):
            yield path, value
        for key, child in value.items():
            yield from _walk_grounded(child, f"{path}.{key}" if path else key)
    elif isinstance(value, list):
        for index, child in enumerate(value):
            yield from _walk_grounded(child, f"{path}[{index}]")


def apply_guardrails(report: dict[str, Any], transcript: str) -> dict[str, Any]:
    flags: list[dict[str, str]] = []
    for path, item in _walk_grounded(report):
        value = item.get("value")
        source = item.get("source_text")
        status = item.get("status")
        if value and (not source or source not in transcript):
            flags.append({"rule": "G020", "field": path, "message": "非空值缺少逐字来源，已清空。"})
            item.update({"value": None, "status": "missing", "source_text": None})
        elif not value and status == "explicit":
            item["status"] = "missing"
    for event in report.get("events", []):
        source = event.get("source_text")
        wording = event.get("original_wording")
        if wording and (not source or source not in transcript):
            flags.append({"rule": "G006", "field": "events", "message": "事件术语缺少口述支持，已移除。"})
            event.update(
                {
                    "original_wording": None,
                    "status": "missing",
                    "source_text": None,
                    "normalized_candidate": None,
                }
            )
    prohibited = re.compile(r"(确定由|因果关系为|严重程度为|建议给予|应当治疗|自动上报|符合上报标准)")
    narrative = report.get("chronological_narrative") or ""
    if prohibited.search(narrative):
        flags.append({"rule": "G013-G015", "field": "chronological_narrative", "message": "删除了禁止的因果、严重性、治疗或上报判断。"})
        report["chronological_narrative"] = transcript

    missing = []
    mapping = {
        "patient_age": report["patient"]["age"].get("value"),
        "patient_sex": report["patient"]["sex"].get("value"),
        "contrast_product": report["contrast"]["product"].get("value"),
        "administration_context": report["contrast"]["examination"].get("value")
        or report["contrast"]["route"].get("value"),
        "event_description": any(event.get("original_wording") for event in report.get("events", [])),
        "onset": report["onset"].get("value"),
        "management": bool(report.get("management_actions")),
        "outcome": bool(report.get("outcomes")),
    }
    for field, present in mapping.items():
        if not present:
            missing.append(field)
    report["missing_required_fields"] = missing
    questions = {
        "contrast_product": "请问使用的造影剂名称是否知道？",
        "administration_context": "请补充检查类型、给药途径或给药部位中已知的信息。",
        "onset": "症状是在给药过程中、给药后立即，还是稍后出现？",
        "management": "当时采取了哪些处理？如未处理也请说明。",
        "outcome": "处理或观察后，患者症状有什么变化？",
    }
    report["neutral_follow_up_questions"] = [questions[field] for field in missing if field in questions]
    report["safety_flags"] = list(report.get("safety_flags") or []) + flags
    report["review_status"] = "pending_human_review"
    report["automated_submission_permitted"] = False
    report["nurse_confirmation"] = None
    return report


def confirm_report(report: dict[str, Any], nurse_name: str) -> dict[str, Any]:
    if not nurse_name.strip():
        raise ValueError("Nurse confirmation name or study code is required")
    confirmed = json.loads(json.dumps(report, ensure_ascii=False))
    confirmed["review_status"] = "approved_by_nurse"
    confirmed["automated_submission_permitted"] = False
    confirmed["nurse_confirmation"] = {
        "reviewer": nurse_name.strip(),
        "confirmed_at": datetime.now(timezone.utc).isoformat(),
    }
    return confirmed





