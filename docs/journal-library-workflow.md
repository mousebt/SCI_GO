# Journal library workflow

## Startup instruction

Say:

`启动期刊库：为 <期刊名称或候选列表> 建立或更新全局期刊档案，并保存官网原始页面。`

This triggers the `journal-library` skill in this repository.

## Workflow

1. Create or update the journal row in `journals/journal-index.csv`.
2. Archive official pages into `journals/raw_pages/<journal-slug>/`.
3. Record every captured URL in `journals/official-source-log.csv`.
4. Extract author requirements into `journals/requirements/<journal-slug>.md`.
5. Write the human-readable profile in `journals/profiles/<journal-slug>.md`.
6. Recheck IF/JIF, APC, publication model, and submission rules before any real submission.

If a publisher blocks automated capture, keep the `blocked_http` or `failed` source-log row and use a browser/manual export route later. Do not summarize blocked pages as if they were usable author instructions.

## Difficulty scale

| Score | Meaning |
|---|---|
| 1 | Very low difficulty for a matching paper; broad scope, high publication volume, low desk-reject risk. |
| 2 | Relatively low difficulty; some fit constraints but manageable. |
| 3 | Moderate difficulty; match must be actively shaped. |
| 4 | High difficulty; meaningful desk-reject or peer-review risk. |
| 5 | Very high difficulty or poor match for the current manuscript type. |

Difficulty is never an official fact. It is an evidence-based estimate and must explain its basis.
