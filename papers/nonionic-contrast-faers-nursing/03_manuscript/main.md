# FAERS Signals and Local Documentation Gaps for Non-Ionic Iodinated Contrast Media: Defining Requirements for a Standardized, Human-Reviewed Nursing Adverse-Event Reporting Workflow

**Manuscript status:** Nursing Open-facing anonymized working draft v0.12; structure revised around a single nursing adverse-event reporting information chain

**Evidence status:** FAERS numerical results are supported by the v10 SQL outputs. The author-reported five-year total of 39 local registered events, local field- and relationship-completeness results, independent-review procedure, ethics determination and data-sharing route remain **[EVIDENCE NEEDED]**.

**Inference boundary:** This study identifies FAERS reporting signals, audits local documentation requirements when verified, and defines an evidence-informed reporting specification. It does not quantify under-reporting from the local count, estimate incidence, establish causality, compare absolute drug safety, demonstrate reporting improvement, evaluate nursing quality, or validate a mobile or LLM system.

## Abstract

### Aim(s)

To characterise adverse-event reporting signals and time-to-onset patterns for four non-ionic iodinated contrast media, evaluate the completeness of a local nursing event registry, and translate these evidence sources into requirements for a standardized, human-reviewed adverse-event reporting workflow.

### Design

Retrospective quantitative pharmacovigilance analysis and single-centre documentation audit with an evidence-to-reporting-requirement mapping.

### Data Sources

Reports in the US Food and Drug Administration Adverse Event Reporting System from 2004 quarter 1 to 2025 quarter 4 and a five-year local registry reportedly containing 39 suspected contrast-related adverse events **[VERIFY]**.

### Methods

FAERS adverse events were analysed using Medical Dictionary for Regulatory Activities preferred terms and system organ classes, four disproportionality methods and time-to-onset analysis. The local audit will classify required fields and explicit product-event-time-management-outcome relationships as documented, partial or ambiguous, missing, or not applicable **[EVIDENCE NEEDED]**. Prespecified mapping rules will connect universal reporting requirements, contrast-specific FAERS priorities, local documentation gaps and source-fidelity safeguards.

### Results

The analysis retained 14,781 pooled reports and 42,811 preferred-term records. Among 951 preferred-term rows meeting the minimum case threshold, 230 met the strict signal definition. Priority signals included contrast media reaction, contrast media allergy, contrast encephalopathy, anaphylactoid shock, air embolism and extravasation. Immune system disorders and skin and subcutaneous tissue disorders met the strict system-organ-class signal definition. Among 9,069 evaluable time-to-onset rows, 88.32% occurred on the day of administration and 93.17% occurred within 1 day. Local field- and relationship-completeness results remain **[EVIDENCE NEEDED]**.

### Conclusion

FAERS identifies contrast-specific event and timing priorities that can complement universal reporting requirements. When completed, the local audit will show whether the existing workflow captures these fields and relationships. Together, these evidence sources can define requirements for a standardized, source-grounded and human-reviewed reporting workflow; actual effects on completeness, source fidelity, usability or efficiency require prospective evaluation.

### Implications for the profession and/or patient care

The study focuses nursing attention on the information needed to convert an observed suspected contrast-related adverse event into a pharmacovigilance-ready report.

### Impact

The intended output is an implementable reporting specification, not a validated AI intervention.

### Reporting Method

The study was prepared with reference to the STROBE and RECORD reporting guidelines.

### Patient or Public Contribution

No patient or public contribution.

### Keywords

contrast media; adverse-event reporting; FAERS; pharmacovigilance; radiology nursing; documentation completeness; reporting workflow

## 1. Introduction

When a suspected adverse event occurs during or after administration of non-ionic iodinated contrast media (ICM), radiology nurses may need to recognise the event, document its clinical course, escalate care and generate information that can be reused for institutional or regulatory pharmacovigilance. Immediate clinical assessment and management take priority during an acute event, so documentation may occur under time pressure; this is a general workflow rationale rather than a measured finding in the study hospital. The practical reporting problem is not only whether an event is noticed. The record must also preserve the suspected product, event manifestation, administration and onset timing, escalation, management, outcome and reporter information without creating an excessive documentation burden.

