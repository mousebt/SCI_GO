# Global journal library

This directory stores reusable journal intelligence for all manuscript projects in this workspace.
It is global on purpose: journal facts, APC routes, official author instructions, and submission-fit judgments should be reusable across papers.

## Start command

Use this instruction in chat:

`启动期刊库：为 <期刊名称或候选列表> 建立或更新全局期刊档案，并保存官网原始页面。`

For manual shell startup, use:

```powershell
powershell -ExecutionPolicy Bypass -File scripts/new-journal-entry.ps1 -Name "<Journal name>" -Slug "<journal-slug>"
```

Then archive official pages:

```powershell
powershell -ExecutionPolicy Bypass -File scripts/archive-journal-pages.ps1 -Slug "<journal-slug>" -Urls "<official-url-1>","<official-url-2>"
```

## Structure

| Path | Purpose |
|---|---|
| `journal-index.csv` | Global machine-readable index. One row per journal. |
| `profiles/` | Human-readable journal profile and decision notes. |
| `requirements/` | Extracted author requirements from official pages. |
| `raw_pages/` | Archived official HTML pages and fetch metadata. |
| `official-source-log.csv` | Audit trail for every official page captured. |

## Required evidence rules

- Use official journal or publisher pages for APC, publication model, aims and scope, author instructions, article types, and submission requirements.
- IF/JIF must be sourced from JCR, the publisher page, Web of Science, or a clearly labeled secondary source if official JCR access is unavailable.
- Difficulty is an estimate, not a fact. It must state evidence such as acceptance rate, scope mismatch, article type constraints, peer-review selectivity, APC barrier, publication volume, and recent comparable papers.
- Keep the raw official page under `raw_pages/<journal-slug>/` before summarizing requirements.
- Recheck APC, IF/JIF, OA status, and author requirements before each actual submission.

## Source-log status values

| Status | Meaning |
|---|---|
| `ok` | Official page was captured with a successful HTTP status and can be used for requirement extraction. |
| `manual_ok` | Official page was saved through an interactive browser and imported; it can be used for requirement extraction. |
| `blocked_http` | A raw server response was saved, but the publisher returned a non-success status such as 403; do not use it as requirement evidence. |
| `failed` | No raw page was saved. Retry later or use a browser/manual export route. |

For `blocked_http` or `failed`, keep the log row as audit evidence and recapture the official page before submission.
