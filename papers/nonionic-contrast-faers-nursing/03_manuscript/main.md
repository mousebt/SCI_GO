# Adverse-Event Reporting Patterns of Non-Ionic Iodinated Contrast Media and Local Nursing Surveillance Context: Empirical Research Quantitative

**Manuscript status:** Nursing Open-facing working draft v0.7; local clinical nursing record contextualization framework added

**Evidence status:** All numerical results retained from the Chinese source manuscript require verification against the original analysis output. Local clinical/nursing record fields are placeholders until supplied by the authors. Items marked `[VERIFY]` or `[AUTHOR INPUT REQUIRED]` must be resolved before submission.

**Inference boundary:** This pharmacovigilance study identifies reporting signals. It does not estimate incidence, establish causality, compare absolute drug safety, or test the effectiveness of nursing interventions.

## Abstract

### Aim(s)

To characterise adverse-event reporting and time-to-onset patterns for four non-ionic iodinated contrast media and contextualise their nursing relevance using local clinical records.

### Design

Retrospective pharmacovigilance study with local clinical nursing record contextualization.

### Data Sources

Reports in the US Food and Drug Administration Adverse Event Reporting System from 2004 quarter 1 to 2025 quarter 4 were searched for ioversol, iohexol, iopamidol and iodixanol. Local data will include contrast-administration totals, adverse-event records and nursing intervention records. `[VERIFY: FAERS extraction and local source.]`

### Methods

Adverse events were analysed using Medical Dictionary for Regulatory Activities preferred terms and system organ classes. Disproportionality and time-to-onset analyses identified reporting patterns. Local records will be summarized descriptively against FAERS-derived nursing surveillance clusters. `[VERIFY: coding, thresholds, software and local variables.]`

### Results

The source analysis retained 14,780 eligible reports, 42,808 adverse-event records and 951 preferred terms. Twenty-four preferred terms met the stated signal criteria. Extravasation-related terms showed the strongest disproportionality. Shock, acute pulmonary oedema, renal tubular necrosis, dyspnoea and acute kidney injury were also clinically relevant. Among 12,588 reports with evaluable timing, 81.56% occurred within 24 hours. Local data are pending. `[VERIFY all FAERS and local data.]`

### Conclusion

Reported patterns may help radiology nurses prioritise vascular-access surveillance, early symptom recognition and escalation preparedness. Local records may strengthen clinical contextualization. Findings remain descriptive unless outcome evaluation is added.

### Implications for the profession and/or patient care

The findings support a surveillance-priority framework, pending verification against guidance, local protocols and nursing documentation.

### Impact

The study translates pharmacovigilance findings into nursing-relevant observation priorities while preserving the limits of spontaneous-reporting and retrospective documentation.

### Reporting Method

`[VERIFY: STROBE, RECORD/STROBE, READUS-PV or combined reporting statement.]`

### Patient or Public Contribution

No patient or public contribution. `[VERIFY: author confirmation required.]`

**Keywords:** contrast media; FAERS; pharmacovigilance; radiology nursing; disproportionality analysis; time to onset

## 1. Introduction

Non-ionic iodinated contrast media (ICM) are integral to contemporary diagnostic and interventional imaging. Although these agents are widely used, their administration can be accompanied by adverse events (AEs) that require rapid recognition and escalation in imaging settings, including contrast extravasation, hypersensitivity-type reactions, cardiopulmonary compromise, and kidney-related events. `[REF TO VERIFY: current contrast-media safety guidance.]`

Radiology nurses contribute to patient safety across the contrast-administration pathway. Their work may include pre-procedure assessment, vascular-access evaluation, observation during power injection, recognition of acute symptoms, activation of emergency response, post-procedure advice, and documentation. For this clinical workflow, the practical question is not simply which AEs can occur, but which reported events should be prioritised for surveillance and when vigilance is most critical.

Clinical trials and single-centre observational studies are usually not designed to detect rare events or broad reporting patterns across heterogeneous populations. The US Food and Drug Administration Adverse Event Reporting System (FAERS) therefore offers a complementary source for pharmacovigilance. Disproportionality analysis can identify drug-event combinations reported more frequently than expected relative to a comparator background. However, spontaneous reports are affected by under-reporting, stimulated reporting, missing data, duplicate records, confounding, and the absence of a denominator representing all exposed patients. A disproportionality signal is therefore a statistical reporting association, not an incidence estimate or proof of causality. `[REF TO VERIFY: FDA FAERS limitations and READUS-PV.]`

