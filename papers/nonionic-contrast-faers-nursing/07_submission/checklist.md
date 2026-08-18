# Nursing Open submission package checklist

Updated: 2026-07-15

Target journal: Nursing Open
Article type: Empirical Research Quantitative
Submission route: Nursing Open first; Current Medical Science fallback if needed

## Current package status

- [ ] **Not submission-ready yet.**
- [x] Core analytical results have been stabilized around the rerun v10 SQL outputs.
- [x] Main manuscript has been revised toward Nursing Open's empirical quantitative format.
- [x] Main manuscript bracketed author-input markers have been removed or moved to the separate title page/checklists for double-blind review.
- [x] Separate title-page file exists for double-blind peer review.
- [ ] Author-dependent metadata, ethics/local-data decisions, FAERS import trace, final checklists and final file exports remain unresolved.

## One-sentence submission logic

This package can proceed only after the anonymized Nursing Open manuscript, separate title page, v10 table/supplement package, reporting checklists, source-data/code route and author/ethics declarations are all aligned without restoring superseded pre-v10 values.

## Manuscript files

### Main manuscript, anonymized

- [x] Working file: `03_manuscript/main.md`
- [x] Uses v10 SQL results for Results, Methods, Abstract, Discussion and Conclusion.
- [x] Structured abstract follows Nursing Open headings and is under 300 words.
- [x] FAERS inference boundaries are stated: no incidence, individual-level causality, comparative drug-safety ranking or nursing-intervention effectiveness.
- [x] Remove or mask bracketed author-input markers and author-identifying declaration placeholders from the anonymized main manuscript.
- [ ] Re-run final anonymization after DOCX export and after any local-data or ethics text is added.
- [ ] Export final editable submission file, likely `main_manuscript_anonymized.docx`.

### Separate title page

- [x] Working file: `03_manuscript/title-page.md`
- [x] Converted into a table-style author-input template.
- [ ] Add author names, degrees if required, affiliations and author order.
- [ ] Add corresponding author postal address, email and telephone if required.
- [ ] Add ORCID for each author.
- [ ] Add funding statement.
- [ ] Add conflict-of-interest statement.
- [ ] Add CRediT author contributions.
- [ ] Add acknowledgements or state not applicable.
- [ ] Confirm data/code availability route, local record decision, ethics statement and consent statement.
- [ ] Confirm patient/public contribution statement.
- [ ] Export final `title_page.docx`.

## Tables and source data

### Main-text tables

- [x] Table package file: `03_manuscript/tables/table-package-2026-07-15.md`
- [x] Table 1 sources:
  - `02_evidence/source-data/main-table1-analysis-overview-2026-07-15.tsv`
  - `02_evidence/source-data/main-table1b-pooled-report-characteristics-2026-07-15.tsv`
- [x] Table 2 source:
  - `02_evidence/source-data/main-table2-priority-pt-signals-top30-2026-07-15.tsv`
- [x] Table 3 source:
  - `02_evidence/source-data/main-table3-soc-signals-pooled-2026-07-15.tsv`
- [x] Table 4 source:
  - `02_evidence/source-data/main-table4-tto-summary-2026-07-15.tsv`
- [ ] Convert tables to journal-ready DOCX/XLSX format if the submission system requires separate upload.
- [ ] Run final MedDRA capitalization/standard-term pass if exported preferred-term names retain database casing.

### Supplementary tables

- [x] Supplementary Table S1: complete POOLED strict PT signal set, 230 rows.
  - `02_evidence/source-data/supp-table-s1-full-pooled-strict-pt-signals-2026-07-15.tsv`
- [x] Supplementary Table S2: complete SOC-level results across analysis groups, 131 rows.
  - `02_evidence/source-data/supp-table-s2-full-soc-signals-all-groups-2026-07-15.tsv`
- [x] Supplementary Table S3: complete strict PT signal set across analysis groups, 734 rows.
  - `02_evidence/source-data/supp-table-s3-full-strict-pt-signals-all-groups-2026-07-15.tsv`
- [x] Supplementary Table S4: TTO distribution, 31 rows.
  - `02_evidence/source-data/supp-table-s4-tto-distribution-2026-07-15.tsv`
- [x] Supplementary Table S5: report characteristics across analysis groups, 489 rows.
  - `02_evidence/source-data/supp-table-s5-report-characteristics-all-groups-2026-07-15.tsv`
- [ ] Decide whether these are uploaded as supplementary tables, repository source data, or both.