Universal individual case safety report requirements provide the basic reporting skeleton, while contrast-specific evidence is needed to determine which event manifestations and timing prompts deserve particular attention. The US Food and Drug Administration Adverse Event Reporting System (FAERS) can identify drug-event combinations reported more frequently than expected and describe time-to-onset patterns. However, FAERS is affected by under-reporting, stimulated reporting, missing data, duplicate records, confounding and the absence of an exposure denominator. Its signals are reporting associations rather than incidence estimates or proof of causality [1,2].

Nursing implementation research indicates that workload, limited reporting-system accessibility, unclear procedures and incomplete documentation can impede adverse-reaction reporting [13]. Clinical-text studies further show that mentioning an event is not equivalent to explicitly linking it to a suspected drug, and that models may perform less well on medication-event relationships than on isolated entity detection [15,16]. Generative pharmacovigilance systems can also introduce incorrect products, dates, events or outcomes, supporting source-grounded constraints and expert human review [14]. These findings favour explicit structured capture over asking a model to infer long or ambiguous clinical relationships.

This study therefore treats adverse-event reporting as one information chain. It aimed to: (1) characterise reporting signals and time-to-onset patterns for four non-ionic ICM in FAERS; (2) audit the field and relationship completeness of a five-year local registry of 39 suspected contrast-related events **[VERIFY]**; and (3) translate universal reporting requirements, FAERS-derived contrast priorities and verified local gaps into an evidence-informed reporting specification. A mobile/LLM-assisted draft layer is considered only as a possible future implementation of that specification.

## 2. Methods

### 2.1 Design

This study comprises three linked components: a retrospective FAERS disproportionality and time-to-onset analysis, a retrospective single-centre documentation-completeness audit, and a prespecified evidence-to-reporting-requirement mapping. The empirical components determine what contrast-specific information is salient and whether the existing local record captures the required fields and relationships. The mapping component defines reporting requirements; it does not constitute development or validation of a software or LLM intervention.

### 2.2 FAERS data source

FAERS quarterly files from 2004 quarter 1 through 2025 quarter 4 were used [1,2]. The source files comprised demographic and administrative information (DEMO), drug information (DRUG), adverse reactions (REAC), and patient outcomes (OUTC). The FDA official quarterly data page listed 2025 quarter 4 ASCII and XML files at the time of verification. The final reproducibility package will report the local download dates, file inventory, file-integrity checks where available, and import log confirming the included quarters.

Because the study period spans the legacy AERS and current FAERS formats, variable names and coding conventions were harmonised before quarterly files were merged. The v10 SQL statements are archived with the manuscript materials. A quarter-level file inventory, download dates, import status and deletion-file handling output will be added as supplementary methods material before submission.

### 2.3 FAERS report identification and deduplication

Eligible reports were those listing ioversol, iohexol, iopamidol, or iodixanol as the primary suspect drug. The inspected v10 SQL specifies these four generic names, the 2004Q1-2025Q4 date range, primary-suspect role (`role_cod = 'PS'`) and the eligible reporter-occupation codes. At the analysis layer, it selects distinct combinations of `primaryid`, target and `fda_dt`, forms the pooled base with distinct `primaryid`, and forms PT-level records with distinct analysis-group, `primaryid` and PT combinations. Full-database comparator counts likewise use distinct `primaryid`.

Drug-name matching joins the target list to the cleaned table `drug_clean`. The construction of `drug_clean`, including brand names, spelling variants, salts and exclusion terms, has not yet been recovered **[EVIDENCE NEEDED]**. The v10 analysis also uses `demo_clean`, but the available analysis script does not establish how CASEID, FDA_DT and PRIMARYID were applied to follow-up versions, how deletion files were handled, or how the cleaned tables were constructed **[EVIDENCE NEEDED]**. These upstream procedures must be documented before submission; the verified analysis-layer distinct-count logic should not be presented as a substitute for FDA-compatible case-version deduplication.

Several design choices were used to reduce avoidable reporting artefacts while preserving the exploratory nature of pharmacovigilance. Reports were restricted to records in which one of the four target agents was the primary suspect drug, drug-name matching used the cleaned `drug_clean` table rather than unstandardised raw drug strings, and the main PT signal display required both strict four-algorithm positivity and at least 10 reports before EBGM05 ranking. These steps reduce instability from very sparse cells and drug-name noise, but they do not remove spontaneous-reporting biases such as under-reporting, stimulated reporting, differential product use, duplicate clinical narratives, or confounding by indication.

### 2.4 Adverse-event coding

