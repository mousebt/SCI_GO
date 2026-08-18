from __future__ import annotations

import json
import os
import re
import urllib.error
import urllib.request
from pathlib import Path
from typing import Any


ROOT = Path(__file__).resolve().parents[5]


def load_dotenv(path: Path | None = None) -> None:
    env_path = path or ROOT / ".env"
    if not env_path.exists():
        return
    for raw in env_path.read_text(encoding="utf-8-sig").splitlines():
        line = raw.strip()
        if not line or line.startswith("#") or "=" not in line:
            continue
        key, value = line.split("=", 1)
        key = key.strip()
        if key and key not in os.environ:
            os.environ[key] = value.strip().strip('"').strip("'")


PROVIDERS = {
    "gemini": {
        "key": "GEMINI_API_KEY",
        "base": "GEMINI_BASE_URL",
        "model": "GEMINI_MODEL",
        "default_base": "https://generativelanguage.googleapis.com/v1beta",
        "default_model": "gemini-2.5-flash",
    },
    "deepseek": {
        "key": "DEEPSEEK_API_KEY",
        "base": "DEEPSEEK_BASE_URL",
        "model": "DEEPSEEK_MODEL",
        "default_base": "https://api.deepseek.com",
        "default_model": "deepseek-chat",
    },
    "zhipu": {
        "key": "ZHIPU_API_KEY",
        "base": "ZHIPU_BASE_URL",
        "model": "ZHIPU_MODEL",
        "default_base": "https://open.bigmodel.cn/api/paas/v4",
        "default_model": "glm-4-flash",
    },
    "openrouter": {
        "key": "OPENROUTER_KEY",
        "base": "OPENROUTER_BASE_URL",
        "model": "OPENROUTER_MODEL",
        "default_base": "https://openrouter.ai/api/v1",
        "default_model": "openai/gpt-4.1-mini",
    },
    "local": {
        "key": None,
        "base": "LOCAL_LLM_BASE_URL",
        "model": "LOCAL_LLM_MODEL",
        "default_base": "http://127.0.0.1:11434/v1",
        "default_model": "local-model",
    },
}


class ProviderError(RuntimeError):
    def __init__(self, message: str, *, retryable: bool = False, retry_after: float | None = None):
        super().__init__(message)
        self.retryable = retryable
        self.retry_after = retry_after


def retry_delay_seconds(headers: Any, detail: str) -> float | None:
    """Read Google/OpenAI-compatible retry guidance without exposing credentials."""
    value = headers.get("Retry-After") if headers else None
    if value:
        try:
            return max(0.0, float(value))
        except (TypeError, ValueError):
            pass
    for pattern in (r'"retryDelay"\s*:\s*"([0-9.]+)s"', r"retry in ([0-9.]+)s"):
        match = re.search(pattern, detail, re.IGNORECASE)
        if match:
            return max(0.0, float(match.group(1)))
    return None


def select_provider() -> tuple[str, dict[str, str]]:
    load_dotenv()
    forced = os.getenv("CONTRAST_RAG_LLM_PROVIDER", "").lower().strip()
    order = [forced] if forced else ["gemini", "deepseek", "zhipu", "openrouter", "local"]
    for name in order:
        if name not in PROVIDERS:
            continue
        cfg = PROVIDERS[name]
        key_name = cfg["key"]
        base = os.getenv(cfg["base"] or "", cfg["default_base"]).rstrip("/")
        key = os.getenv(key_name, "") if key_name else ""
        if name == "local":
            if os.getenv("LOCAL_LLM_BASE_URL"):
                return name, {
                    "base": base,
                    "key": key,
                    "model": os.getenv(cfg["model"], cfg["default_model"]),
                }
        elif key:
            return name, {
                "base": base,
                "key": key,
                "model": os.getenv(cfg["model"], cfg["default_model"]),
            }
    raise ProviderError(
        "No configured LLM provider. Set one of GEMINI_API_KEY, DEEPSEEK_API_KEY, "
        "ZHIPU_API_KEY, OPENROUTER_KEY or LOCAL_LLM_BASE_URL."
    )