Previous work on ICM safety has often focused on particular clinical outcomes, specific patient-risk groups, or local preventive interventions. Less attention has been paid to how broad spontaneous-reporting patterns and event timing might be translated into nursing-sensitive surveillance priorities without overstating the evidence. This study therefore aimed to characterise AE reporting signals and time-to-onset patterns for four non-ionic ICM in FAERS and to contextualise the findings using local contrast-administration, adverse-event and nursing intervention records. The local record component is intended to support clinical interpretation and documentation priorities; it will not be used to claim intervention effectiveness unless an appropriate outcome design and verified data are available.

## 2. Methods

### 2.1 Design

This was a retrospective pharmacovigilance study using spontaneous reports from the US Food and Drug Administration Adverse Event Reporting System (FAERS), supplemented by a planned descriptive review of local contrast-administration, adverse-event and nursing intervention records. The FAERS analysis was designed to identify signals of disproportionate reporting and time-to-onset (TTO) patterns for selected non-ionic iodinated contrast media (ICM). The local record review is intended to contextualise whether these signal clusters correspond to nursing surveillance, documentation and escalation needs in routine practice. The study is not designed to establish causality, rank the absolute safety of individual agents, or prove that nursing interventions reduce adverse events.

### 2.2 Data source

FAERS quarterly files from 2004 quarter 1 through 2025 quarter 4 were used. The source files comprised demographic and administrative information (DEMO), drug information (DRUG), adverse reactions (REAC), and patient outcomes (OUTC). The FDA official quarterly data page listed 2025 quarter 4 ASCII and XML files at the time of verification. `[VERIFY: local download date, file integrity, and import log confirming that 2025 Q4 was fully included.]`

Because the study period spans the legacy AERS and current FAERS formats, variable names and coding conventions were harmonised before quarterly files were merged. Reproducible SQL statements and a quarter-level file inventory will be archived as supplementary methods material. `[AUTHOR INPUT REQUIRED: provide SQL files, download dates, quarter-level import status, and deletion-file handling output.]`

### 2.3 Local clinical nursing record source

Local records will be extracted for `[AUTHOR INPUT REQUIRED: institution/department]` over `[AUTHOR INPUT REQUIRED: study period]`. The planned local dataset includes: (1) the total number of non-ionic ICM administrations; (2) registered contrast-related AEs; and (3) nursing intervention and documentation records for these events. `[AUTHOR INPUT REQUIRED: data source, such as radiology information system, nursing adverse-event registry, incident reporting system, electronic medical record or manual nursing log.]`

The local review will be descriptive. If a complete denominator of total ICM administrations is available, local AE proportions may be reported as single-centre descriptive proportions. These proportions will not be interpreted as generalizable incidence estimates. If the denominator is unavailable or incomplete, local data will be used only as event-record contextualization. `[AUTHOR INPUT REQUIRED: denominator availability and missing-data profile.]`

### 2.4 FAERS report identification and deduplication

Eligible reports were those listing ioversol, iohexol, iopamidol, or iodixanol as the primary suspect drug. The drug-retrieval dictionary, including generic names, brand names, spelling variants, salts and exclusion terms, is maintained in the SQL source. Cleaning and normalisation rules completed outside SQL will be documented separately. `[AUTHOR INPUT REQUIRED: archive the SQL dictionary and non-SQL cleaning-rule note.]`

Reports were deduplicated using CASEID, FDA_DT, and PRIMARYID in accordance with the procedure described by the FDA. For records sharing a CASEID, the report with the latest FDA_DT was retained; when CASEID and FDA_DT were identical, the record with the highest PRIMARYID was retained. Reports listed in deletion files were excluded. `[VERIFY: confirm that this procedure was applied consistently to every quarter and whether follow-up versions were linked before analysis.]`

### 2.5 Adverse-event coding

Reported adverse events (AEs) were analysed using Medical Dictionary for Regulatory Activities (MedDRA) version 28.0 at the preferred term (PT) and system organ class (SOC) levels. PT mapping, legacy-term handling and SOC allocation followed MedDRA default settings. A single report could contain more than one PT; therefore, the number of AE records could exceed the number of reports. `[VERIFY: name the MedDRA browser/software/export source used for final PT and SOC verification.]`

### 2.6 Disproportionality analysis