Reported adverse events (AEs) were analysed using Medical Dictionary for Regulatory Activities (MedDRA) version 28.0 at the preferred term (PT) and system organ class (SOC) levels [3]. PT mapping and SOC allocation used imported MedDRA electronic files in MySQL, including `meddra_soc` and `meddra_smq`; these tables should be treated as MedDRA source imports rather than ad hoc mapping tables. A single report could contain more than one PT, so the number of PT records could exceed the number of reports. The exact imported MedDRA file names, version package and import date will be recorded in the reproducibility package where available.

### 2.5 Disproportionality analysis

Four complementary disproportionality methods were prespecified: the reporting odds ratio (ROR), proportional reporting ratio (PRR), Bayesian confidence propagation neural network information component (IC), and multi-item gamma Poisson shrinker empirical Bayes geometric mean (EBGM) [7-10]. A drug-event pair was defined as a signal only when it met the prespecified minimum case count and the positive thresholds for the required algorithms.

The v10 SQL used the following strict four-algorithm signal definition: at least three reports for the PT or SOC in the analysis group, lower 95% confidence limit for ROR greater than 1, PRR greater than 2 with chi-square at least 4, IC025 greater than 0, and EBGM05 greater than 2. EB05 in the SQL output is reported as EBGM05. Complete ROR, PRR, IC/IC025, EBGM/EBGM05 values and binary algorithm flags were retained for both PT-level and SOC-level outputs.

The primary analysis treated the four contrast agents as a pooled non-ionic ICM exposure group (`POOLED`). Agent-specific outputs for ioversol, iohexol, iopamidol and iodixanol were generated in the same SQL run as stratified descriptive outputs, but the manuscript does not use them to rank the absolute safety of individual agents. Signal magnitude was interpreted as the strength of disproportionate reporting, not as event probability, clinical severity, comparative drug safety, or causal effect.

For interpretability, all POOLED PT signals meeting the strict four-algorithm definition were retained as the complete statistical output. The main-text priority PT table was prespecified as the top 30 POOLED strict signals with at least 10 reports, ranked by EBGM05 in descending order. This conservative lower-bound shrinkage ranking was used to reduce overemphasis on unstable high ROR values from very small cell counts. The complete 230-row POOLED strict PT table will be provided as supplementary material.

### 2.6 Time-to-onset analysis

TTO was calculated using pre-cleaned date fields as the interval between the recorded AE date (`demo_clean.event_dt`) and treatment start date (`ther.start_dt`). The v10 SQL retained rows in which both dates used an eight-digit format and `tto_days` was between 0 and 730. TTO was summarized as same-day onset, within 1 day, within 30 days, median, nearest-rank Q1 and Q3, minimum and maximum. Because FAERS dates are recorded at day-level granularity, same-day events (`tto_days = 0`) were coded as 0.5 day for Weibull fitting.

Weibull parameters were estimated outside MySQL using the exported `res_v10_tto_weibull_input` table and the archived Python script `fit_weibull_tto.py`. The model was fitted separately by analysis group using maximum likelihood estimation with the Weibull minimum distribution. Shape and scale parameters, 95% confidence intervals, model-derived quartiles and convergence messages were exported. A shape parameter below 1 was interpreted as an early-failure pattern, indicating that rows with evaluable timing were concentrated early after administration. TTO rows were not treated as exposed-patient denominators, and duplicate primary IDs in the Weibull input were tracked separately.

Rows without usable event and treatment-start dates were excluded from TTO and Weibull analyses but remained eligible for disproportionality analyses when other inclusion criteria were met. Therefore, TTO findings describe only the date-complete subset and are reported separately from the full FAERS signal denominator.

### 2.7 Local registry source and eligibility

The local component is a diagnostic documentation audit rather than a clinical epidemiology or intervention-effect study. The author-reported source covers five years and contains 39 registered suspected contrast-related adverse events **[VERIFY]**. Before analysis, the exact study dates, department and institution, registry or form name, authorised retrieval route, person or role performing retrieval, search or register-review procedure, and any cross-check against another authorised source must be recorded **[EVIDENCE NEEDED]**.

Eligible records should be defined as registered events within the verified study period that identify administration of a non-ionic iodinated contrast medium and document a suspected temporally associated event **[VERIFY: final operational definition]**. Prespecified exclusions should be limited to out-of-period records, records not involving a target contrast medium, and confirmed duplicate registrations; incomplete fields should be coded as missing or ambiguous rather than used to exclude a record. Rules for linking multiple entries from the same clinical episode and retaining the most complete or final version remain **[EVIDENCE NEEDED]**. The count of 39 cannot by itself quantify under-reporting because the exposed population, expected event range and completeness of alternative reporting routes are not yet established.

