# Author input and verification checklist

Updated: 2026-07-28

This checklist reflects the current v10 SQL-based manuscript. Superseded items from the earlier Chinese-source draft, including the 24-vs-230 PT discrepancy, 9-SOC placeholder, 12,588 TTO denominator and 81.56% TTO value, have been resolved in favour of the rerun database outputs.

## A. Resolved analytical items

- v10 POOLED analysis-base reports: 14,781.
- v10 POOLED PT records after filters: 42,811.
- POOLED PT rows meeting the minimum case threshold: 951.
- Full POOLED strict four-algorithm PT signal count: 230.
- Main-text PT display rule: top 30 POOLED strict signals with at least 10 reports, ranked by EBGM05.
- POOLED SOC strict four-algorithm signals: 2, immune system disorders and skin and subcutaneous tissue disorders.
- POOLED TTO rows: 9,069; same-day 8,010 (88.32%); within 1 day 8,450 (93.17%).
- Weibull pooled parameters: beta 0.686271 and scale 0.958471 days.
- SQL and Weibull scripts are archived in `02_evidence/methods-source/sql/`.
- Main and supplementary table source files are exported in `02_evidence/source-data/`.
- Core reference set has been rebuilt and partially verified in `reference-rebuild-audit-2026-07-15.md`.

## B. Submission-critical author inputs

These items should not be guessed by an assistant.

1. **FAERS import trace**
   - Quarter-level file inventory for 2004 Q1-2025 Q4.
   - Download dates, file names, file sizes or hashes if available.
   - Confirmation that 2025 Q4 was downloaded, imported and included.
   - Upstream construction of `demo_clean`.
   - Exact CASEID/FDA_DT/PRIMARYID follow-up-version deduplication logic.
   - Deletion-file ingestion and application procedure, including pre/post-dedup record counts.
   - The analysis-layer DISTINCT logic is verified in `faers-cleaning-boundary-audit-2026-07-28.md`; it does not resolve these upstream items.

2. **Drug dictionary and MedDRA trace**
   - `drug_clean` construction rules or exportable drug dictionary.
   - Brand names, spelling variants, salts and exclusion terms for ioversol, iohexol, iopamidol and iodixanol.
   - Exact MedDRA 28.0 imported file names/package, import date and mapping notes for `meddra_soc` and `meddra_smq`.
   - Confirmation that MedDRA source files will not be redistributed if licence restrictions apply.

3. **Local suspected contrast-related event registry and documentation-gap evidence**
   - Verify the author-reported five-year local total of 39 registered contrast-related AEs.
   - Complete `02_evidence/local-clinical-record-template.csv` using aggregate/text-entered summaries only.
   - Provide exact local study dates, department/institution, registry or form name, authorised data route and the role of the person performing retrieval.
   - Document how records were located: register review, search terms if applicable, and whether another authorised source was used for cross-checking.
   - Finalise inclusion and exclusion criteria, duplicate-episode/version handling and the operational definition of a suspected contrast-related event.
   - Do not exclude records merely because fields are incomplete; code those fields as missing or ambiguous.
   - Provide aggregate event categories only after the source and coding route are verified.
   - Provide field-completeness counts among the 39 events: suspected ICM agent, timing/onset, symptoms, management, escalation, outcome, reporter role and standard terminology availability.
   - Provide relationship-completeness counts for product-event, administration-event timing, event-escalation, event-management and event-outcome links.
   - Confirm two independent reviewers, reviewer roles, disagreement resolution, raw agreement and any suitable Cohen's kappa estimate with confidence interval; do not impose a target kappa threshold.
   - Provide denominator availability if total non-ionic ICM administrations can be verified; denominator is optional for the reporting-framework argument.
   - Handwritten ADR image transcription is no longer part of the active workflow per the 2026-07-28 user instruction; do not use image-derived transcription unless the user explicitly reopens image processing.

4. **Ethics and consent**
   - Institutional ethics approval, exemption or quality-improvement determination for the local component.
   - Approval/exemption identifier and date if applicable.
   - Consent requirement or consent-waiver wording for local records.
   - Confirm the permitted aggregate-data sharing route and the anonymised wording required by double-blind review.

5. **Data/code availability**
   - Choose supplementary-file-only sharing, public repository deposition or both.
   - Repository name and DOI/accession if deposited.
   - Confirm whether the `drug_clean` dictionary or construction rules can be shared.
   - Confirm local-data access wording if local records are included.

6. **Stakeholder confirmation and future validation**
   - Confirm whether radiology nurses and relevant nursing-quality, pharmacy, pharmacovigilance or radiology stakeholders can review field relevance, clarity, feasibility and approval responsibilities.
   - Do not describe stakeholder confirmation as formal consensus unless a recognised consensus method is actually used.
   - Keep usability, workload, source fidelity and reporting-rate effects as future outcomes until prospectively tested.

7. **Author and submission metadata**
   - Author names, degrees if required, affiliations and author order.
   - Corresponding author postal address, email and telephone if required.
   - ORCID for each author.
   - Funding statement.
   - Conflict-of-interest statement.
   - CRediT author contributions.
   - Acknowledgements or statement that none are applicable.
   - Confirmation of no patient or public contribution, unless such contribution can be documented.

## C. Final formatting and verification tasks

- Confirm current ACR Manual on Contrast Media version/year and whether to cite the PDF or landing page.
- Confirm ESUR guideline version and URL.
- Format references to the final Nursing Open/APA style after the final reference set is locked.
- Prepare or upload STROBE and RECORD checklist files if required by the submission system.
- Final pass for anonymization because Nursing Open uses double-blind peer review.

## D. Items not to restore without new evidence

- Do not restore claims that 24 is the SQL-derived full strict PT signal count; v10 supports 230 as the full POOLED strict set.
- Do not restore old TTO values of 12,588 or 81.56%.
- Do not present 50% magnesium sulphate, traditional Chinese medicines, potato slices, fixed oral-fluid volumes, universal medication cessation or a fixed observation period as recommendations unless supported by current guidance and the applicable clinical context.
- Do not claim incidence, individual-level causality, comparative safety between agents or effectiveness of nursing interventions from FAERS data.