Four complementary disproportionality methods were prespecified: the reporting odds ratio (ROR), proportional reporting ratio (PRR), Bayesian confidence propagation neural network information component (IC), and multi-item gamma Poisson shrinker empirical Bayes geometric mean (EBGM). A drug-event pair was defined as a signal only when it met the prespecified minimum case count and the positive thresholds for the required algorithms.

The source manuscript lists the following screening rules: a minimum of three reports, lower 95% confidence limit for ROR greater than 1, PRR greater than 2 with chi-square at least 4, IC025 greater than 0, and EBGM05 greater than 2. Formulae are retained in the manuscript methods, and complete algorithm outputs will be supplied in tables. `[AUTHOR INPUT REQUIRED: add EBGM and EBGM05 outputs to the SOC/PT tables and confirm the exact comparator background, 2 x 2 table and continuity correction.]`

Signal magnitude was interpreted as the strength of disproportionate reporting, not as event probability, clinical severity, or causal effect. The current working draft treats the four contrast agents as a pooled ICM exposure group because agent-specific analyses have not yet been performed. If feasible, agent-specific outputs will be reported as sensitivity or supplementary analyses; otherwise, the manuscript will justify pooling and avoid comparative claims between agents.

### 2.7 Time-to-onset analysis

TTO was calculated using pre-cleaned date fields as the interval between the recorded treatment start date and AE onset date. No additional TTO-specific cleaning was performed after this pre-processing step. Reports with missing, implausible, or negative intervals were excluded. TTO was summarised using descriptive statistics and modelled with a Weibull distribution. A shape parameter below 1 was interpreted as an early-failure pattern, indicating that reports with evaluable timing were concentrated early after administration. `[AUTHOR INPUT REQUIRED: identify the exact date fields, pre-cleaning rules, partial-date rule, same-day-event definition, time unit, maximum follow-up, median and interquartile range, Weibull confidence intervals, and fitting procedure.]`

### 2.8 Local nursing record variables

The local record review will extract the following variables where available: ICM agent, administration date, imaging setting, AE type, onset time or observation window, symptoms, vascular-access site, nursing action, escalation action, outcome and documentation completeness. Nursing actions may include stopping injection, access-site assessment, physician notification, emergency response, local extravasation management, observation, patient education and follow-up instructions. `[AUTHOR INPUT REQUIRED: confirm available variables and local definitions.]`

Local AE categories will be mapped descriptively to the FAERS-derived surveillance clusters: extravasation/access-site events, cutaneous or respiratory symptoms, cardiopulmonary events and kidney-related events. This mapping is for clinical contextualization only and will not imply that local events were caused by the contrast agent unless causality was independently adjudicated. `[AUTHOR INPUT REQUIRED: local AE definitions and adjudication process, if any.]`

### 2.9 Ethical considerations

FAERS contains publicly available, de-identified spontaneous reports. Formal informed consent was therefore not applicable to the FAERS component. The local record review requires institutional determination regarding ethics approval, exemption or quality-improvement review before submission. `[AUTHOR INPUT REQUIRED: institutional ethics/IRB determination for local record review.]`

### 2.10 Reporting and software

The final manuscript will be checked against a relevant EQUATOR reporting checklist and pharmacovigilance reporting guidance. `[VERIFY: decide whether the submission will use STROBE, RECORD/STROBE, READUS-PV support, or a combined checklist note.]` Data processing was performed with Python 3.11 and MySQL. `[VERIFY: operating environment, MySQL version, Python packages and versions, analysis code, random seeds where applicable, and quality-control checks.]`

## 3. Results

### 3.1 Report selection and characteristics

The source analysis retained 14,780 eligible FAERS reports for the four non-ionic iodinated contrast media (ICM). The pre-deduplication count, post-deduplication count, deleted-case exclusions and final included count will be extracted from Figure 1 of the Chinese source manuscript and cross-checked against the SQL output. `[VERIFY: extract exact flow counts and quarter-level file inventory.]` These reports contained 42,808 adverse-event (AE) records mapped to 951 Medical Dictionary for Regulatory Activities preferred terms (PTs) across 27 system organ classes (SOCs) using MedDRA version 28.0 default PT/SOC mapping. `[VERIFY: final MedDRA English names and SOC allocation output.]`

