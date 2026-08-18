# FAERS cleaning and deduplication boundary audit

Date: 2026-07-28

## Purpose

To distinguish analysis-layer logic verified in the archived SQL from unresolved upstream construction of `demo_clean` and `drug_clean`.

## Verified in `submission_outputs_v10.sql`

- Target generic names are configured as Ioversol, Iohexol, Iopamidol and Iodixanol.
- The configured study range is 2004-01-01 through 2025-12-31.
- Target reports require `drug.role_cod = 'PS'`.
- Reporter occupation is restricted to `MD`, `PH`, `OT`, `RN` and `HP`.
- Target drug selection joins raw `drug.drugname` to `drug_clean.drugname`, then matches `drug_clean.drugname_clean` to the four configured generic names.
- The target-drug report base uses `SELECT DISTINCT` on `primaryid`, normalized target name and FDA receipt date.
- The pooled analysis base uses distinct `primaryid` and receipt date.
- The report-PT analysis table uses distinct analysis group, `primaryid` and PT.
- Full-database PT counts use `COUNT(DISTINCT primaryid)`.
- TTO construction links DRUG to THER using `primaryid` plus `drug_seq = dsg_drug_seq`.
- TTO retains eight-digit event/start dates and intervals from 0 through 730 days.

## Not verified by the archived SQL

- how raw reports were converted into `demo_clean`;
- whether and how the latest report version was selected by CASEID and FDA_DT;
- how PRIMARYID was handled across follow-up versions;
- how FDA deletion files were applied;
- pre- and post-deduplication flow counts;
- construction of `drug_clean`;
- mapping of brand names, spelling variants, salts or exclusions to the four generic names;
- completeness of the reporter-occupation restriction as a study-design choice.

## Permitted manuscript wording

The manuscript may describe the verified analysis-layer use of distinct PRIMARYID-level report rows, distinct report-PT rows, primary-suspect restriction and normalized generic-name matching.

It must also state that the v10 analysis consumes pre-existing cleaned tables and that upstream CASEID/FDA_DT version handling, deletion-file processing and drug-dictionary construction remain to be supplied in the reproducibility package.

The manuscript must not claim that those upstream procedures were verified solely from `submission_outputs_v10.sql`.