If a verified denominator of all ICM administrations is available, it may be reported as single-centre descriptive context only. Assessment of under-ascertainment would require a separate case-finding design or triangulation with other authorised sources and is outside the current analysis.

### 2.8 Local field- and relationship-completeness audit

The unit of analysis will be one registered event record. Field-level items will include the suspected contrast agent, event manifestation, event date, administration time, onset time or observation window, seriousness or escalation, management, outcome, reporter role and the minimum identifiers required within the authorised institutional system. Relationship-level items will record whether the source explicitly links the suspected product to the event, the administration to the event timeline, and the event to escalation, management and outcome.

Each item will be classified using prespecified operational definitions as documented, partial or ambiguous, missing, or not applicable. Two reviewers should independently code the records **[VERIFY: reviewer availability]**. Disagreements should be resolved by consensus or a third reviewer. Raw agreement should be reported, and Cohen's kappa with a confidence interval may be reported for suitable categorical items; no target kappa value will be imposed. The completed coding dictionary, reviewer roles, reliability results and aggregate `n/N (%)` values remain **[EVIDENCE NEEDED]**.

### 2.9 Evidence-to-reporting-requirement mapping

The mapping will use four traceable rules. First, verified ICSR guidance and MedDRA will define universal minimum fields and standard terminology **[EVIDENCE NEEDED: final formal guidance citation]**. Second, FAERS PT/SOC clusters and time-to-onset results will define contrast-specific prompts and timing requirements. Third, verified local missing or ambiguous fields will define missing-field prompts and relationship checks. Fourth, pharmacovigilance LLM literature will define source-fidelity safeguards, including product/event mismatch checks, date and time consistency, explicit uncertainty, and mandatory human approval [14-16].

Every proposed requirement must be traceable to at least one source in the evidence-to-requirement matrix. FAERS-derived prompts will not determine report eligibility: the specification will preserve unrestricted “other event” entry and original free text to reduce anchoring on known signals and to permit capture of unexpected events. The mapping is an analytical output of the study, but it is not a validated clinical or software framework.

### 2.10 Ethical considerations

FAERS contains publicly available, de-identified spontaneous reports. Formal informed consent was therefore not applicable to the FAERS component. The local audit will be included only after institutional ethics approval, exemption or quality-improvement determination, consent waiver status and data-governance requirements have been verified **[EVIDENCE NEEDED]**.

### 2.11 Reporting and software

The manuscript was prepared with reference to the STROBE and RECORD reporting guidelines for observational and routinely collected health-data studies [11,12]. Database processing was performed in MySQL 8.0.44. Weibull fitting was performed in Python 3.13.9 using numpy 2.3.5, pandas 2.3.3 and scipy 1.16.3. The draft supplementary specification comprises a technology-neutral data dictionary and relationship model (`reporting-requirements-specification.md`), a machine-readable output schema (`reporting-draft.schema.json`) and deterministic validation and review rules (`guardrail-rules.csv`). These materials are unvalidated requirements artifacts, not evidence of software performance. Any future example prompt will be secondary and model-specific.

## 3. Results

### 3.1 FAERS report selection and characteristics

The v10 SQL analysis retained 14,781 POOLED analysis-base FAERS reports for the four non-ionic iodinated contrast media (ICM) (Table 1). These reports generated 42,811 PT records after filtering, representing 14,762 distinct reports with at least one retained PT and 2,173 distinct MedDRA PTs. After applying the minimum case threshold for disproportionality analysis, the POOLED PT signal table contained 951 PT rows across 27 SOCs. The analysis flow was therefore: target primary-suspect reports, retained PT records, minimum-case PT rows, strict four-algorithm PT signals, SOC-level summaries and TTO-eligible rows. These counts are report and event-record counts in FAERS, not exposed-patient denominators or incidence estimates.

Agent-specific analysis-base counts were 6,443 reports for iohexol, 3,272 for ioversol, 2,797 for iopamidol, and 2,269 for iodixanol. Because reports could contribute to both pooled and agent-specific outputs, agent-specific rows should be interpreted as stratified analysis groups rather than mutually exclusive patient denominators.

