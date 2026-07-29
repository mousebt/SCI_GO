from __future__ import annotations

import argparse
import json
import mimetypes
import sys
import traceback
from http import HTTPStatus
from http.server import BaseHTTPRequestHandler, ThreadingHTTPServer
from pathlib import Path


APP_DIR = Path(__file__).resolve().parent
STATIC_DIR = APP_DIR / "static"
sys.path.insert(0, str(APP_DIR))

from core import ProviderError, confirm_report, generate_report  # noqa: E402


class Handler(BaseHTTPRequestHandler):
    server_version = "ContrastAERAG/1.0"

    def _json(self, status: int, payload: dict) -> None:
        body = json.dumps(payload, ensure_ascii=False).encode("utf-8")
        self.send_response(status)
        self.send_header("Content-Type", "application/json; charset=utf-8")
        self.send_header("Content-Length", str(len(body)))
        self.send_header("Cache-Control", "no-store")
        self.end_headers()
        self.wfile.write(body)

    def _read_json(self) -> dict:
        length = int(self.headers.get("Content-Length", "0"))
        if length > 2_000_000:
            raise ValueError("Request too large")
        return json.loads(self.rfile.read(length).decode("utf-8"))

    def do_GET(self) -> None:
        if self.path == "/api/health":
            self._json(HTTPStatus.OK, {"status": "ok", "version": "1.0.0"})
            return
        relative = "index.html" if self.path in {"/", ""} else self.path.lstrip("/")
        target = (STATIC_DIR / relative).resolve()
        if STATIC_DIR not in target.parents and target != STATIC_DIR:
            self.send_error(HTTPStatus.FORBIDDEN)
            return
        if not target.is_file():
            self.send_error(HTTPStatus.NOT_FOUND)
            return
        content = target.read_bytes()
        self.send_response(HTTPStatus.OK)
        self.send_header("Content-Type", mimetypes.guess_type(target.name)[0] or "application/octet-stream")
        self.send_header("Content-Length", str(len(content)))
        self.end_headers()
        self.wfile.write(content)

    def do_POST(self) -> None:
        try:
            payload = self._read_json()
            if self.path == "/api/generate":
                transcript = str(payload.get("transcript", ""))
                use_llm = bool(payload.get("use_llm", True))
                report = generate_report(transcript, use_llm=use_llm)
                self._json(HTTPStatus.OK, {"report": report})
                return
            if self.path == "/api/confirm":
                report = payload.get("report")
                if not isinstance(report, dict):
                    raise ValueError("report must be an object")
                confirmed = confirm_report(report, str(payload.get("nurse_name", "")))
                self._json(HTTPStatus.OK, {"report": confirmed})
                return
            self._json(HTTPStatus.NOT_FOUND, {"error": "Unknown endpoint"})
        except (ValueError, ProviderError, json.JSONDecodeError) as exc:
            self._json(HTTPStatus.BAD_REQUEST, {"error": str(exc)})
        except Exception:
            traceback.print_exc()
            self._json(HTTPStatus.INTERNAL_SERVER_ERROR, {"error": "Internal server error"})

    def log_message(self, fmt: str, *args) -> None:
        print(f"[server] {self.address_string()} {fmt % args}")


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("--host", default="127.0.0.1")
    parser.add_argument("--port", default=8765, type=int)
    args = parser.parse_args()
    server = ThreadingHTTPServer((args.host, args.port), Handler)
    print(f"Contrast-AE Voice RAG running at http://{args.host}:{args.port}")
    print("Use synthetic/de-identified data only unless institutional approval covers the configured provider.")
    try:
        server.serve_forever()
    except KeyboardInterrupt:
        pass
    finally:
        server.server_close()


if __name__ == "__main__":
    main()

