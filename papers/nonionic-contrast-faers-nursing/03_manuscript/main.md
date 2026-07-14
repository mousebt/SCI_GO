# Safety Signals of Non-Ionic Iodinated Contrast Media in FAERS and Implications for Radiology Nursing Practice

**Manuscript status:** Nursing Open-facing working draft v0.4; Introduction, Methods, and Results rewritten for evidence-first review

**Evidence status:** All numerical results retained from the Chinese source manuscript require verification against the original analysis output. Items marked `[VERIFY]` must be resolved before submission.

**Inference boundary:** This pharmacovigilance study identifies reporting signals. It does not estimate incidence, establish causality, compare absolute drug safety, or test the effectiveness of nursing interventions.

## Abstract

### Background

Non-ionic iodinated contrast media are widely used in diagnostic and interventional imaging. Although most administrations are uneventful, contrast extravasation, hypersensitivity reactions, acute kidney injury, and cardiopulmonary events require timely recognition and escalation by radiology nursing teams. Large spontaneous-reporting databases may help prioritise uncommon or clinically important safety events that are difficult to characterise in single-centre studies.

### Aim

To characterise adverse-event reporting signals and time-to-onset patterns for four non-ionic iodinated contrast media in the US Food and Drug Administration Adverse Event Reporting System (FAERS), and to consider their implications for radiology nursing surveillance.

### Methods

FAERS reports from the first quarter of 2004 through the fourth quarter of 2025 were searched for ioversol, iohexol, iopamidol, and iodixanol designated as primary suspect drugs. Adverse events were coded using Medical Dictionary for Regulatory Activities preferred terms and system organ classes. Reporting odds ratio, proportional reporting ratio, Bayesian confidence propagation neural network, and multi-item gamma Poisson shrinker methods were prespecified for signal detection. Time to onset was summarised and modelled using a Weibull distribution. `[VERIFY: MedDRA version, legacy AERS/FAERS field harmonisation, drug-name dictionary, complete algorithm thresholds, and software/package versions.]`

### Results

The source analysis included 14,780 eligible reports containing 42,808 adverse-event records and 951 preferred terms. Twenty-four preferred terms met the stated signal criteria. Extravasation-related terms showed the strongest disproportionality, while shock, acute pulmonary oedema, renal tubular necrosis, pruritus, erythema, dyspnoea, and acute kidney injury were among the clinically relevant signals. Of 12,588 reports with an evaluable time to onset, 81.56% occurred within 24 hours. The Weibull shape parameter was below 1, consistent with an early-failure pattern. `[VERIFY ALL NUMERICAL RESULTS AGAINST THE ORIGINAL OUTPUT.]`

### Conclusions

FAERS data identified a set of reported events that may help radiology nurses prioritise vascular-access assessment, early symptom surveillance, and escalation preparedness around contrast administration. These findings are hypothesis-generating and should be interpreted alongside clinical guidelines, local protocols, and patient-specific assessment; they do not demonstrate that any nursing intervention reduces adverse-event rates.

**Keywords:** contrast media; FAERS; pharmacovigilance; radiology nursing; disproportionality analysis; time to onset

## 1. Introduction

Non-ionic iodinated contrast media (ICM) are integral to contemporary diagnostic and interventional imaging. Although these agents are widely used, their administration can be accompanied by adverse events (AEs) that require rapid recognition and escalation in imaging settings, including contrast extravasation, hypersensitivity-type reactions, cardiopulmonary compromise, and kidney-related events. `[REF TO VERIFY: current contrast-media safety guidance.]`

Radiology nurses contribute to patient safety across the contrast-administration pathway. Their work may include pre-procedure assessment, vascular-access evaluation, observation during power injection, recognition of acute symptoms, activation of emergency response, post-procedure advice, and documentation. For this clinical workflow, the practical question is not simply which AEs can occur, but which reported events should be prioritised for surveillance and when vigilance is most critical.