In the POOLED report set, 6,932 reports (46.90%) involved female patients, 5,138 (34.76%) involved male patients, and 2,711 (18.34%) had missing or unknown sex (Table 1). Age was recorded as younger than 18 years in 269 reports (1.82%), 18-59 years in 5,355 (36.23%), and 60 years or older in 5,257 (35.57%); age was missing or unknown in 3,900 reports (26.39%). The most frequent reporter-country codes were US (5,895; 39.88%), CN (1,386; 9.38%), JP (1,016; 6.87%) and FR (905; 6.12%); reporter country was missing or unknown in 940 reports (6.36%). Reporter qualification was most often coded as other (6,641; 44.93%), other health professional (3,254; 22.01%), physician (3,158; 21.37%) or pharmacist (1,711; 11.58%); 17 reports (0.12%) were coded as nurse. This field reflects the reporter-qualification code in FAERS and cannot estimate nurses' actual involvement in event recognition, institutional documentation or reporting.

### 3.2 SOC- and PT-level reporting signals

The POOLED SOC-level disproportionality analysis evaluated 27 SOCs (Table 3). Two SOCs met the strict four-algorithm criteria: immune system disorders (2,981 cases; ROR 8.53; PRR 7.01; IC 2.80; EBGM 6.97; EBGM05 4.14) and skin and subcutaneous tissue disorders (5,259 cases; ROR 4.92; PRR 3.53; IC 1.82; EBGM 3.52; EBGM05 2.09). These two SOCs represent the strict SOC-level signal set under the v10 SQL definition.

Single-algorithm SOC results were broader: in the POOLED analysis, nine SOCs were ROR-positive and nine were BCPNN-positive, whereas four were positive by the core ROR/PRR definition and two by the strict four-algorithm definition. Therefore, SOC-level Results should distinguish single-algorithm screening patterns from strict multi-algorithm positivity.

The POOLED PT-level analysis identified 230 PTs that met all four prespecified disproportionality criteria. The complete 230-signal table will be provided as Supplementary Table S1. To keep the main text clinically readable, the primary PT table presents the 30 highest-ranked POOLED strict signals with at least 10 reports, ordered by EBGM05 (Table 2).

The highest-ranked priority PTs by EBGM05 included contrast media reaction (574 cases; ROR 477.20; PRR 458.71; IC 8.42; EBGM05 156.18), contrast media allergy (365 cases; ROR 411.45; PRR 401.31; IC 8.27; EBGM05 128.42), contrast encephalopathy (135 cases; ROR 1,930.02; PRR 1,912.40; IC 9.63; EBGM05 117.82), anaphylactoid shock (72 cases; ROR 250.30; PRR 249.09; IC 7.72; EBGM05 49.41), air embolism (70 cases; ROR 245.84; PRR 244.68; IC 7.69; EBGM05 48.25), extravasation (254 cases; ROR 93.68; PRR 92.09; IC 6.43; EBGM05 43.47), anaphylactoid reaction (225 cases; ROR 82.24; PRR 81.00; IC 6.26; EBGM05 38.49), and sneezing (850 cases; ROR 59.66; PRR 56.29; IC 5.76; EBGM05 31.07).

The priority list also included nursing-relevant respiratory, renal, vascular-access and cardiopulmonary terms such as laryngeal discomfort, blood pressure immeasurable, toxic nephropathy, anaphylactic shock, laryngeal oedema, throat tightness, cyanosis, throat irritation and anaphylactic reaction. These results identify signals of disproportionate reporting in FAERS; they do not estimate event incidence, clinical severity, comparative drug safety, or individual-level causality.

### 3.3 Time-to-onset patterns

After exclusion of rows without usable event and treatment-start dates under the v10 SQL rules, the POOLED TTO analysis contained 9,069 evaluable TTO rows, corresponding to 8,987 distinct primary IDs in the Weibull input (Table 4). In relation to the 14,781 POOLED analysis-base reports, 5,794 reports did not contribute a distinct primary ID to the Weibull input because the required date fields or eligible TTO row were not retained. Same-day onset accounted for 8,010 rows (88.32%), and 8,450 rows (93.17%) occurred within 1 day. Within 30 days, 9,019 rows (99.45%) were captured. The median TTO was 0 days, with nearest-rank Q1 and Q3 both equal to 0 days.

The pooled Weibull model fitted to the v10 input had a shape parameter below 1 (beta = 0.686271) and a scale parameter of 0.958471 days, consistent with an early-failure pattern among rows with evaluable timing. Same-day events were coded as 0.5 day for Weibull fitting because FAERS dates are recorded at day-level granularity. This temporal finding supports the relevance of early post-administration surveillance, but it remains subject to missing-date bias and cannot define a universal observation period.