The demographic profile was incompletely reported, as expected in spontaneous-reporting data. Women accounted for 6,932 reports (46.90%), men for 5,137 (34.76%), and sex was unknown in 2,711 (18.34%). Age was reported as below 18 years in 269 reports (1.82%), 18-59 years in 5,355 (36.23%), and 60 years or older in 4,980 (33.69%); age was missing in 4,176 reports (28.25%). The United States was the most frequently reported country (5,895; 39.88%), followed by China (1,386; 9.38%) and Japan (1,016; 6.87%). `[VERIFY: confirm denominators, age-category coding, country coding, and reporter-category output.]`

The five most frequently reported PTs in the source frequency table were pruritus (1,744; 11.80%), dyspnoea (1,612; 10.91%), erythema (1,012; 6.85%), nausea (888; 6.01%), and vomiting (818; 5.53%). The Chinese source table labelled these PTs as "indications"; this label should be corrected to "preferred terms" throughout the manuscript. `[VERIFY: nausea appears in the frequency table but not among the 24 positive-signal PTs; clarify that frequency and signal positivity are different analyses.]`

### 3.2 SOC-level disproportionality signals

Nine SOCs reportedly met the prespecified screening criteria. `[VERIFY: insert the complete SOC-level table with event counts, ROR/PRR/IC/EBGM estimates, confidence or credibility bounds, and exact screening thresholds.]` Until the SOC-level output is available, the manuscript should avoid drawing SOC-specific conclusions beyond noting that SOC-level screening was performed.

### 3.3 PT-level disproportionality signals

Twenty-four PTs were reported as positive disproportionality signals. The strongest displayed ROR estimates were observed for extravasation-related PTs: extravasation (n = 254; ROR 93.69, 95% CI 82.42-106.49), infusion-site extravasation (n = 73; ROR 16.81, 95% CI 13.33-21.18), administration-site extravasation (n = 9; ROR 13.60, 95% CI 7.05-26.23), and injection-site extravasation (n = 97; ROR 10.89, 95% CI 8.91-13.31). Shock was also among the strongest displayed PT-level signals (n = 169; ROR 10.77, 95% CI 9.25-12.54). `[VERIFY: confirm PT names against MedDRA, all counts, all confidence intervals, and whether the displayed ROR values correspond to pooled or agent-specific analyses.]`

Other clinically important PT-level signals included acute pulmonary oedema, renal tubular necrosis, cardiac arrest, dyspnoea, hypotension, and acute kidney injury. `[VERIFY: provide the complete 24-PT table, including PRR, IC, and EBGM outputs. The current source material mentions four algorithms but does not display complete EBGM evidence.]` These results identify signals of disproportionate reporting in FAERS; they do not estimate event incidence, clinical severity, comparative drug safety, or individual-level causality.

### 3.4 Nursing-relevant signal clusters

For a radiology nursing audience, the PT-level signals can be provisionally grouped into surveillance-relevant clusters rather than intervention claims. Extravasation-related PTs point to vascular-access and injection-site monitoring. Cutaneous and respiratory PTs, including pruritus, erythema, and dyspnoea, point to early symptom recognition. Cardiopulmonary PTs, including hypotension, shock, acute pulmonary oedema, and cardiac arrest, point to escalation readiness. Kidney-related PTs, including acute kidney injury and renal tubular necrosis, require cautious interpretation because FAERS lacks baseline renal function, contrast dose, procedure indication, and a denominator for exposed patients. `[VERIFY: ensure every cluster is traceable to the final PT table and supported by current guideline language before using it as a practice implication.]`

### 3.5 Time to onset

After exclusion of reports with missing, inaccurate, or negative time intervals, 12,588 reports were included in the time-to-onset (TTO) analysis. Of these evaluable reports, 81.56% were reported to have occurred within 24 hours after administration. `[VERIFY: insert the exact numerator, remaining interval categories, median, interquartile range, and complete TTO exclusion flow.]`

The Weibull scale parameter was reported as 17.3, and the shape parameter was below 1. The source analysis classified this pattern as early failure, meaning that reported events were concentrated early after administration among records with evaluable timing. `[VERIFY: provide the precise shape estimate, confidence interval, time unit for the scale parameter, fitting procedure, and treatment of same-day or partial dates.]` This temporal finding supports the relevance of early post-administration surveillance, but it remains subject to missing-date bias and cannot define a universal observation period.

### 3.6 Local clinical nursing record contextualization

