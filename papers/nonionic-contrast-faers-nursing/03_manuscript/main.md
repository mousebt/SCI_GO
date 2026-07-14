# Safety Signals of Non-Ionic Iodinated Contrast Media in FAERS and Implications for Radiology Nursing Practice

**Manuscript status:** Journal-agnostic structural draft v0.1

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

Iodinated contrast media are integral to contemporary diagnostic and interventional imaging. Non-ionic formulations such as ioversol, iohexol, iopamidol, and iodixanol are commonly selected because of their physicochemical and tolerability profiles. Nevertheless, their administration may be accompanied by events ranging from transient pruritus, erythema, nausea, and vomiting to extravasation, severe hypersensitivity reactions, acute kidney injury, and cardiopulmonary compromise. `[REF TO VERIFY]`

Radiology nurses contribute to safety across the contrast-administration pathway. Their responsibilities may include pre-procedure assessment, vascular-access evaluation, observation during power injection, recognition of acute symptoms, activation of emergency response, post-procedure advice, and documentation. The practical challenge is not merely to list possible adverse events, but to determine which events warrant heightened surveillance and when vigilance is most critical.

Clinical trials and single-centre observational studies are usually not designed to detect rare events or broad patterns across heterogeneous populations. FAERS therefore offers a complementary source for pharmacovigilance. Disproportionality analysis can identify drug–event combinations reported more frequently than expected relative to a comparator background. However, spontaneous reports are affected by under-reporting, stimulated reporting, missing data, duplicate records, confounding, and the absence of a denominator representing all exposed patients. A signal is thus a statistical reporting association rather than an incidence estimate or proof of causality. `[REF TO VERIFY: FDA FAERS limitations and READUS-PV.]`

Previous work on iodinated contrast safety has often focused on particular clinical outcomes or local preventive interventions. A nursing-focused synthesis of broad reporting patterns and event timing could help generate surveillance priorities, provided that pharmacovigilance findings are kept separate from evidence supporting specific interventions. This study therefore aimed to characterise reported adverse-event signals and time-to-onset patterns for four non-ionic iodinated contrast media in FAERS and to interpret the findings within the bounded context of radiology nursing surveillance.

## 2. Methods

### 2.1 Study design and data source

We conducted a retrospective pharmacovigilance study using publicly available FAERS data from 2004 quarter 1 through 2025 quarter 4. The source files comprised demographic and administrative information (DEMO), drug information (DRUG), adverse reactions (REAC), and patient outcomes (OUTC). `[VERIFY: date on which the 2025 Q4 files were downloaded and confirm that this quarter was publicly available and complete at extraction.]`

Because the study period spans the legacy AERS and current FAERS formats, variable names and coding conventions were harmonised before merging quarterly files. `[VERIFY: provide the exact harmonisation rules and a quarter-level file inventory.]`

### 2.2 Report identification and deduplication

Reports were deduplicated using CASEID, FDA_DT, and PRIMARYID in accordance with the procedure described by the FDA. For records sharing a CASEID, the report with the latest FDA_DT was retained; when CASEID and FDA_DT were identical, the record with the highest PRIMARYID was retained. Reports listed in deletion files were excluded. `[VERIFY: whether this procedure was applied consistently to every quarter and whether follow-up versions were linked before analysis.]`

The exposure definition included ioversol, iohexol, iopamidol, and iodixanol recorded as the primary suspect drug. The source manuscript states that the generic English names were used as search terms. `[VERIFY: supply the complete, version-controlled dictionary of generic names, brand names, spelling variants, salts, and normalisation rules. Clarify whether combination products or ambiguous names were excluded.]`

### 2.3 Adverse-event coding

Reported events were mapped to Medical Dictionary for Regulatory Activities (MedDRA) preferred terms (PTs) and system organ classes (SOCs). `[VERIFY: MedDRA version, mapping procedure, handling of legacy terms, and whether primary SOC or multiaxial allocation was used.]` A single report could contain more than one PT; therefore, the number of event records exceeded the number of reports.

### 2.4 Disproportionality analysis

Four complementary methods were prespecified: the reporting odds ratio (ROR), proportional reporting ratio (PRR), Bayesian confidence propagation neural network information component (IC), and multi-item gamma Poisson shrinker empirical Bayes geometric mean (EBGM). A drug–event pair was defined as a signal only when it met the prespecified minimum case count and the positive thresholds for all required algorithms. The source manuscript lists a minimum of three reports, a lower 95% confidence limit for ROR greater than 1, PRR greater than 2 with chi-square at least 4, IC025 greater than 0, and EBGM05 greater than 2. `[VERIFY: reproduce the exact 2 × 2 table, equations, continuity corrections, comparator dataset, threshold logic, and whether all four algorithms—not three—were actually applied.]`

