from __future__ import annotations

import sys
import unittest
from pathlib import Path

SYSTEM = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(SYSTEM / "app"))

from providers import ProviderError, retry_delay_seconds  # noqa: E402


class RetryGuidanceTests(unittest.TestCase):
    def test_retry_after_header_is_preferred(self):
        self.assertEqual(retry_delay_seconds({"Retry-After": "12.5"}, ""), 12.5)

    def test_google_retry_delay_is_parsed(self):
        detail = '{"error":{"details":[{"retryDelay":"45.065s"}]}}'
        self.assertEqual(retry_delay_seconds({}, detail), 45.065)

    def test_plain_retry_message_is_parsed(self):
        self.assertEqual(retry_delay_seconds({}, "Please retry in 7.25s."), 7.25)

    def test_provider_error_defaults_to_non_retryable(self):
        error = ProviderError("invalid JSON")
        self.assertFalse(error.retryable)
        self.assertIsNone(error.retry_after)


if __name__ == "__main__":
    unittest.main()
