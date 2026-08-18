# Anonymization and placeholder audit

Date: 2026-07-15

Target journal: Nursing Open

## One-sentence audit conclusion

The main manuscript has been moved closer to a double-blind review file by removing author-identifying declaration placeholders and converting unresolved institution/local-data items into non-identifying boundary statements; remaining author-dependent items are tracked primarily in the separate title page and submission checklist.

## Actions completed

- Removed author-identifying funding, conflict-of-interest, CRediT and acknowledgement placeholders from the anonymized main manuscript and redirected these declarations to the separate title page.
- Removed bracketed author-input markers from the main manuscript where the issue can be described without guessing data.
- Kept local clinical nursing record content explicitly conditional and retained as placeholders because the user instructed that local-data placeholders should remain.
- Kept FAERS import trace, MedDRA import trace, drug dictionary, repository route and local ethics decisions as submission-blocking author inputs in `07_submission/checklist.md` and `02_evidence/missing-inputs.md`.
- Kept the title page as the location for author identity, affiliations, ORCID, funding, conflict of interest, author contributions, acknowledgements and institution-identifying ethics details.

## Remaining submission blockers

- Author names, affiliations, corresponding author details and ORCID.
- Funding, conflict of interest, CRediT contributions and acknowledgements.
- Local clinical nursing record data: placeholders retained pending author supply of denominator, fields, ethics pathway and consent status.
- Local ethics/exemption/quality-improvement determination and consent wording if the local component remains.
- FAERS quarter-level file inventory, download dates, import status and deletion-file handling.
- `drug_clean` dictionary/construction rules and MedDRA imported-file trace.
- Repository/supplementary-file route for source data and code.
- Final STROBE/RECORD checklist files.

## Double-blind risk notes

- The main manuscript still discusses a local record component as a retained placeholder. Institution-identifying details should be confined to title-page/submission metadata unless the journal instructs otherwise.
- A public repository can compromise double-blind review if it reveals author identity. If repository deposition is used before acceptance, use a blinded repository route or consult the journal submission system instructions.
- DOCX/PDF file properties and tracked changes should be stripped during final export.