Signal magnitude was interpreted as the strength of disproportionate reporting, not as event probability, clinical severity, or causal effect. Analyses were pooled across the four contrast media in the current draft. `[VERIFY: provide agent-specific and sensitivity analyses if available; otherwise justify pooling and avoid comparative claims.]`

### 2.5 Time-to-onset analysis

Time to onset (TTO) was calculated as the interval between the recorded treatment start date and adverse-event onset date. Reports with missing, implausible, or negative intervals were excluded. TTO was summarised using the median and interquartile range and modelled with a Weibull distribution. A shape parameter below 1 was interpreted as an early-failure pattern, indicating decreasing reporting hazard over time. `[VERIFY: date fields used, imputation rules for partial dates, treatment of same-day events, time unit, maximum follow-up, median and IQR, Weibull confidence intervals, and fitting procedure.]`

### 2.6 Statistical software

Data processing was performed with Python 3.11 and MySQL. `[VERIFY: operating environment, MySQL version, Python packages and versions, analysis code, random seeds where applicable, and quality-control checks.]`

### 2.7 Ethics and reporting

FAERS contains publicly available, de-identified reports. `[VERIFY: institutional ethics/IRB determination or exemption statement required by the authors' institution and target journal.]` The final manuscript will be checked against the READUS-PV reporting recommendations. `[REF TO VERIFY]`

## 3. Results

### 3.1 Report selection and characteristics

The source analysis identified 14,780 eligible reports. Women accounted for 6,932 reports (46.90%), men for 5,137 (34.76%), and sex was unknown in 2,711 (18.34%). Age was below 18 years in 269 reports (1.82%), 18–59 years in 5,355 (36.23%), 60 years or older in 4,980 (33.69%), and missing in 4,176 (28.25%). The United States was the most frequently reported country (5,895; 39.88%), followed by China (1,386; 9.38%) and Japan (1,016; 6.87%). `[VERIFY: denominators, category coding, reporter categories, and consistency with the final flow diagram.]`

The Chinese source table labels its five most frequently reported PTs as “indications”; this label is incorrect and will be changed to “preferred terms.” Pruritus (1,744; 11.80%), dyspnoea (1,612; 10.91%), erythema (1,012; 6.85%), nausea (888; 6.01%), and vomiting (818; 5.53%) were the five most frequently reported PTs in that table. `[VERIFY: nausea appears in the baseline table but not among the 24-signal table; clarify whether frequency and signal-positivity populations differ.]`

### 3.2 SOC- and PT-level reporting signals

The 14,780 reports contained 42,808 adverse-event records spanning 951 PTs and 27 SOCs. Nine SOCs reportedly met the screening criteria. `[VERIFY: supply the SOC-level output, confidence bounds, event counts, and correct figure numbering; these values are absent from the source text.]`

Twenty-four PTs were reported as positive signals. The strongest displayed disproportionality estimates were for extravasation (n = 254; ROR 93.69, 95% CI 82.42–106.49), infusion-site extravasation (n = 73; ROR 16.81, 95% CI 13.33–21.18), administration-site extravasation (n = 9; ROR 13.60, 95% CI 7.05–26.23), injection-site extravasation (n = 97; ROR 10.89, 95% CI 8.91–13.31), and shock (n = 169; ROR 10.77, 95% CI 9.25–12.54). Clinically important signals also included acute pulmonary oedema, renal tubular necrosis, cardiac arrest, dyspnoea, hypotension, and acute kidney injury. `[VERIFY: PT English names against MedDRA, all counts and estimates, and complete PRR/IC/EBGM outputs. The source tables omit EBGM despite the four-algorithm claim.]`

These estimates indicate disproportionate reporting within FAERS. They do not show that these events were the most common among all contrast-exposed patients, that one contrast agent was safer than another, or that the contrast medium caused an individual event.

### 3.3 Time to onset

After exclusion of reports with missing, inaccurate, or negative time intervals, 12,588 reports were included in the TTO analysis. Of these, 81.56% were reported to have occurred within 24 hours after administration. The Weibull scale parameter was 17.3 and the shape parameter was below 1, which the source analysis classified as an early-failure pattern. `[VERIFY: provide the exact number within 24 hours, remaining interval categories, median and IQR, precise beta estimate with confidence interval, units for alpha, and the full exclusion flow.]`

## 4. Discussion

### 4.1 Principal findings

This FAERS analysis generated three findings relevant to radiology nursing surveillance. First, extravasation-related PTs had the largest displayed disproportionality estimates, highlighting vascular-access and injection-site surveillance as a priority. Second, reported hypersensitivity-type and cardiopulmonary events—including pruritus, erythema, dyspnoea, hypotension, shock, acute pulmonary oedema, and cardiac arrest—support readiness for rapid assessment and escalation. Third, most evaluable reports occurred within 24 hours and the Weibull model suggested an early concentration of reports, although missing and incomplete dates limit the certainty of this temporal pattern.

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
