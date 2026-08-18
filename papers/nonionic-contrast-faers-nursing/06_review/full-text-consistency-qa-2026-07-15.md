# Full-text consistency QA

Date: 2026-07-15

Skill used: `nature-writing`

## One-sentence QA target

The manuscript should consistently present the v10 SQL FAERS results as hypothesis-generating reporting signals that may inform radiology nursing surveillance priorities, without reverting to superseded Chinese-manuscript placeholders or implying incidence, causality, comparative drug safety or nursing-intervention effectiveness.

## Checks passed

| Check | Result |
|---|---|
| Superseded report count `14,780` | No occurrence found in `03_manuscript/main.md` |
| Superseded PT-record count `42,808` | No occurrence found in `03_manuscript/main.md` |
| Superseded TTO denominator `12,588` | No occurrence found in `03_manuscript/main.md` |
| Superseded TTO percentage `81.56%` | No occurrence found in `03_manuscript/main.md` |
| Superseded strict PT count framing as `24 positive PTs` | No occurrence found in `03_manuscript/main.md` |
| Outdated extravasation claim as the largest displayed signal | No occurrence found; extravasation is now framed as one priority PT signal rather than the strongest overall signal |
| Results count consistency | Main text consistently uses 14,781 POOLED reports, 42,811 PT records, 951 POOLED PT rows, 230 strict POOLED PT signals, Top 30 display subset, 27 SOCs, 2 strict SOCs, 9,069 TTO rows, 88.32% same-day and 93.17% within 1 day |
| Core inference boundary | Repeatedly states no incidence, no individual-level causality, no comparative safety ranking and no nursing-intervention effectiveness |
| In-text citation placeholders | Prior `[REF TO VERIFY]` placeholders were removed and replaced with numbered references |
| Running title | `ICM safety surveillance` is under the Nursing Open limit of 40 characters |

## Remaining unresolved items

| Item | Location | Reason it remains unresolved |
|---|---|---|
| FAERS quarter inventory and download dates | Methods 2.2; Data availability | Requires local import/download records |
| Deduplication execution details | Methods 2.4 | Requires confirmation from the executed pipeline/import logs |
| MedDRA imported file names and import date | Methods 2.5; Reference 3 | Requires local MedDRA package/import records |
| Local clinical nursing record component | Methods 2.3/2.8, Results 3.6, Discussion 4.1, Declarations | Requires author decision/data extraction; can be included, omitted or left as pending only before final submission strategy is locked |
| Institutional ethics/consent wording | Methods 2.9; Declarations; title page | Requires institution-specific determination |
| Data/code repository or supplementary-file route | Data availability; Code availability | Requires author decision and repository/DOI if deposited |
| Funding, conflicts, author contributions, acknowledgements, ORCID | Declarations and title page | Author metadata required |
| ACR manual version/year | Reference 5 | Final current version should be checked before submission |
| APA/Nursing Open reference formatting | References | Do after the final reference set is locked |

## Notes

- The phrase "frequent events may not generate the strongest disproportionality" remains intentionally because it explains the difference between frequency and signal strength; it is not the superseded claim that extravasation had the largest displayed disproportionality.
- The abstract was revised after this QA to follow Nursing Open's captured requirements more closely: 267 words, structured headings retained, no manuscript-specific abbreviations in the abstract body and no confidence intervals, p values or algorithm parameters. The Reporting Method field has now been resolved as STROBE plus RECORD.
