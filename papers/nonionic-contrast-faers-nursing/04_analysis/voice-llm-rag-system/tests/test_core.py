from __future__ import annotations

import sys
import unittest
from pathlib import Path

SYSTEM = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(SYSTEM / "app"))

from core import (KnowledgeBase, apply_guardrails, confirm_report, deterministic_baseline, empty_report, merge_deterministic_evidence, merge_template, normalize_model_output)  # noqa: E402


class KnowledgeTests(unittest.TestCase):
    def test_retrieval_returns_timing_prompt(self):
        hits = KnowledgeBase().search("注射后五分钟恶心", top_k=5)
        self.assertIn("FAERS-002", {item["id"] for item in hits})

    def test_retrieval_is_traceable(self):
        for item in KnowledgeBase().search("外渗肿胀", top_k=4):
            self.assertTrue(item["id"])
            self.assertTrue(item["source"])
            self.assertEqual(item["status"], "approved_for_prototype")


class GuardrailTests(unittest.TestCase):
    def test_unsupported_fact_is_removed(self):
        report = empty_report("患者恶心")
        report["patient"]["age"] = {"value": "52", "status": "explicit", "source_text": "52岁", "normalized_candidate": None}
        checked = apply_guardrails(report, "患者恶心")
        self.assertIsNone(checked["patient"]["age"]["value"])
        self.assertTrue(any(flag["rule"] == "G020" for flag in checked["safety_flags"]))

    def test_prohibited_clinical_judgement_is_removed(self):
        report = empty_report("患者恶心")
        report["chronological_narrative"] = "确定由造影剂导致，建议给予治疗"
        checked = apply_guardrails(report, "患者恶心")
        self.assertEqual(checked["chronological_narrative"], "患者恶心")

    def test_automatic_submission_is_never_enabled(self):
        report = deterministic_baseline("女，52岁，注射后恶心，观察后缓解")
        confirmed = confirm_report(report, "NURSE-01")
        self.assertEqual(confirmed["review_status"], "approved_by_nurse")
        self.assertFalse(confirmed["automated_submission_permitted"])

    def test_missingness_is_preserved(self):
        report = deterministic_baseline("患者出现恶心")
        self.assertIsNone(report["contrast"]["product"]["value"])
        self.assertIn("contrast_product", report["missing_required_fields"])

    def test_observation_area_is_not_a_management_action(self):
        report = deterministic_baseline("患者回到观察区后出现恶心")
        self.assertNotIn("观察", {item["value"] for item in report["management_actions"]})

    def test_generic_contrast_in_missing_statement_is_not_a_product(self):
        report = deterministic_baseline("具体造影剂没记，患者出现皮疹")
        self.assertIsNone(report["contrast"]["product"]["value"])
        self.assertIn("contrast_product", report["missing_required_fields"])

    def test_single_short_action_is_removed_when_longer_source_exists(self):
        transcript = "观察三十分钟后症状缓解"
        report = empty_report(transcript)
        report["management_actions"] = [
            {"value": "观察", "status": "explicit", "source_text": "观察", "normalized_candidate": None},
            {"value": "观察三十分钟", "status": "explicit", "source_text": "观察三十分钟", "normalized_candidate": None},
        ]
        checked = apply_guardrails(report, transcript)
        self.assertEqual([item["value"] for item in checked["management_actions"]], ["观察三十分钟"])

    def test_negated_events_are_not_patient_facts(self):
        transcript = "明确记录的是恶心，皮疹和瘙痒被否认。"
        report = deterministic_baseline(transcript)
        self.assertEqual(
            [event["original_wording"] for event in report["events"] if event["original_wording"]],
            ["恶心"],
        )

    def test_template_content_is_excluded_but_actual_fact_is_kept(self):
        transcript = "模板示例，不是患者事实：患者男、72岁、使用碘普罗胺后出现恶心。实际口述只确认出现恶心。"
        report = deterministic_baseline(transcript)
        self.assertIsNone(report["patient"]["age"]["value"])
        self.assertIsNone(report["patient"]["sex"]["value"])
        self.assertIsNone(report["contrast"]["product"]["value"])
        self.assertEqual(
            [event["original_wording"] for event in report["events"] if event["original_wording"]],
            ["恶心"],
        )

    def test_hypothetical_discussion_is_not_patient_fact(self):
        transcript = "护士说：‘如果病人用了碘克沙醇，也许会有肿胀。’这只是讨论，不是本例事实。本例只明确出现头晕。"
        report = deterministic_baseline(transcript)
        self.assertIsNone(report["contrast"]["product"]["value"])
        self.assertEqual(
            [event["original_wording"] for event in report["events"] if event["original_wording"]],
            ["头晕"],
        )

    def test_corrected_uncertain_dose_is_not_backfilled(self):
        transcript = "先记录碘佛醇75毫升，随后口述者纠正为剂量不确定。"
        report = deterministic_baseline(transcript)
        self.assertEqual(report["contrast"]["product"]["value"], "碘佛醇")
        self.assertIsNone(report["contrast"]["dose"]["value"])
        self.assertEqual(report["contrast"]["dose"]["status"], "unclear")

    def test_missing_outcome_statement_is_not_an_outcome_value(self):
        transcript = "护士通知医生，转归没写。"
        report = empty_report(transcript)
        report["outcomes"] = [
            {"value": "转归没写", "status": "explicit", "source_text": "转归没写", "normalized_candidate": None}
        ]
        checked = apply_guardrails(report, transcript)
        self.assertFalse(any(item.get("value") for item in checked["outcomes"]))
        self.assertIn("outcome", checked["missing_required_fields"])

    def test_longer_grounded_outcome_suppresses_substring_duplicate(self):
        transcript = "观察三十分钟后症状缓解"
        raw = normalize_model_output({
            "outcomes": [{"value": "症状缓解", "status": "clear", "source_text": "症状缓解"}]
        })
        report = merge_template(raw, empty_report(transcript))
        report = merge_deterministic_evidence(report, deterministic_baseline(transcript))
        self.assertEqual([item["value"] for item in report["outcomes"]], ["症状缓解"])

    def test_event_source_is_verbatim(self):
        report = deterministic_baseline("注射后出现恶心和呕吐")
        for event in report["events"]:
            self.assertIn(event["source_text"], report["transcript"])

    def test_gemini_nested_items_are_normalized(self):
        raw = {
            "events": [{
                "type": {"value": "胃部不适", "status": "present", "source_text": "胃部不适"},
                "severity": {"value": "轻微不适", "source_text": "轻微不适"},
            }],
            "management_actions": [{
                "action": {"value": "通知医生", "status": "clear", "source_text": "通知医生"}
            }],
            "outcomes": [{"value": {"value": None, "status": "missing", "source_text": None}}],
        }
        normalized = normalize_model_output(raw)
        self.assertEqual(normalized["events"], [{
            "original_wording": "胃部不适",
            "status": "explicit",
            "source_text": "胃部不适",
            "normalized_candidate": None,
        }])
        self.assertEqual(normalized["management_actions"][0]["value"], "通知医生")
        self.assertEqual(normalized["outcomes"], [])
        self.assertNotIn("severity", normalized["events"][0])

    def test_missing_outcome_and_vital_sign_action_are_preserved(self):
        transcript = "注射后约十分钟出现喉部不适。护士测量并记录生命体征后通知医生，转归未在口述中说明。"
        raw = normalize_model_output({
            "events": [{"original_wording": "喉部不适", "status": "clear", "source_text": "喉部不适"}],
            "management_actions": [{"action": {"value": "通知医生", "status": "clear", "source_text": "通知医生"}}],
            "outcomes": [{"value": {"value": None, "status": "missing", "source_text": None}}],
        })
        report = merge_template(raw, empty_report(transcript))
        report = merge_deterministic_evidence(report, deterministic_baseline(transcript))
        checked = apply_guardrails(report, transcript)
        actions = {item["value"] for item in checked["management_actions"]}
        self.assertIn("测量并记录生命体征", actions)
        self.assertIn("通知医生", actions)
        self.assertIn("outcome", checked["missing_required_fields"])


if __name__ == "__main__":
    unittest.main()