Clinical trials and single-centre observational studies are usually not designed to detect rare events or broad reporting patterns across heterogeneous populations. The US Food and Drug Administration Adverse Event Reporting System (FAERS) therefore offers a complementary source for pharmacovigilance. Disproportionality analysis can identify drug-event combinations reported more frequently than expected relative to a comparator background. However, spontaneous reports are affected by under-reporting, stimulated reporting, missing data, duplicate records, confounding, and the absence of a denominator representing all exposed patients. A disproportionality signal is therefore a statistical reporting association, not an incidence estimate or proof of causality. `[REF TO VERIFY: FDA FAERS limitations and READUS-PV.]`

Previous work on ICM safety has often focused on particular clinical outcomes, specific patient-risk groups, or local preventive interventions. Less attention has been paid to how broad spontaneous-reporting patterns and event timing might be translated into nursing-sensitive surveillance priorities without overstating the evidence. This study therefore aimed to characterise AE reporting signals and time-to-onset patterns for four non-ionic ICM in FAERS and to interpret the findings within the bounded context of radiology nursing surveillance.

## 2. Methods

### 2.1 Design

This was a retrospective pharmacovigilance study using spontaneous reports from the US Food and Drug Administration Adverse Event Reporting System (FAERS). The analysis was designed to identify signals of disproportionate reporting and time-to-onset (TTO) patterns for selected non-ionic iodinated contrast media (ICM). It was not designed to estimate incidence, establish causality, rank the absolute safety of individual agents, or test nursing interventions.

### 2.2 Data source

FAERS quarterly files from 2004 quarter 1 through 2025 quarter 4 were used. The source files comprised demographic and administrative information (DEMO), drug information (DRUG), adverse reactions (REAC), and patient outcomes (OUTC). `[VERIFY: date on which the 2025 Q4 files were downloaded and confirm that this quarter was publicly available and complete at extraction.]`

Because the study period spans the legacy AERS and current FAERS formats, variable names and coding conventions were harmonised before quarterly files were merged. `[VERIFY: provide the exact harmonisation rules, quarter-level file inventory, and deletion-file handling.]`

### 2.3 Report identification and deduplication

Eligible reports were those listing ioversol, iohexol, iopamidol, or iodixanol as the primary suspect drug. The source manuscript states that generic English names were used as search terms. `[VERIFY: supply the complete version-controlled dictionary of generic names, brand names, spelling variants, salts, and normalisation rules. Clarify whether combination products or ambiguous names were excluded.]`

Reports were deduplicated using CASEID, FDA_DT, and PRIMARYID in accordance with the procedure described by the FDA. For records sharing a CASEID, the report with the latest FDA_DT was retained; when CASEID and FDA_DT were identical, the record with the highest PRIMARYID was retained. Reports listed in deletion files were excluded. `[VERIFY: confirm that this procedure was applied consistently to every quarter and whether follow-up versions were linked before analysis.]`

### 2.4 Adverse-event coding

Reported adverse events (AEs) were analysed at the Medical Dictionary for Regulatory Activities (MedDRA) preferred term (PT) and system organ class (SOC) levels. A single report could contain more than one PT; therefore, the number of AE records could exceed the number of reports. `[VERIFY: MedDRA version, mapping procedure, handling of legacy terms, and whether primary SOC or multiaxial SOC allocation was used.]`

### 2.5 Disproportionality analysis

Four complementary disproportionality methods were prespecified: the reporting odds ratio (ROR), proportional reporting ratio (PRR), Bayesian confidence propagation neural network information component (IC), and multi-item gamma Poisson shrinker empirical Bayes geometric mean (EBGM). A drug-event pair was defined as a signal only when it met the prespecified minimum case count and the positive thresholds for the required algorithms.

The source manuscript lists the following screening rules: a minimum of three reports, lower 95% confidence limit for ROR greater than 1, PRR greater than 2 with chi-square at least 4, IC025 greater than 0, and EBGM05 greater than 2. `[VERIFY: reproduce the exact 2 x 2 table, equations, continuity corrections, comparator dataset, threshold logic, and whether all four algorithms - rather than a subset - were actually applied to the final tables.]`

Signal magnitude was interpreted as the strength of disproportionate reporting, not as event probability, clinical severity, or causal effect. The current working draft treats the four contrast agents as a pooled ICM exposure group. `[VERIFY: provide agent-specific and sensitivity analyses if available; otherwise justify pooling and avoid comparative claims between agents.]`