### Figures

- [ ] No final figure files are currently present in `04_figures/final/`.
- [ ] Decide whether Nursing Open submission needs a participant/report-flow figure.
- [ ] If a figure is added, provide editable source plus final upload file and legend.

## Reproducibility and data/code package

- [x] Data/code availability plan exists: `02_evidence/data-code-availability-plan-2026-07-15.md`
- [x] Anonymization/placeholder audit exists: `06_review/anonymization-placeholder-audit-2026-07-15.md`
- [x] v10 SQL output audit exists: `02_evidence/source-data/database-result-audit-2026-07-15.md`
- [x] Result-definition decision exists: `02_evidence/result-definition-decision-2026-07-15.md`
- [x] SQL and Weibull scripts are archived under `02_evidence/methods-source/sql/`.
- [ ] Provide FAERS/AEMS quarter-level file inventory for 2004 Q1-2025 Q4.
- [ ] Provide download dates, imported file names, and file sizes or hashes if available.
- [ ] Confirm upstream deduplication and deletion-file handling used to create `demo_clean`.
- [ ] Provide `drug_clean` construction rules or an exportable drug dictionary.
- [ ] Record exact MedDRA 28.0 imported filenames/package, import date and mapping notes for `meddra_soc` and `meddra_smq`.
- [ ] Choose data/code sharing route: supplementary files only, public repository, or both.
- [ ] Add repository DOI/accession if deposited.

## Ethics, local data and declarations

- [ ] Decide whether the local clinical nursing record component will be included, omitted, or left pending before submission.
- [ ] If included, complete `02_evidence/local-clinical-record-template.csv`.
- [ ] Provide local study period, department/institution, denominator, AE registry definition, nursing action fields, outcomes and missing-data profile.
- [ ] Provide ethics approval, exemption or quality-improvement determination for any local record component.
- [ ] Provide approval/exemption identifier and date if applicable.
- [ ] Provide consent-waiver or consent-not-required wording if local records are included.
- [ ] Confirm the final data availability statement.
- [ ] Confirm funding, conflict of interest, author contributions, acknowledgements and patient/public contribution statements.

## Reporting and reference checks

- [ ] Prepare STROBE checklist.
- [x] Prepare STROBE/RECORD working draft: `07_submission/strobe-record-checklist-draft-2026-07-15.md`.
- [x] Address non-local STROBE writing gaps in the main manuscript: bias boundaries, analysis-flow wording and TTO date-completeness note.
- [ ] Convert STROBE checklist into final upload format after DOCX export and page/line numbering.
- [ ] Prepare RECORD checklist if the electronic-health-record/local-record component remains in the final manuscript, or document why STROBE alone is used.
- [ ] Confirm whether the submission system requests any pharmacovigilance-specific supplementary transparency checklist.
- [ ] Finalize references in APA style after the reference set is locked.
- [ ] Confirm the current ACR Manual on Contrast Media version/year and citation route.
- [ ] Confirm ESUR guideline version and URL.
- [ ] Verify all remaining DOI/URL/reference metadata.

## Double-blind review checks

- [ ] Main manuscript contains no author names, affiliations, acknowledgements, grant numbers, IRB identifiers that reveal the institution, or repository names that identify the author group before review.
- [ ] Title page is uploaded separately.
- [ ] File names do not reveal author or institution identity.
- [ ] DOCX/PDF file properties and tracked changes are stripped before upload.
- [ ] Self-citations, if any, are written neutrally.
- [ ] Preprint status is checked because Nursing Open notes that preprints may compromise anonymity.

## Suggested upload set

1. `main_manuscript_anonymized.docx`
2. `title_page.docx`
3. `tables.docx` or `tables.xlsx`
4. `supplementary_tables_s1_s5.xlsx`
5. `source_data_package.zip` or repository DOI/accession
6. `analysis_code.zip` or repository DOI/accession
7. `strobe_checklist.docx`
8. `record_checklist.docx`, if applicable
9. Figure files and legends, if a final figure is added

## Go/no-go gate

Submission can move to final export only after these six items are complete:

- [ ] Local clinical nursing record decision and ethics/consent wording.
- [ ] FAERS import trace and upstream deduplication/deletion-file documentation.
- [ ] Drug dictionary and MedDRA import trace.
- [ ] Author/title-page metadata and declarations.
- [ ] Reporting checklist files.
- [ ] Final anonymization, reference formatting and file export checks.