Local clinical and nursing record data are pending. The planned local dataset will report the total number of non-ionic ICM administrations, the number of registered contrast-related AEs, AE categories, timing of events where available, nursing interventions and documentation completeness. `[AUTHOR INPUT REQUIRED: complete local data extraction template in 02_evidence/local-clinical-record-template.csv.]`

If a complete local denominator is available, the manuscript will report descriptive single-centre proportions for registered contrast-related AEs and major AE categories. If the denominator is incomplete, the manuscript will report counts and documentation patterns without calculating proportions. In either case, local records will be interpreted as clinical context for nursing surveillance priorities, not as proof that any nursing intervention reduced AE occurrence.

## 4. Discussion

### 4.1 Principal findings

This FAERS analysis generated three findings relevant to radiology nursing surveillance. First, extravasation-related PTs had the largest displayed disproportionality estimates, making vascular-access and injection-site surveillance a central nursing-relevant signal cluster. Second, hypersensitivity-type and cardiopulmonary PTs - including pruritus, erythema, dyspnoea, hypotension, shock, acute pulmonary oedema, and cardiac arrest - highlighted the need for readiness to recognise symptoms and activate escalation pathways. Third, most reports with evaluable timing occurred within 24 hours, and the Weibull model suggested early clustering, although missing and incomplete dates limit the certainty of this temporal pattern. The planned local record review will be used to determine whether these signal clusters correspond to local nursing documentation and intervention patterns. `[AUTHOR INPUT REQUIRED: local data pending.]`

These findings should be interpreted as surveillance-priority evidence rather than intervention-effect evidence. A high ROR can arise when a PT is relatively specific to the exposure and uncommon in the comparator database, even when the absolute number of reports is modest. Conversely, frequent events may not generate the strongest disproportionality. This distinction between reporting frequency and signal strength is essential when translating pharmacovigilance findings into nursing priorities.

### 4.2 Extravasation and vascular-access surveillance

The clustering of multiple extravasation-related PTs is directly relevant to the nursing workflow around contrast administration and power injection. Within the limits of FAERS data, these signals support careful attention to vascular-access assessment, injection-site observation, patient-reported pain or swelling, and prompt escalation when extravasation is suspected. Specific prevention and management steps should follow current professional guidance and local contrast protocols rather than being inferred from disproportionality estimates alone. `[REF TO VERIFY: current ACR/ESUR guidance.]`

The source manuscript proposed a specific cannula size, mandatory warming, local 50% magnesium sulphate, traditional Chinese medicines, and potato slices. These measures are not presented as recommendations in this draft because the FAERS analysis did not evaluate them and their indications or supporting evidence have not been established for an international nursing audience. Any later procedural recommendation must be linked to current guidance and framed for the relevant contrast viscosity, injection rate, access device, patient factors, and local scope of practice.

### 4.3 Hypersensitivity-type and cardiopulmonary events

The reported cutaneous, respiratory, and cardiopulmonary PTs reinforce the importance of symptom recognition and emergency preparedness in imaging settings. The present data cannot determine immune mechanism, distinguish allergic-like from physiologic reactions reliably, or prescribe a universal observation period. Nursing implications should therefore focus on structured assessment, role clarity, access to emergency equipment and medications, escalation pathways, documentation, and discharge information consistent with current contrast-media guidance and local policy. `[REF TO VERIFY: current contrast reaction management guidance.]`

### 4.4 Kidney-related events

Kidney-related PTs, including acute kidney injury, increased blood creatinine, oliguria, and renal tubular necrosis, require especially cautious interpretation. FAERS lacks a complete exposed population and does not provide enough clinical detail to separate contrast-associated acute kidney injury (CA-AKI) from competing explanations such as baseline kidney disease, haemodynamic instability, comorbid illness, concomitant medication, indication for imaging, or acute illness severity. These data do not justify universal oral-fluid volumes, medication cessation, or claims that a particular hydration pathway prevents kidney injury. Nursing-relevant implications should instead be limited to risk recognition, communication with the clinical team, documentation, and adherence to current multidisciplinary guidance. `[REF TO VERIFY: current ACR/ESUR kidney guidance.]`

### 4.5 Implications for radiology nursing practice

The analysis supports a surveillance framework rather than a tested intervention package. A Nursing Open-facing interpretation should therefore emphasise what nurses may watch for and document, not claim that these actions reduce AE rates:

