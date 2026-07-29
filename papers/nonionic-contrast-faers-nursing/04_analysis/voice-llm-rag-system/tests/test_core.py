from __future__ import annotations

import sys
import unittest
from pathlib import Path

SYSTEM = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(SYSTEM / "app"))

from core import KnowledgeBase, apply_guardrails, confirm_report, deterministic_baseline, empty_report  # noqa: E402


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

    def test_event_source_is_verbatim(self):
        report = deterministic_baseline("注射后出现恶心和呕吐")
        for event in report["events"]:
            self.assertIn(event["source_text"], report["transcript"])


if __name__ == "__main__":
    unittest.main()