### 2.6 Time-to-onset analysis

TTO was calculated as the interval between the recorded treatment start date and AE onset date. Reports with missing, implausible, or negative intervals were excluded. TTO was summarised using descriptive statistics and modelled with a Weibull distribution. A shape parameter below 1 was interpreted as an early-failure pattern, indicating that reports with evaluable timing were concentrated early after administration. `[VERIFY: date fields used, imputation rules for partial dates, treatment of same-day events, time unit, maximum follow-up, median and interquartile range, Weibull confidence intervals, and fitting procedure.]`

### 2.7 Ethical considerations

FAERS contains publicly available, de-identified spontaneous reports. Formal informed consent was therefore not applicable to this secondary analysis. `[VERIFY: insert the authors' institutional ethics/IRB determination or exemption statement required by Nursing Open and the authors' institution.]`

### 2.8 Reporting and software

The final manuscript will be checked against a relevant EQUATOR reporting checklist and pharmacovigilance reporting guidance. `[VERIFY: decide whether the submission will use STROBE, RECORD/STROBE, READUS-PV support, or a combined checklist note.]` Data processing was performed with Python 3.11 and MySQL. `[VERIFY: operating environment, MySQL version, Python packages and versions, analysis code, random seeds where applicable, and quality-control checks.]`

## 3. Results

### 3.1 Report selection and characteristics

The source analysis retained 14,780 eligible FAERS reports for the four non-ionic iodinated contrast media (ICM). `[VERIFY: confirm the final flow diagram, quarter-level file inventory, deletion-file exclusions, and deduplication output.]` These reports contained 42,808 adverse-event (AE) records mapped to 951 Medical Dictionary for Regulatory Activities preferred terms (PTs) across 27 system organ classes (SOCs). `[VERIFY: confirm MedDRA version, PT/SOC mapping procedure, and whether primary SOC or multiaxial SOC allocation was used.]`

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

## 4. Discussion

### 4.1 Principal findings

This FAERS analysis generated three findings relevant to radiology nursing surveillance. First, extravasation-related PTs had the largest displayed disproportionality estimates, highlighting vascular-access and injection-site surveillance as a priority. Second, reported hypersensitivity-type and cardiopulmonary events - including pruritus, erythema, dyspnoea, hypotension, shock, acute pulmonary oedema, and cardiac arrest - support readiness for rapid assessment and escalation. Third, most evaluable reports occurred within 24 hours and the Weibull model suggested an early concentration of reports, although missing and incomplete dates limit the certainty of this temporal pattern.

The findings should not be read as a ranking of incidence or severity. A high ROR can arise when a PT is relatively specific to the exposure and uncommon in the comparator database, even when the absolute number of reports is modest. Conversely, frequent events may not generate the strongest disproportionality. The distinction between reporting frequency and signal strength is essential when translating pharmacovigilance results into practice priorities.

### 4.2 Extravasation and vascular-access surveillance

The clustering of multiple extravasation-related PTs is directly relevant to the nursing workflow around power injection. Before administration, assessment should follow current professional guidance and the institution's contrast protocol, including evaluation of the access site and device for the planned injection. During injection, staff should remain alert to pain, swelling, resistance, or other signs of infiltration and should stop injection and assess the patient when extravasation is suspected. Subsequent management and escalation should follow a current evidence-based local protocol. `[REF TO VERIFY: current ACR/ESUR guidance.]`

The source manuscript proposed a specific cannula size, mandatory warming, local 50% magnesium sulphate, traditional Chinese medicines, and potato slices. These measures are not presented as recommendations in this draft because the FAERS analysis did not evaluate them and their indications or supporting evidence have not been established for an international nursing audience. Any later procedural recommendation must be linked to current guidance and framed for the relevant contrast viscosity, injection rate, access device, patient factors, and local scope of practice.

### 4.3 Hypersensitivity-type and cardiopulmonary events

The reported signals for cutaneous symptoms, dyspnoea, hypotension, shock, pulmonary oedema, and cardiac arrest reinforce the importance of symptom recognition and emergency preparedness. The present data cannot determine immune mechanism, distinguish allergic-like from physiologic reactions reliably, or prescribe a universal observation period. Nursing implications should therefore focus on structured assessment, access to emergency equipment and medications, role clarity, escalation pathways, and discharge information consistent with current contrast-media guidance and local policy. `[REF TO VERIFY.]`

