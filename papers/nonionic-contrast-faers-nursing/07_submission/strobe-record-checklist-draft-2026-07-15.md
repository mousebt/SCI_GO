# STROBE / RECORD checklist working draft

Date: 2026-07-15

Target journal: Nursing Open
Article type: Empirical Research Quantitative
Manuscript file checked: `03_manuscript/main.md`

## Working decision

Use STROBE as the primary reporting checklist for the observational pharmacovigilance manuscript. Use RECORD as a supplementary reporting lens only for routinely collected local clinical/nursing records if that component is retained in the final submission.

If the local record component is omitted before submission, RECORD should not be presented as a full formal checklist unless the journal specifically requests it.

## One-sentence reporting logic

The current main manuscript already reports the observational design, data source, signal definitions, time-to-onset methods, main results and limitations, but submission readiness still depends on finalizing the local-data decision, ethics/consent wording, FAERS import trace, drug dictionary/MedDRA trace, and final data/code availability route.

## STROBE checklist draft

| STROBE item | Reporting focus | Current manuscript location | Status | Action before submission |
|---|---|---|---|---|
| 1 | Title/abstract identify the study design and summarize what was done and found | Title; Abstract Design, Data Sources, Methods, Results, Conclusion | Mostly complete | After final title decision, confirm the title remains under Nursing Open requirements and the abstract remains under 300 words |
| 2 | Explain scientific background and rationale | Introduction | Complete for current scope | None unless local component is omitted, then remove local-context framing |
| 3 | State specific objectives | End of Introduction; Abstract Aim(s) | Complete | None |
| 4 | Present key elements of study design early | Methods 2.1 Design; Abstract Design | Complete | None |
| 5 | Describe setting, locations and relevant dates | Methods 2.2 Data source; Methods 2.3 Local clinical nursing record source | Partial | Add final FAERS download/import inventory; finalize or omit local study period and site description |
| 6 | Define participants/reports and eligibility criteria | Methods 2.4 FAERS report identification and deduplication | Partial | Add supplementary deduplication/deletion-file workflow and drug-cleaning dictionary or rules |
| 7 | Clearly define variables, outcomes, exposures and diagnostic/classification criteria | Methods 2.5-2.8 | Partial | Add exact MedDRA imported-file trace; finalize local AE definitions if local component remains |
| 8 | Describe data sources and measurement methods | Methods 2.2, 2.5, 2.7, 2.8 | Partial | Add FAERS import log, MedDRA package/import date and local source-system details if retained |
| 9 | Describe efforts to address bias | Introduction limitations of FAERS; Methods 2.4-2.7; Discussion 4.6 | Mostly complete | Finalize supplementary deduplication/deletion-file documentation |
| 10 | Explain study size | Results 3.1; Methods 2.6 and 2.7 | Complete for FAERS | Add local denominator or state local data omitted |
| 11 | Explain quantitative variables and grouping | Methods 2.6, 2.7; Results 3.1-3.5 | Mostly complete | Add any local grouping rules if local component remains |
| 12 | Describe statistical methods | Methods 2.6-2.7; Methods 2.10 | Complete for FAERS | Add software/package information to final source-data/code supplement if required |
| 13 | Report numbers at each stage | Results 3.1; Table 1; planned tables | Mostly complete | Create a final flow diagram only if required by layout or submission review |
| 14 | Provide descriptive data and missingness | Results 3.1; Table 1; Supplementary Table S5; Results 3.5; Discussion 4.6 | Mostly complete | Add TTO missing-date note to final table footnote during DOCX/XLSX export |
| 15 | Report outcome/event data | Results 3.2-3.5; Tables 2-4; Supplementary Tables S1-S4 | Complete for FAERS | None unless local component is retained |
| 16 | Report main results with estimates and precision where appropriate | Results 3.2-3.5; Tables 2-4 | Complete for disproportionality outputs | Check table formatting after DOCX/XLSX export |
| 17 | Report other analyses | Agent-specific outputs; supplementary tables | Mostly complete | Confirm whether agent-specific outputs are supplementary only and not interpreted as comparative safety |
| 18 | Summarize key results in relation to objectives | Discussion 4.1; Conclusion | Complete | None |
| 19 | Discuss limitations | Discussion 4.6; inference boundary near top of manuscript | Complete | Keep limitation language if local component is omitted or revised |
| 20 | Give cautious overall interpretation | Discussion 4.1-4.5; Conclusion | Complete | None |
| 21 | Discuss generalizability | Discussion 4.6; Conclusion | Mostly complete | Add local single-centre limitation if local component remains |
| 22 | State funding role | Main manuscript redirects to title page; title page template has funding fields | Pending | Complete title page funding statement |

## RECORD supplementary checklist draft

Use this section only if the local clinical/nursing record component remains, or if the submission system asks for RECORD because routinely collected health data are discussed.

| RECORD item | Reporting focus | Current manuscript location | Status | Action before submission |
|---|---|---|---|---|
| RECORD 1 | Title/abstract should make routinely collected data use clear where relevant | Abstract Results notes local data pending; Methods 2.3 | Pending | If local data remain, state the local record component in the abstract without naming the institution in the blinded main file |
| RECORD 4-6 | Describe data sources, study population selection and codes/algorithms | Methods 2.3, 2.8 | Pending | Add local source systems, inclusion criteria, extraction logic and any codes/terms used |
| RECORD 7 | Provide complete code lists or algorithms for exposures/outcomes/confounders | Methods 2.8; planned local template | Pending | Add local AE definitions, mapping rules and any extraction code list as supplement |
| RECORD 12 | Describe data access, linkage, cleaning and processing | Data/code availability; Methods 2.3 and 2.8 | Pending | Add who extracted local records, how records were de-identified, and whether linkage was performed |
| RECORD 13 | Present numbers at each stage of data selection | Results 3.6 | Pending | Add local denominator, included AE records, exclusions and missing records, or omit the local component |
| RECORD 14 | Report data quality and completeness | Results 3.6; Discussion 4.6 | Pending | Add documentation completeness and missing-data profile from local extraction |
| RECORD 19 | Discuss limitations of routinely collected data | Discussion 4.6 | Partial | If local data remain, add specific limitations on documentation quality, event definitions and site-specific practice |
| RECORD 22 | Provide access route for protocol, code, code lists and algorithms | Data/code availability; title page data/code fields | Pending | Decide supplementary files, repository, or controlled-access route |

## Current readiness summary

| Area | Status | Reason |
|---|---|---|
| STROBE core manuscript structure | Mostly ready | Design, data source, methods, results, limitations, bias boundaries, missing-date handling and interpretation are present |
| STROBE item 22 funding | Not ready | Author funding statement is still missing from title page |
| STROBE data-source reproducibility | Not ready | FAERS quarter inventory, download dates, deletion-file handling and import trace remain author inputs |
| RECORD formal checklist | Conditional | Needed only if local routinely collected clinical/nursing record component remains |
| Local record component | Not ready | Institution, study period, denominator, data fields, ethics and consent are not finalized |
| Submission file formatting | Not ready | Page/line numbers cannot be finalized until DOCX export |

## Items to fix before final checklist upload

- Finalize whether the local clinical/nursing record component is included or omitted.
- Add FAERS quarter-level file inventory, download dates, import status and deletion-file handling documentation.
- Add `drug_clean` dictionary/construction rules and MedDRA imported-file trace.
- Add ethics/exemption/quality-improvement and consent wording for any local record component.
- Complete title-page funding statement and author declarations.
- Export final DOCX and replace section-level locations in this working draft with page and line numbers if the submission system requests them.