### 3.4 Local field completeness

The five-year local registry reportedly contains 39 suspected contrast-related events **[VERIFY]**. Final results will report documented, partial or ambiguous, missing and not-applicable counts for each prespecified field. No local field-completeness result is currently available **[EVIDENCE NEEDED]**.

### 3.5 Local relationship completeness

Final results will distinguish the presence of isolated terms from explicit product-event, administration-time-event, event-escalation, event-management and event-outcome relationships. No local relationship-completeness result is currently available **[EVIDENCE NEEDED]**. The number of registered events will not be interpreted as a quantitative measure of under-reporting.

### 3.6 Evidence-to-reporting-requirement mapping

The final mapping table will separate universal mandatory fields from contrast-specific prompts. The verified FAERS results support prompts for early event timing, access-site events, hypersensitivity-type manifestations, airway or respiratory symptoms, cardiopulmonary escalation and carefully bounded kidney-related documentation. The specification will require original event wording, permit unrestricted entry of other or unexpected events, and retain candidate standard terminology as a reviewable suggestion rather than an automatic replacement.

Local gaps, once verified, will be linked to required fields, missing-field prompts or relationship checks **[EVIDENCE NEEDED]**. Source-fidelity requirements will prohibit unsupported additions of products, events, dates or outcomes and will retain a `pending human review` state before any institutional submission. This output defines implementable requirements; it does not report mobile, LLM, accuracy or usability performance.

## 4. Discussion

### 4.1 Principal findings

The FAERS analysis identified 230 strict pooled PT-level reporting signals and two strict SOC-level signals among reports involving four non-ionic ICM. The main-text priority subset included contrast-media reaction and allergy terms, anaphylactoid or shock-related terms, cardiopulmonary and airway manifestations, contrast encephalopathy, air embolism, extravasation and selected kidney-related events. Among rows with evaluable timing, 88.32% occurred on the day of administration and 93.17% within 1 day. The local component is intended to determine whether the existing record preserves the fields and explicit relationships required to reuse these observations in pharmacovigilance; those results remain **[EVIDENCE NEEDED]**.

### 4.2 FAERS-informed capture priorities

FAERS adds contrast-specific content and timing priorities to the universal reporting skeleton. Access-site terms support explicit capture of vascular-access location, observed swelling or pain and associated management. Hypersensitivity-type, airway and cardiopulmonary terms support structured recording of manifestations and escalation. Kidney-related PTs require cautious contextual documentation because FAERS lacks baseline renal function, complete procedure information and an exposure denominator. These priorities should guide prompts rather than act as an exhaustive list or determine causality, severity or eligibility for reporting.

The early time-to-onset pattern supports capturing administration and event timing before those details are lost, but it does not define a universal clinical observation period. Because FAERS is itself shaped by what reporters notice and submit, unrestricted event entry and preservation of the nurse's original wording are necessary to avoid anchoring the workflow on previously recognised signals.

### 4.3 Local documentation and relationship gaps

The local audit is designed to test whether an existing nursing record can be transformed into a complete, explicitly linked safety report. Its contribution depends on transparent coding of fields and relationships rather than on the size of a clinical cohort. Even if the verified registry contains only 39 records, that count cannot establish the degree of under-reporting without a denominator and independent case ascertainment. The defensible result is the completeness of the records that are actually available.

### 4.4 Requirements for standardization, source fidelity and workflow usability

The proposed specification has three design objectives. Standardization and completeness are addressed through universal minimum fields, MedDRA-compatible terminology, contrast-specific prompts and explicit product-event-time-management-outcome relationships. Source fidelity and review safety are addressed through mismatch checks, missing- and conflicting-field flags, preservation of uncertainty and mandatory human approval. Workflow usability and efficiency are treated as future evaluation targets; the current requirements define a concise first-capture structure and a reviewable draft state but do not establish that either reduces effort.

Automation, including an LLM-assisted draft layer, is only one possible implementation and must remain source-grounded, human-reviewed and unable to submit reports automatically. The present study defines requirements; it does not demonstrate that any digital implementation improves documentation, accuracy, workload or reporting rates.

### 4.5 Future stakeholder confirmation and prospective validation

