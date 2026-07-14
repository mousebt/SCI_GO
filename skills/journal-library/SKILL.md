---
name: journal-library
description: Build and maintain a reusable SCI journal intelligence library for manuscript targeting. Use when the user asks to create, update, compare, or preserve journal records, APC/IF/publication-mode data, official author instructions, raw official pages, journal difficulty estimates, target-journal libraries, 投稿期刊库, 杂志库, 期刊评估库, 官网投稿要求, APC, IF, or journal submission requirements.
---

# Journal Library

## Core rule

Maintain journal intelligence as reusable evidence, not chat memory. Store structured facts in `journals/journal-index.csv`, human-readable notes in `journals/profiles/`, extracted requirements in `journals/requirements/`, and official raw pages in `journals/raw_pages/`.

## Startup command

When the user says:

`启动期刊库：为 <期刊名称或候选列表> 建立或更新全局期刊档案，并保存官网原始页面。`

execute this workflow.

## Workflow

1. Read `journals/README.md` and `skills/journal-library/references/schema.md`.
2. For each journal, create or update a row with `scripts/new-journal-entry.ps1`.
3. Browse or fetch official publisher/journal pages for aims and scope, author guidelines, APC/OA policy, article types, and submission rules.
4. Save raw official pages with `scripts/archive-journal-pages.ps1` whenever network access is available.
5. Extract requirements into `journals/requirements/<slug>.md`; cite the archived raw page path for each requirement area.
6. Update `journals/profiles/<slug>.md` with match, desk-reject risks, difficulty evidence, and recheck date.
7. Update `journal-index.csv` last, after the profile and requirement document are consistent.

If the source log records `blocked_http` or `failed`, state that the page is not usable as requirement evidence and request or perform a browser/manual capture before final submission checks.

## Evidence standards

- Prefer official publisher or journal pages.
- Use JCR/Web of Science, publisher pages, or clearly labeled secondary sources for IF/JIF.
- Treat acceptance probability and difficulty as estimates. Explain the evidence and uncertainty.
- Recheck APC, IF/JIF, OA route, and author instructions before actual submission.
- Do not overwrite archived raw pages. Capture a new dated copy when pages change.

## Difficulty scale

Use 1 to 5, where 1 is easiest and 5 is hardest. Base the score on scope fit, article-type fit, acceptance-rate evidence, publication model, APC barrier, recent comparable articles, and likely desk-reject risk.

## Useful commands

Create an entry:

```powershell
powershell -ExecutionPolicy Bypass -File scripts/new-journal-entry.ps1 -Name "<Journal name>" -Slug "<journal-slug>"
```

Archive official pages:

```powershell
powershell -ExecutionPolicy Bypass -File scripts/archive-journal-pages.ps1 -Slug "<journal-slug>" -Urls "<official-url-1>","<official-url-2>"
```
