# Reference rebuild audit

Date: 2026-07-15

Skills used: `nature-ref-verifier`, `nature-citation`

## Scope

This first rebuilt reference set replaces the source manuscript's bilingual reference list, which was not carried forward because it contained duplicate numbering, untranslated metadata and at least one mismatched English citation. The current set is a core support library for the revised Nursing Open-facing manuscript, not yet the final formatted APA list.

## Citation needs covered

| Manuscript need | Current reference numbers | Status |
|---|---:|---|
| FAERS/AEMS data source and spontaneous-reporting boundary | 1, 2 | Official FDA web sources; final access dates/download inventory still needed |
| MedDRA coding source | 3 | Version 28.0 source named; exact imported file names still needed |
| Contrast-media safety, extravasation and reaction guidance | 4, 5 | ESUR and ACR guidance sources inserted; final ACR manual version/year should be checked before submission |
| CA-AKI / kidney-related contrast guidance | 4, 5, 6 | ACR-NKF consensus DOI verified through Crossref |
| Disproportionality methods: PRR, ROR/comparison, BCPNN, MGPS/EBGM | 7-10 | DOI metadata verified through Crossref |
| Observational secondary-data reporting frameworks | 11, 12 | DOI metadata verified through Crossref |

## Crossref-verified DOI records

| Ref | DOI | Crossref title match | Journal | Year | Volume(issue) | Pages |
|---:|---|---|---|---:|---|---|
| 6 | 10.1148/radiol.2019192094 | Use of Intravenous Iodinated Contrast Media in Patients with Kidney Disease: Consensus Statements from the American College of Radiology and the National Kidney Foundation | Radiology | 2020 | 294(3) | 660-668 |
| 7 | 10.1002/pds.677 | Use of proportional reporting ratios (PRRs) for signal generation from spontaneous adverse drug reaction reports | Pharmacoepidemiology and Drug Safety | 2001 | 10(6) | 483-486 |
| 8 | 10.1002/pds.668 | A comparison of measures of disproportionality for signal detection in spontaneous reporting systems for adverse drug reactions | Pharmacoepidemiology and Drug Safety | 2002 | 11(1) | 3-10 |
| 9 | 10.1007/s002280050466 | A Bayesian neural network method for adverse drug reaction signal generation | European Journal of Clinical Pharmacology | 1998 | 54(4) | 315-321 |
| 10 | 10.1080/00031305.1999.10474456 | Bayesian Data Mining in Large Frequency Tables, with an Application to the FDA Spontaneous Reporting System | The American Statistician | 1999 | 53(3) | 177-190 |
| 11 | 10.1371/journal.pmed.0040296 | The Strengthening the Reporting of Observational Studies in Epidemiology (STROBE) Statement: Guidelines for Reporting Observational Studies | PLoS Medicine | 2007 | 4(10) | e296 |
| 12 | 10.1371/journal.pmed.1001885 | The REporting of studies Conducted using Observational Routinely-collected health Data (RECORD) Statement | PLOS Medicine | 2015 | 12(10) | e1001885 |

## Remaining checks before final submission

1. Confirm the current ACR Manual on Contrast Media version/year and whether the URL should point to a PDF or landing page.
2. Confirm ESUR guideline URL/version and whether individual ESUR chapters should be cited separately.
3. Confirm the exact MedDRA 28.0 imported files, licensing note and import date for `meddra_soc` and `meddra_smq`.
4. Decide whether to add a dedicated pharmacovigilance reporting recommendation reference beyond STROBE/RECORD if the final checklist uses READUS-PV or another drug-safety reporting framework.
5. Reformat all references to Nursing Open/APA style after the final reference set is locked.