Before software development, the proposed fields and relationships should be reviewed by intended users and governance stakeholders, including radiology nurses and relevant nursing-quality, pharmacy, pharmacovigilance or radiology personnel. Such review should assess relevance, clarity, feasibility, missing requirements and responsibility for final approval. It should be described as stakeholder confirmation or pre-implementation requirements review unless a formal consensus method is actually used.

A subsequent prototype study should compare the assisted workflow with the current process using required-field completeness, valid-report completeness, product-event relationship completeness, source fidelity, hallucinated and omitted fields, expert-reviewed accuracy, completion time, number of edits, usability and perceived workload. Until such testing is completed, standardization, source fidelity and usability remain design objectives.

### 4.6 Strengths and limitations

The study combines a large pharmacovigilance analysis with a focused local documentation audit and a traceable evidence-to-requirement mapping. The FAERS analysis used a strict four-algorithm definition and separated the complete signal output from the main-text priority subset. The revised local method distinguishes isolated field presence from explicit reporting relationships and proposes independent review.

The limitations are substantial. FAERS is subject to under-reporting, missingness, duplicate or incomplete narratives, reporting stimulation, notoriety bias, geographic and temporal variation, differential product use and confounding. It has no complete exposure denominator, and primary-suspect designation does not establish causality. The TTO analysis includes only date-complete rows. The local audit is small, single-centre and dependent on the quality and scope of existing documentation; its count cannot quantify under-reporting. Coding reliability, ethics and aggregate completeness remain unverified. The mapping may reflect researcher judgement even when traceable, and stakeholder confirmation has not been conducted. FAERS-informed prompts may create anchoring unless unexpected events and original wording remain available. No mobile or LLM system, source-fidelity performance, usability, workflow efficiency or reporting improvement is evaluated in the present study.

## 5. Conclusion

FAERS identified contrast-specific event and timing priorities that can inform the content of nursing adverse-event reports, while universal reporting standards define the minimum report structure. The planned local audit will determine whether the existing registry captures the required fields and explicit relationships **[EVIDENCE NEEDED]**. Together, these evidence sources can define requirements for a standardized, source-grounded and human-reviewed reporting workflow. Mobile capture and LLM-assisted drafting are candidate implementation mechanisms only; their effects on completeness, source fidelity, usability, efficiency or reporting performance require stakeholder review and prospective validation.

## Declarations

### Ethics approval

The FAERS component used publicly available, de-identified spontaneous-reporting data and did not involve direct contact with human participants. The planned local clinical nursing record component will be included in the final manuscript only after institutional ethics approval, exemption, or quality-improvement determination has been confirmed. Institution-identifying ethics details will be supplied in the title page or submission metadata as required for double-blind review, or the local component will be omitted before submission.

### Consent to participate

Consent to participate was not applicable to the FAERS component because it used publicly available, de-identified secondary data. For the local clinical nursing record component, consent requirements or waiver of consent will follow the institutional ethics, exemption, or quality-improvement determination.

### Data availability

The FAERS/AEMS quarterly data files used in this study are publicly available from the US Food and Drug Administration. The FDA states that FAERS quarterly data files contain raw data extracted from the AERS database for the indicated time ranges and are not cumulative; the files are available through the FDA AEMS latest quarterly data files page and the FAERS quarterly data extract files portal. The final submission should report the exact download dates and quarterly file inventory for 2004 quarter 1 through 2025 quarter 4. Aggregate table-source files generated for this manuscript, including the main-text priority PT signals, full POOLED strict PT signals, SOC outputs, TTO distribution and report-characteristics tables, are available in the manuscript source-data package or will be deposited in a public repository before submission.

Individual local clinical and nursing records, if included, cannot be shared publicly because they are derived from institutional clinical records and may contain sensitive patient-level information. De-identified aggregate local summaries will be reported in the manuscript where institutional permission allows. Requests for any additional local record information must follow the institution's data-governance and ethics requirements.

### Code availability

The SQL scripts used to generate the v10 result tables and the Python script used for Weibull fitting are archived with the manuscript materials and should be provided as supplementary files or deposited in a public repository before submission. The final code statement should identify the exact repository, version, and DOI or accession number if available. The upstream `drug_clean` construction rules or drug dictionary export should be provided as supplementary material if sharing is permitted. Imported MedDRA source files are not redistributed with the manuscript; the MedDRA version, imported file names and mapping procedure should be documented for reproducibility.

### Funding, conflicts of interest, author contributions and acknowledgements

These author-identifying declarations are provided in the separate title page for double-blind review.

### Patient or public contribution

