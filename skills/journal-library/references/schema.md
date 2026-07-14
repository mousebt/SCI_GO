# Journal library schema

Use `journals/journal-index.csv` as the global index. Required columns:

- `slug`: stable lowercase identifier.
- `journal_name`: official journal name.
- `issn`, `eissn`: journal identifiers when available.
- `publisher`: publisher or society.
- `field_scope`: short scope tags.
- `sci_status`: SCI/SCIE status and verification note.
- `jif_year`, `jif`: latest verified Journal Impact Factor.
- `apc_amount`, `apc_currency`: mandatory or optional APC price; use `unknown` if not verified.
- `publication_model`: subscription, hybrid, fully open access, or other official model.
- `subscription_no_fee`: whether a non-OA no-APC route exists.
- `official_author_url`, `official_apc_url`: official URLs.
- `raw_pages_dir`: archive folder.
- `requirements_doc`: extracted author-instruction document.
- `difficulty_score_1_easy_5_hard`: evidence-based estimate, lower is easier.
- `acceptance_rate`: official rate when available.
- `fit_notes`: short manuscript-fit note.
- `last_checked`, `next_review`: freshness control.
- `status`: draft, seeded, verified, stale, rejected, or retired.

Never silently replace raw official pages. Add a new dated capture and update source logs.