1. **Before administration:** complete locally required risk and symptom assessment, assess the planned vascular access, identify patients requiring clinician review under current guidance, and confirm emergency readiness.
2. **During administration:** observe the access site and patient-reported symptoms, recognise possible extravasation or acute reaction, stop or escalate according to local protocol, and document the timing and clinical features of the event.
3. **Immediately after administration:** reassess patients according to reaction severity, procedure, and local policy; document the contrast agent, route, dose, timing, response, and outcome; and provide discharge advice consistent with institutional guidance.
4. **Quality improvement:** use standard terminology for reactions and extravasation, audit documentation completeness and escalation processes, and evaluate any local nursing pathway with prospective or quality-improvement data rather than relying on FAERS signals alone.

This framework is a practical interpretation of the signal pattern. Its effect on clinical outcomes must be evaluated in a prospective or quality-improvement study before effectiveness claims can be made.

Local nursing records can strengthen this framework by showing which events were documented, what nursing actions were recorded and where documentation or escalation gaps occurred. However, unless the local dataset includes a defined intervention, comparator and outcome evaluation, these records should be interpreted as contextual evidence rather than proof of effectiveness.

### 4.6 Strengths and limitations

The study used a large, publicly available pharmacovigilance database over an extended period and combined disproportionality with temporal analysis. Considering multiple algorithms may improve signal robustness if all prespecified thresholds were implemented and reported completely. The planned local record review may add clinical context by linking FAERS-derived surveillance clusters to routine nursing documentation and response patterns.

The limitations are substantial. FAERS is a spontaneous-reporting system subject to under-reporting, duplicate or incomplete records, reporting stimulation, notoriety bias, geographic and temporal changes in practice, and differential product use. The number of exposed patients is unknown in FAERS, so incidence and relative risk cannot be calculated from the pharmacovigilance component. Primary-suspect designation does not establish causality. Confounding by indication, comorbidities, concomitant drugs, procedure type, injection conditions, and reporter judgement cannot be eliminated. Aggregating four agents may obscure product-specific patterns, while separate analyses may be unstable for rare events. PT-level duplication and MedDRA multiaxiality may affect counts. TTO findings are vulnerable to missing and partially recorded dates and represent only the subset with evaluable timing. The local record review, if completed, will be single-centre and dependent on documentation quality, event definitions and denominator completeness. It can contextualise nursing surveillance priorities but cannot establish general incidence or intervention effectiveness without a stronger outcome design.

## 5. Conclusion

Disproportionality and time-to-onset analyses of FAERS reports identified priority reporting signals and an early clustering pattern for four non-ionic iodinated contrast media. Extravasation-related, hypersensitivity-type, cardiopulmonary, and kidney-related events may inform radiology nursing surveillance and escalation priorities. A planned local clinical nursing record review may strengthen the clinical contextualization of these priorities by describing local contrast-administration volume, registered AEs and nursing responses. The findings remain hypothesis-generating unless verified local outcome data support stronger claims. Submission will require verification of the complete FAERS analysis, transparent reporting of local data completeness and alignment of all practice statements with current clinical guidance.

## Declarations

### Ethics approval

`[VERIFY: insert institutional determination/exemption and approval identifier if applicable.]`

### Consent to participate

Not applicable to the FAERS component. The local record review requires institutional confirmation regarding consent waiver or exemption. `[AUTHOR INPUT REQUIRED]`

### Data availability

FAERS quarterly data are publicly available from the US Food and Drug Administration. Local clinical and nursing records are not publicly available and will be summarized in de-identified aggregate form subject to institutional permission. `[VERIFY: add FAERS retrieval dates, exact dataset URL, archived query dictionary, processed data/code availability and local data-access statement.]`

### Code availability

`[VERIFY: state whether the analysis code and drug dictionary will be deposited and where.]`

### Funding

`[AUTHOR INPUT REQUIRED]`

### Conflicts of interest

`[AUTHOR INPUT REQUIRED]`

### Author contributions

`[AUTHOR INPUT REQUIRED; use the CRediT taxonomy if required by the selected journal.]`

### Acknowledgements

`[AUTHOR INPUT REQUIRED]`

### Patient or public contribution

No patient or public contribution. `[VERIFY: author confirmation required.]`

## References

The source manuscript's bilingual reference list is not carried forward because it contains duplicate numbering, untranslated journal metadata, and at least one mismatched English citation. A single verified English reference list will be rebuilt after the analytical outputs are confirmed and before journal-specific formatting.