No patient or public contribution is reported for this secondary-data pharmacovigilance study.

## References

1. US Food and Drug Administration. FDA Adverse Event Reporting System (FAERS) database. Available at: https://www.fda.gov/drugs/drug-approvals-and-databases/fda-adverse-event-reporting-system-faers-database/
2. US Food and Drug Administration. FDA Adverse Event Monitoring System (AEMS): latest quarterly data files. Available at: https://www.fda.gov/drugs/fda-adverse-event-monitoring-system-aems/fda-adverse-event-monitoring-system-aems-latest-quarterly-data-files
3. MedDRA MSSO. Introductory Guide for MedDRA Version 28.0. Medical Dictionary for Regulatory Activities; 2025.
4. European Society of Urogenital Radiology Contrast Media Safety Committee. ESUR Guidelines on Contrast Agents. Version 10.0. 2018. Available at: https://www.esur.org/esur-guidelines-on-contrast-agents/
5. American College of Radiology Committee on Drugs and Contrast Media. ACR Manual on Contrast Media. American College of Radiology. Available at: https://www.acr.org/Clinical-Resources/Contrast-Manual
6. Davenport MS, Perazella MA, Yee J, Dillman JR, Fine D, McDonald RJ, Rodby RA, Wang CL, Weinreb JC. Use of intravenous iodinated contrast media in patients with kidney disease: consensus statements from the American College of Radiology and the National Kidney Foundation. Radiology. 2020;294(3):660-668. doi:10.1148/radiol.2019192094
7. Evans SJW, Waller PC, Davis S. Use of proportional reporting ratios (PRRs) for signal generation from spontaneous adverse drug reaction reports. Pharmacoepidemiol Drug Saf. 2001;10(6):483-486. doi:10.1002/pds.677
8. van Puijenbroek EP, Bate A, Leufkens HGM, Lindquist M, Orre R, Egberts ACG. A comparison of measures of disproportionality for signal detection in spontaneous reporting systems for adverse drug reactions. Pharmacoepidemiol Drug Saf. 2002;11(1):3-10. doi:10.1002/pds.668
9. Bate A, Lindquist M, Edwards IR, Olsson S, Orre R, Lansner A, De Freitas RM. A Bayesian neural network method for adverse drug reaction signal generation. Eur J Clin Pharmacol. 1998;54(4):315-321. doi:10.1007/s002280050466
10. DuMouchel W. Bayesian data mining in large frequency tables, with an application to the FDA spontaneous reporting system. Am Stat. 1999;53(3):177-190. doi:10.1080/00031305.1999.10474456
11. von Elm E, Altman DG, Egger M, Pocock SJ, Gøtzsche PC, Vandenbroucke JP. The Strengthening the Reporting of Observational Studies in Epidemiology (STROBE) statement: guidelines for reporting observational studies. PLoS Med. 2007;4(10):e296. doi:10.1371/journal.pmed.0040296
12. Benchimol EI, Smeeth L, Guttmann A, Harron K, Moher D, Petersen I, Sørensen HT, von Elm E, Langan SM. The REporting of studies Conducted using Observational Routinely-collected health Data (RECORD) statement. PLoS Med. 2015;12(10):e1001885. doi:10.1371/journal.pmed.1001885
13. Kabiri N, Hajebrahimi S, Rahmani P, Molaei Tavani F, Saghaleini SH, Razi Soofiyani S, Talebpour A. Implementing best practices for nurses in detecting and reporting adverse drug reactions in a tertiary hospital in Tabriz, Iran: a mixed-method study. Health Sci Rep. 2024;7(12):e70277. doi:10.1002/hsr2.70277
14. Hakim JB, Painter JL, Ramcharran D, Kara V, Powell G, Sobczak P, Sato C, Bate A, Beam A. The need for guardrails with large language models in pharmacovigilance and other medical safety critical settings. Sci Rep. 2025;15:27886. doi:10.1038/s41598-025-09138-0
15. Silverman AL, Sushil M, Bhasuran B, et al. Algorithmic identification of treatment-emergent adverse events from clinical notes using large language models: a pilot study in inflammatory bowel disease. Clin Pharmacol Ther. 2024;115(6):1391-1399. doi:10.1002/cpt.3226
16. Kopacheva E, Lincke A, Björneld O, Hammar T. Detecting adverse drug events in clinical notes using large language models. Stud Health Technol Inform. 2025;327:892-893. doi:10.3233/SHTI250495