### 4.4 Kidney-related events

Acute kidney injury, increased blood creatinine, oliguria, renal tubular necrosis, and related terms require cautious interpretation because FAERS lacks a complete exposed population and contains substantial clinical confounding. Baseline kidney function, haemodynamic instability, comorbid illness, concomitant medication, indication for imaging, and competing causes may all influence reporting. The data do not justify universal oral-fluid volumes, medication cessation, or claims that a particular hydration pathway prevents injury. Pre-procedure assessment, escalation of identified risk, and any hydration or medication decisions should instead follow current multidisciplinary guidance and individual clinical evaluation. `[REF TO VERIFY: current ACR/ESUR kidney guidance.]`

### 4.5 Implications for radiology nursing practice

The analysis supports a surveillance framework rather than a tested intervention package:

1. **Before administration:** verify patient identity and contrast order; complete the locally required risk and symptom history; assess the planned vascular access; identify cases requiring clinician review under current guidelines; and confirm emergency readiness.
2. **During administration:** maintain observation appropriate to the setting; monitor the access site and patient-reported symptoms; stop the injection when extravasation or a clinically important reaction is suspected; and activate the defined escalation pathway.
3. **Immediately after administration:** reassess patients according to reaction severity, procedure, and local policy; document the event, contrast agent, route, dose, timing, response, and outcome; and provide clear instructions for seeking help after discharge.
4. **Quality improvement:** use standard terminology for reactions and extravasation, audit response times and documentation completeness, and separate local outcome evaluation from FAERS signal evidence.

This framework is a practical interpretation of the signal pattern. Its effect on clinical outcomes must be evaluated in a prospective or quality-improvement study before effectiveness claims can be made.

### 4.6 Strengths and limitations

The study used a large, publicly available pharmacovigilance database over an extended period and combined disproportionality with temporal analysis. Considering multiple algorithms may improve signal robustness if all prespecified thresholds were implemented and reported completely.

The limitations are substantial. FAERS is a spontaneous-reporting system subject to under-reporting, duplicate or incomplete records, reporting stimulation, notoriety bias, geographic and temporal changes in practice, and differential product use. The number of exposed patients is unknown, so incidence and relative risk cannot be calculated. Primary-suspect designation does not establish causality. Confounding by indication, comorbidities, concomitant drugs, procedure type, injection conditions, and reporter judgement cannot be eliminated. Aggregating four agents may obscure product-specific patterns, while separate analyses may be unstable for rare events. PT-level duplication and MedDRA multiaxiality may affect counts. TTO findings are vulnerable to missing and partially recorded dates and represent the subset with evaluable timing. Finally, the study did not test nursing interventions; practice implications are interpretations that require independent guideline support and outcome evaluation.

## 5. Conclusion

Disproportionality and time-to-onset analyses of FAERS reports identified priority reporting signals and an early clustering pattern for four non-ionic iodinated contrast media. Extravasation-related, hypersensitivity-type, cardiopulmonary, and kidney-related events may inform radiology nursing surveillance and escalation priorities. The findings are hypothesis-generating: they neither estimate event incidence nor establish causality or nursing intervention effectiveness. Submission will require verification of the complete analysis, transparent reporting of methods and missingness, and alignment of all practice statements with current clinical guidance.

## Declarations

### Ethics approval

`[VERIFY: insert institutional determination/exemption and approval identifier if applicable.]`

### Consent to participate

Not applicable to publicly available de-identified spontaneous reports, subject to institutional confirmation.

### Data availability

FAERS quarterly data are publicly available from the US Food and Drug Administration. `[VERIFY: add retrieval dates, exact dataset URL, archived query dictionary, and availability of processed data/code.]`

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

## References

The source manuscript's bilingual reference list is not carried forward because it contains duplicate numbering, untranslated journal metadata, and at least one mismatched English citation. A single verified English reference list will be rebuilt after the analytical outputs are confirmed and before journal-specific formatting.