def chat_json(system_prompt: str, user_prompt: str, timeout: int = 90) -> tuple[dict[str, Any], dict[str, str]]:
    provider, cfg = select_provider()
    if provider == "gemini":
        url = f"{cfg['base']}/models/{cfg['model']}:generateContent"
        payload = {
            "systemInstruction": {"parts": [{"text": system_prompt}]},
            "contents": [{"role": "user", "parts": [{"text": user_prompt}]}],
            "generationConfig": {
                "temperature": 0,
                "maxOutputTokens": 2500,
                "responseMimeType": "application/json",
                "thinkingConfig": {"thinkingBudget": 0},
            },
        }
        request = urllib.request.Request(
            url,
            data=json.dumps(payload, ensure_ascii=False).encode("utf-8"),
            headers={"Content-Type": "application/json", "x-goog-api-key": cfg["key"]},
            method="POST",
        )
        try:
            with urllib.request.urlopen(request, timeout=timeout) as response:
                body = json.loads(response.read().decode("utf-8"))
        except urllib.error.HTTPError as exc:
            detail = exc.read().decode("utf-8", errors="replace")[:800]
            retryable = exc.code == 429 or 500 <= exc.code < 600
            raise ProviderError(
                f"gemini HTTP {exc.code}: {detail}",
                retryable=retryable,
                retry_after=retry_delay_seconds(exc.headers, detail),
            ) from exc
        except urllib.error.URLError as exc:
            raise ProviderError(
                f"gemini connection failed: {exc.reason}", retryable=True
            ) from exc
        try:
            parts = body["candidates"][0]["content"]["parts"]
            content = "".join(part.get("text", "") for part in parts)
            parsed = json.loads(content)
        except (KeyError, IndexError, TypeError, json.JSONDecodeError) as exc:
            raise ProviderError("Gemini response was not a valid JSON object") from exc
        return parsed, {"provider": provider, "model": cfg["model"]}

    url = cfg["base"]
    if not url.endswith("/chat/completions"):
        url += "/chat/completions"
    payload = {
        "model": cfg["model"],
        "temperature": 0,
        "max_tokens": 2500,
        "messages": [
            {"role": "system", "content": system_prompt},
            {"role": "user", "content": user_prompt},
        ],
        "response_format": {"type": "text"} if provider == "local" else {"type": "json_object"},
    }
    if provider == "local":
        payload["chat_template_kwargs"] = {"enable_thinking": False}
        payload["reasoning_effort"] = "none"
    headers = {"Content-Type": "application/json"}
    if cfg["key"]:
        headers["Authorization"] = f"Bearer {cfg['key']}"
    if provider == "openrouter":
        headers["HTTP-Referer"] = "http://localhost"
        headers["X-Title"] = "Contrast-AE Voice RAG research prototype"
    request = urllib.request.Request(
        url,
        data=json.dumps(payload, ensure_ascii=False).encode("utf-8"),
        headers=headers,
        method="POST",
    )
    try:
        with urllib.request.urlopen(request, timeout=timeout) as response:
            body = json.loads(response.read().decode("utf-8"))
    except urllib.error.HTTPError as exc:
        detail = exc.read().decode("utf-8", errors="replace")[:800]
        retryable = exc.code == 429 or 500 <= exc.code < 600
        raise ProviderError(
            f"{provider} HTTP {exc.code}: {detail}",
            retryable=retryable,
            retry_after=retry_delay_seconds(exc.headers, detail),
        ) from exc
    except urllib.error.URLError as exc:
        raise ProviderError(
            f"{provider} connection failed: {exc.reason}", retryable=True
        ) from exc
    try:
        content = body["choices"][0]["message"]["content"]
        try:
            parsed = json.loads(content)
        except json.JSONDecodeError:
            fenced = re.search(r"```(?:json)?\s*(\{.*\})\s*```", content, re.DOTALL | re.IGNORECASE)
            if not fenced:
                raise
            parsed = json.loads(fenced.group(1))
    except (KeyError, IndexError, TypeError, json.JSONDecodeError) as exc:
        raise ProviderError("LLM response was not a valid JSON object") from exc
    meta = {"provider": provider, "model": cfg["model"]}
    return parsed, meta



