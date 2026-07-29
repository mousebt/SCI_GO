# From symptom logs to auditable reports: an evidence-informed nursing capture framework for iodinated contrast-associated adverse events

## Abstract

### Aim

To identify the information lost between manual symptom logging and a complete iodinated contrast-associated adverse-event report, and to use local registry gaps and pharmacovigilance evidence to develop an auditable, nurse-reviewed, voice-assisted reporting framework.

### Design

A retrospective registry audit, pharmacovigilance analysis and evidence-to-requirement development study.

### Methods

We audited 44 manually registered adverse events recorded after iodinated contrast administration during an approximately 5-year period in which the hospital performed about 9,500 contrast-enhanced examinations. The examination count was used only to describe service volume because examination-level data were unavailable. The 44 registry entries were analysed for patient characteristics, text length, non-exclusive event categories and the presence of product, administration, timing, management, outcome and relational information. We also analysed US Food and Drug Administration Adverse Event Reporting System (FAERS) reports from the first quarter of 2004 to the fourth quarter of 2025 for four non-ionic iodinated contrast media. Disproportionality was evaluated using reporting odds ratio, proportional reporting ratio, Bayesian confidence propagation neural network information component and multi-item gamma Poisson shrinker empirical Bayes geometric mean. Time to onset was analysed descriptively. Formal reporting requirements, local information gaps and FAERS-derived event and timing prompts were then mapped to candidate capture fields and a source-constrained voice, large language model and retrieval-augmented generation workflow.

### Results

The local dataset included 24 men (54.5%) and 20 women (45.5%), with a mean age of 54.0 years (standard deviation 13.5; range 32–80). Gastrointestinal manifestations were recorded in 21 cases (47.7%), skin or allergic-like manifestations in 10 (22.7%), local extravasation or swelling in 7 (15.9%), respiratory or nasal manifestations in 6 (13.6%) and neurological manifestations in 1 (2.3%). One case belonged to two categories. Event descriptions had a median length of two Chinese characters (interquartile range 2–4.25; range 2–12). All 44 entries contained sex, age and an event phrase, but the supplied registry dataset contained no fields for the specific contrast product, administration details, onset time, management, outcome or administration–event–management–outcome relationships. The FAERS analysis included 14,781 reports and 42,811 preferred-term records. Of 951 preferred terms meeting the minimum count threshold, 230 met all four disproportionality criteria. Immune system disorders and skin and subcutaneous tissue disorders met the strict four-algorithm definition at the system organ class level. Among 9,069 evaluable time-to-onset records, 8,010 (88.32%) occurred on the same day and 8,450 (93.17%) occurred within 1 day. These findings informed a seven-module candidate field set and an auditable workflow in which nurse narration is transcribed and structured by a source-constrained LLM/RAG process before mandatory nurse review.

### Conclusion

The local manual registry captured what happened at the level of brief symptom labels but did not retain the information required to reconstruct the event pathway. FAERS added contrast-specific event vocabulary and early-onset prompts but was not used to estimate incidence or infer causality. The resulting framework separates patient facts from external knowledge, preserves missingness and requires nurse confirmation. Its effect on report quality and documentation burden requires prospective evaluation.

### Implications for the profession and patient care

The framework provides a reproducible specification for capturing contrast-associated events as linked clinical narratives rather than isolated symptom labels. It may support more auditable nursing documentation if source fidelity and human review are maintained.

### Impact

The study identifies a measurable documentation-structure problem and provides a bounded route for integrating local evidence, FAERS findings and voice-assisted drafting without assigning diagnostic or reporting decisions to an LLM.

### Reporting method

The retrospective components were prepared with reference to the STROBE and RECORD reporting statements.

### Patient or public contribution

There was no patient or public involvement in the design or conduct of this retrospective data audit and framework-development study.

**Keywords:** adverse event; FAERS; iodinated contrast media; large language model; nursing documentation; retrieval-augmented generation; voice capture

## 1 | Introduction

Iodinated contrast media (ICM) are widely used in contrast-enhanced imaging. Events observed after administration include local extravasation and swelling, nausea and vomiting, skin manifestations, allergic-like reactions and respiratory symptoms.^(4,5) Nurses are commonly among the first clinicians to observe these events, initiate immediate care and document what occurred. Their documentation therefore provides an important bridge between bedside observation, clinical handover, quality management and pharmacovigilance.

Recording a symptom, however, is not equivalent to producing a complete adverse-event report. An auditable report should identify, where available, the suspected product and administration context, describe the event in the reporter's own terms, establish when it began, document management and outcome, and preserve the relationships among these elements. A note that contains only “vomiting”, “rash” or “extravasation” may record the immediate observation but cannot reconstruct the event trajectory.

This distinction matters because documentation and reporting failures are not explained solely by whether an event was noticed. Nursing research has identified workload, system accessibility, procedural uncertainty and incomplete documentation as barriers to adverse drug reaction reporting.^(13) Clinical-text studies have similarly shown that mentioning a drug and an adverse event does not ensure that the relationship between them is explicit. Relation extraction may remain substantially more difficult than identifying isolated entities.^(15,16)

Our hospital performed approximately 9,500 contrast-enhanced examinations over about 5 years and manually registered 44 events after contrast use. The examination count is a service-volume estimate without examination-level data. We therefore did not interpret 44/9,500 as an incidence or under-reporting rate. Instead, we asked whether the 44 existing entries retained enough information to support a complete and reviewable report.

The US Food and Drug Administration Adverse Event Reporting System (FAERS) provides structured patient, product, event, outcome and reporter data from spontaneous reports.^(1,2) It can support signal detection and description of reported onset patterns, but it lacks a reliable exposed-population denominator and is affected by missingness, duplicate reporting, reporting selection and confounding. FAERS is therefore suited to identifying event vocabulary and timing information that may warrant collection; it cannot determine what happened to an individual patient, establish causality or estimate local incidence.

Large language models (LLMs) may help transform natural narration into structured text, but pharmacovigilance is a safety-critical setting in which generation errors can introduce products, dates, events or outcomes that are absent from the source.^(14) Clinical adverse-event extraction studies have consequently relied on expert annotation, explicit drug–event relation tasks and expert-reviewed terminology mapping.^(15,16) The irAE.AI platform further illustrates the importance of separating deterministic pharmacovigilance data processing from LLM-mediated interaction, constraining tasks with a fixed data schema and evaluating outputs against a gold standard.^(17) Its results do not validate voice-based event reporting, but its architecture provides relevant safety principles.

We therefore aimed to: (1) quantify the event spectrum, text characteristics and information gaps in 44 local manual registry entries; (2) describe event signals and reported onset patterns for four non-ionic ICM in FAERS; (3) translate formal reporting requirements, local gaps and FAERS prompts into candidate capture fields; and (4) specify a voice-assisted workflow in which an LLM and retrieval-augmented generation (RAG) structure nurse-provided facts under mandatory human review.

## 2 | Methods

### 2.1 | Study design

The study combined three linked components: a retrospective audit of a local manual event registry, a retrospective FAERS disproportionality and time-to-onset analysis, and a prespecified evidence-to-requirement mapping process. The local audit established what the existing registry retained. FAERS provided a broader contrast-specific event vocabulary and reported onset patterns. These findings, together with formal reporting requirements, were used to develop candidate capture fields, safety rules and an evaluation protocol for voice-assisted report drafting.

The study did not test a new machine-learning algorithm. The LLM and RAG components were treated as implementation tools for organising nurse-provided information, not as diagnostic or autonomous reporting systems.

### 2.2 | Local data source and analysis unit

The hospital completed approximately 9,500 contrast-enhanced examinations over an approximately 5-year period. This number was retained only as contextual service volume because no examination-level dataset was available.

During the same period, 44 events observed after ICM use were manually registered. One registry entry was the independent analysis unit. The supplied dataset contained an identifier, sex, age and a brief event description. Identifiers were not used in the analysis or manuscript.

The local component used existing de-identified quality-management data and involved no new clinical intervention. It was exempt from ethics review and informed consent under institutional requirements. The institution is masked in this manuscript for blinded review.

### 2.3 | Local event coding

The original event wording was retained. Events were assigned to non-exclusive categories:

1. gastrointestinal manifestations, including nausea, vomiting or gastric discomfort;
2. skin or allergic-like manifestations, including allergy, raised erythema, rash, wheals, papules, urticaria or pruritus;
3. local extravasation or swelling;
4. respiratory or nasal manifestations, including coughing or sneezing;
5. neurological manifestations, including dizziness or tongue numbness.

An entry could be assigned to more than one category. Category percentages were therefore not required to sum to 100%. The coding instrument was designed for independent clinical review before final use.

### 2.4 | Audit of registry information

The audit evaluated the dataset rather than the complete nursing record. Prespecified information domains were:

- patient sex and age;
- specific ICM product;
- dose, route, site and administration rate;
- examination type;
- original event description and candidate standard terminology;
- administration time, event onset and administration-to-onset interval;
- vital signs;
- immediate nursing measures, medication treatment and escalation;
- outcome and follow-up;
- product–administration, administration–event, event–management and management–outcome relationships.

A field was coded as present when it existed in the dataset and contained a value. A field absent from the data structure or empty across all entries was coded as not retained in the supplied registry dataset. This definition does not imply that the information was absent from other hospital records.

### 2.5 | FAERS data source and target products

We used quarterly FAERS data from the first quarter of 2004 through the fourth quarter of 2025.^(1,2) The analysis included reports in which ioversol, iohexol, iopamidol or iodixanol was coded as a primary suspect product. Demographic and administrative, drug, reaction, therapy and outcome tables were used.

The archived analysis consumed pre-existing `demo_clean` and `drug_clean` tables. The verified analysis layer applied the primary-suspect restriction, generic-name matching and distinct PRIMARYID-level and report–preferred-term operations. Upstream CASEID/FDA_DT version handling, deletion-file processing and construction of the drug-name dictionary remain to be completed in the final reproducibility package.

### 2.6 | MedDRA coding

Events were analysed using Medical Dictionary for Regulatory Activities (MedDRA) version 28.0 preferred terms (PTs) and system organ classes (SOCs).^(3) A report could contain multiple PTs; PT-record counts could therefore exceed report counts. MedDRA was used to organise FAERS outputs and provide candidate terminology support. It did not replace the original local event wording.

### 2.7 | Disproportionality analysis

We used four complementary measures: reporting odds ratio (ROR), proportional reporting ratio (PRR), Bayesian confidence propagation neural network information component (IC) and multi-item gamma Poisson shrinker empirical Bayes geometric mean (EBGM).^(7–10)

A strict signal required at least three reports and all of the following:

- lower bound of the 95% confidence interval for ROR >1;
- PRR >2 with chi-square ≥4;
- IC025 >0;
- EBGM05 >2.

The main-text priority set was prespecified as the 30 strict pooled PT signals with at least 10 reports and the highest EBGM05 values. The full strict-signal output was retained as supplementary data.

Disproportionality measures were interpreted as reporting associations relative to the database background. They were not interpreted as incidence, clinical risk, severity, comparative product safety or causality.

### 2.8 | Time-to-onset analysis

Time to onset (TTO) was calculated as the difference between the recorded event date and treatment start date. Records were retained when both dates contained eight digits and the calculated interval was 0–730 days. We summarised same-day, within-1-day and within-30-day records, together with the median, quartiles and range.

Same-day events were assigned 0.5 days for Weibull fitting. The shape and scale parameters were estimated outside MySQL using the archived Python workflow. TTO rows were treated as evaluable date records, not as exposed patients or necessarily unique PRIMARYIDs.

### 2.9 | Evidence-to-requirement mapping

Candidate capture fields were derived through three complementary routes:

1. formal individual case safety reporting requirements defined the universal information structure;
2. the local audit identified information not retained in the current registry dataset;
3. FAERS PT, SOC and TTO results supplied contrast-specific event and timing prompts.

The candidate specification contained seven modules: case and source, patient, contrast product and examination, event, management, outcome, and relationships and quality control. Each field was assigned a definition, allowed value type, missingness state, follow-up rule and evidence source.

We developed a two-round structured expert-review instrument. Experts in nursing, radiology, pharmacovigilance and, where available, clinical informatics will rate each field for necessity, clarity and capture feasibility on four-point scales and propose its status as required, conditionally required, optional, merged or removed. The instrument records quantitative ratings, free-text comments, revisions and final adjudication. The process should not be described as Delphi unless formal Delphi procedures are implemented.

### 2.10 | Voice-assisted LLM/RAG workflow

The workflow begins with a nurse narrating the event in temporal order, including the patient context, contrast product and administration, event manifestations, onset, management and outcome where known. Automatic speech recognition produces a verbatim transcript.

The RAG layer retrieves only approved field definitions, MedDRA synonyms, deterministic summaries of contrast-specific FAERS findings, neutral follow-up prompts and safety rules. The LLM then maps information explicitly present in the transcript to a fixed schema. For each populated field, the output must include the supporting source span.

Field status is represented as explicit, pending confirmation, not provided or not applicable. The model may not populate a patient-specific field from external knowledge. It may not determine causality, seriousness, reportability or treatment, and it may not submit a report without nurse confirmation. The original wording and an unrestricted “other event” option are retained to reduce anchoring to known FAERS signals.

### 2.11 | Prespecified evaluation framework

We developed a two-phase evaluation protocol.

Phase A is an offline source-fidelity evaluation using de-identified standardised scripts, simulated audio and expert-adjudicated reference reports. It compares identical LLM and output-schema conditions without and with the approved RAG knowledge base. The primary endpoint is source-supported core-field completeness:

> correctly populated applicable core fields supported by the source / applicable core fields in the reference standard × 100%.

Key secondary endpoints are relationship explicitness, unsupported-fact rate, omission rate, critical-error rate, field- and relation-level precision, recall and F1, and speech-recognition error rates.

Phase B is a nurse crossover evaluation comparing current documentation with voice-assisted documentation for matched standardised cases. Outcomes include report quality, completion time, editing burden, perceived workload and usability. Reports are nested within nurses and cases; the final analysis must account for this structure.

The evaluation protocol requires freezing the cases, reference standard, primary endpoint, model, prompt, knowledge base, output schema and statistical analysis plan before testing. No evaluation outcome is reported in the present study.

### 2.12 | Statistical analysis

All 44 local entries were included in the descriptive analysis. Categorical variables are reported as n/N (%). Age is reported as mean with standard deviation, median with interquartile range and range. Event-text length is reported as mean, median with interquartile range and range. Event categories were non-exclusive. No hypothesis test was performed for the local registry audit.

FAERS report counts, PT-record counts, strict-signal counts and TTO-row counts are reported separately. Signal thresholds were prespecified. Database processing used MySQL 8.0.44. Weibull fitting used Python 3.13.9, NumPy 2.3.5, pandas 2.3.3 and SciPy 1.16.3.

## 3 | Results

### 3.1 | Local patient and event characteristics

The dataset contained 44 registry entries, including 24 men (54.5%) and 20 women (45.5%). Age ranged from 32 to 80 years, with a mean of 54.0 years (standard deviation 13.5) and a median of 52 years (interquartile range 41.75–64).

Gastrointestinal manifestations were recorded in 21 cases (47.7%), followed by skin or allergic-like manifestations in 10 (22.7%), local extravasation or swelling in 7 (15.9%), respiratory or nasal manifestations in 6 (13.6%) and neurological manifestations in 1 (2.3%). One entry contained both coughing and nausea/vomiting and was included in two categories.

Event descriptions contained a mean of 3.8 Chinese characters and a median of two characters (interquartile range 2–4.25; range 2–12). Most entries consisted of short phrases such as “vomiting”, “nausea”, “rash”, “coughing” or “hand swelling”.

**Table 1. Local registry characteristics**

| Characteristic | Result |
|---|---:|
| Registry entries | 44 |
| Men | 24 (54.5%) |
| Women | 20 (45.5%) |
| Age, mean (SD), years | 54.0 (13.5) |
| Age, median (IQR), years | 52 (41.75–64) |
| Age range, years | 32–80 |
| Gastrointestinal manifestations | 21 (47.7%) |
| Skin or allergic-like manifestations | 10 (22.7%) |
| Local extravasation or swelling | 7 (15.9%) |
| Respiratory or nasal manifestations | 6 (13.6%) |
| Neurological manifestations | 1 (2.3%) |
| Event-text length, median (IQR), Chinese characters | 2 (2–4.25) |

*Categories were non-exclusive; one case belonged to two categories.*

### 3.2 | Information retained in the manual registry

All 44 entries contained sex, age and an event manifestation. The supplied registry dataset contained no fields for the specific ICM product, dose, route, administration site or rate, examination type, administration time, event-onset time, vital signs, management, outcome or follow-up.

Because the component fields were absent, none of the entries could explicitly represent administration–event, event–management or management–outcome relationships within the supplied dataset. This result describes the registry data structure and does not establish that the information was absent from complete nursing or medical records.

**Table 2. Information retained in the supplied manual registry dataset**

| Information domain | Recorded, n/N (%) |
|---|---:|
| Sex | 44/44 (100%) |
| Age | 44/44 (100%) |
| Event manifestation | 44/44 (100%) |
| Specific contrast product | 0/44 (0%) |
| Dose, route, site or administration rate | 0/44 (0%) |
| Examination type | 0/44 (0%) |
| Administration time | 0/44 (0%) |
| Event onset or timing window | 0/44 (0%) |
| Vital signs | 0/44 (0%) |
| Management or treatment | 0/44 (0%) |
| Outcome or follow-up | 0/44 (0%) |
| Administration–event–management–outcome relationships | 0/44 (0%) |

### 3.3 | FAERS analysis population

The pooled analysis included 14,781 primary-suspect reports. Of these, 14,762 contained at least one eligible PT, yielding 42,811 report–PT records and 2,173 distinct PTs. After application of the minimum three-report threshold, 951 PTs remained; 230 met all four strict signal criteria.

The agent-specific analysis bases contained 6,443 iohexol reports, 3,272 ioversol reports, 2,797 iopamidol reports and 2,269 iodixanol reports. These were report counts, not exposed-patient denominators.

### 3.4 | FAERS event signals

Priority PT signals included contrast media reaction, contrast media allergy, contrast encephalopathy, anaphylactoid shock, air embolism, extravasation, anaphylactoid reaction, sneezing and laryngeal discomfort. Extravasation, sneezing and skin or allergic-like concepts overlapped clinically with expressions observed in the local registry, but category frequencies were not compared across the two data sources.

Two of 27 SOCs met all four strict criteria. Immune system disorders included 2,981 reports (ROR 8.53; PRR 7.01; IC 2.80; EBGM 6.97). Skin and subcutaneous tissue disorders included 5,259 reports (ROR 4.92; PRR 3.53; IC 1.82; EBGM 3.52). These values represented disproportional reporting, not incidence or clinical severity.

### 3.5 | Reported time to onset

The TTO analysis contained 9,069 evaluable rows. Of these, 8,010 (88.32%) occurred on the same day, 8,450 (93.17%) within 1 day and 9,019 (99.45%) within 30 days. The median TTO was 0 days. The Weibull input represented 8,987 distinct PRIMARYIDs; TTO rows were therefore not treated as unique exposed patients.

The early concentration of evaluable records supported explicit capture of administration time, event onset and the administration-to-onset interval. It did not establish causality for an individual report.

### 3.6 | Candidate fields and evaluation instruments

The local audit identified product, administration, timing, management, outcome and relationship information as missing from the supplied registry structure. FAERS added contrast-specific event vocabulary and early-onset prompts. Together with formal reporting requirements, these findings were mapped to seven candidate modules: case and source, patient, contrast product and examination, event, management, outcome, and relationships and quality control.

Two evaluation instruments were developed. The first specifies a two-round structured expert review of field necessity, clarity, feasibility and status, together with revision and adjudication rules. The second specifies offline source-fidelity and nurse crossover evaluations for the voice-assisted workflow. Neither instrument generates an effectiveness result by itself.

## 4 | Discussion

### 4.1 | Principal findings

The central finding was not that the local registry contained few events, but that it retained events predominantly as extremely short symptom labels. Every entry described a manifestation, yet the median description was only two Chinese characters, and product, administration, timing, management and outcome information was absent from the supplied data structure. The registry could therefore support a count of symptom expressions but not reconstruction of the event pathway.

This distinction places the local service-volume figure in its proper context. The 44 registry entries do not demonstrate under-reporting, and 44/9,500 is not an incidence estimate. The directly supported problem is structural: the manual dataset records what happened at a symptom level but not the information required to review how the event unfolded.

### 4.2 | How FAERS informs capture without becoming a clinical label set

FAERS broadened the event vocabulary available beyond the small local dataset. Signals involving extravasation, sneezing, immune-system events and skin events were clinically consistent with several local expressions. In addition, 88.32% of evaluable TTO rows were recorded on the day of administration, reinforcing the importance of documenting administration and onset times while the event is recent.

This correspondence should not be interpreted as frequency validation. The local registry and FAERS differ in source population, reporting mechanisms and denominators. FAERS can identify what a capture workflow should be prepared to ask about; it cannot determine what occurred locally or define an exhaustive event list. Retaining the nurse's original wording and an unrestricted “other event” entry is therefore essential.

### 4.3 | Capturing relationships rather than isolated entities

Previous clinical-text studies have shown that identifying a medication or an adverse event is easier than establishing the relationship between them.^(15,16) The local registry demonstrated the practical consequence of this distinction. Symptom entities were present, but the product, timing, management and outcome entities needed to construct relationships were not retained.

The framework consequently treats relationships as first-class reporting elements. Formal reporting requirements provide the stable structure; the local audit identifies the fields that require reinforcement; and FAERS contributes contrast-specific event and timing prompts. This division of roles prevents the spontaneous-reporting database from substituting for either patient facts or reporting standards.

### 4.4 | A bounded role for LLMs and RAG

The LLM is not a diagnostician or reporting authority in this framework. Generative pharmacovigilance systems can mismatch products, dates, events and outcomes, which makes source tracing and human review necessary.^(14) irAE.AI separated deterministic FAERS processing from LLM-mediated analysis and evaluated fixed tasks against gold-standard outputs.^(17) We adopted the transferable principle, not the application-specific performance claim.

Accordingly, the LLM does not “learn FAERS and identify the patient's event”. FAERS statistics remain deterministic evidence objects. RAG provides field definitions, terminology candidates and neutral prompts. Patient-specific facts must come from nurse narration, and every populated field must retain a source span. An unknown value remains unknown. A MedDRA term is a candidate mapping rather than a replacement for the original clinical expression.

### 4.5 | Nursing implications

Nurses may hold a rich chronological account of an acute event even when the final registry contains only a symptom label. Voice capture could reduce the translation burden between this account and a structured report, while targeted prompts could draw attention to product, onset, management and outcome information.

These are design expectations rather than observed effects. A claim of improved nursing documentation requires a controlled evaluation showing higher source-supported completeness or relationship explicitness without an unacceptable unsupported-fact rate. Claims regarding time, workload and usability additionally require nurse participation.

### 4.6 | Strengths and limitations

The study linked a directly observed local data-structure problem to a large pharmacovigilance analysis and an implementation-neutral specification. It also separated deterministic FAERS evidence from generative processing and made source fidelity and nurse review explicit design requirements.

Several limitations constrain interpretation. First, the local dataset was small and from one hospital. Its limited structure does not establish what information may exist in other nursing or medical records. The event categories require final independent clinical review. Second, FAERS is a spontaneous-reporting database with missingness, duplication, reporting selection and confounding. Although the analysis layer was audited, the upstream case-version, deletion-file and drug-dictionary processes require completion in the reproducibility package. Third, the field set has not yet completed expert review, and the voice-assisted workflow has not been evaluated. The present study therefore supports framework development, not intervention effectiveness.

## 5 | Conclusion

The 44 local manual registry entries captured brief manifestations after ICM use, with a median event-description length of two Chinese characters, but did not retain the product, administration, timing, management, outcome and relationship information required to reconstruct an auditable report. FAERS added contrast-specific event vocabulary and showed that evaluable reports were concentrated early after administration.

These evidence sources support a structured capture framework built around formal reporting requirements, contrast-specific prompts, nurse narration, explicit missingness, source tracing and mandatory nurse confirmation. Expert review and prospective evaluation are required before the framework can be claimed to improve report quality or nursing documentation burden.

## Data availability

The de-identified aggregate local results, derived tables, candidate field specification, expert-review instrument and evaluation protocol are retained in the study package. The raw local registry is not publicly released because it originated from institutional quality-management records. FAERS source files are publicly available from the US Food and Drug Administration. Derived FAERS tables and archived analysis scripts can be shared with the reproducibility package, subject to MedDRA licensing restrictions.

## References

1. US Food and Drug Administration. FDA Adverse Event Reporting System (FAERS) database. https://www.fda.gov/drugs/drug-approvals-and-databases/fda-adverse-event-reporting-system-faers-database/
2. US Food and Drug Administration. FDA Adverse Event Monitoring System (AEMS): latest quarterly data files. https://www.fda.gov/drugs/fda-adverse-event-monitoring-system-aems/fda-adverse-event-monitoring-system-aems-latest-quarterly-data-files
3. MedDRA MSSO. *Introductory Guide for MedDRA Version 28.0*. Medical Dictionary for Regulatory Activities; 2025.
4. European Society of Urogenital Radiology Contrast Media Safety Committee. *ESUR Guidelines on Contrast Agents*. Version 10.0. 2018. https://www.esur.org/esur-guidelines-on-contrast-agents/
5. American College of Radiology Committee on Drugs and Contrast Media. *ACR Manual on Contrast Media*. American College of Radiology. https://www.acr.org/clinical-resources/clinical-tools-and-reference/contrast-manual
6. Davenport MS, Perazella MA, Yee J, et al. Use of intravenous iodinated contrast media in patients with kidney disease: consensus statements from the American College of Radiology and the National Kidney Foundation. *Radiology*. 2020;294(3):660–668. doi:10.1148/radiol.2019192094.
7. Evans SJW, Waller PC, Davis S. Use of proportional reporting ratios for signal generation from spontaneous adverse drug reaction reports. *Pharmacoepidemiol Drug Saf*. 2001;10(6):483–486. doi:10.1002/pds.677.
8. van Puijenbroek EP, Bate A, Leufkens HGM, et al. A comparison of measures of disproportionality for signal detection in spontaneous reporting systems for adverse drug reactions. *Pharmacoepidemiol Drug Saf*. 2002;11(1):3–10. doi:10.1002/pds.668.
9. Bate A, Lindquist M, Edwards IR, et al. A Bayesian neural network method for adverse drug reaction signal generation. *Eur J Clin Pharmacol*. 1998;54(4):315–321. doi:10.1007/s002280050466.
10. DuMouchel W. Bayesian data mining in large frequency tables, with an application to the FDA spontaneous reporting system. *Am Stat*. 1999;53(3):177–190. doi:10.1080/00031305.1999.10474456.
11. von Elm E, Altman DG, Egger M, et al. The Strengthening the Reporting of Observational Studies in Epidemiology statement. *PLoS Med*. 2007;4(10):e296. doi:10.1371/journal.pmed.0040296.
12. Benchimol EI, Smeeth L, Guttmann A, et al. The RECORD statement. *PLoS Med*. 2015;12(10):e1001885. doi:10.1371/journal.pmed.1001885.
13. Kabiri N, Hajebrahimi S, Rahmani P, et al. Implementing best practices for nurses in detecting and reporting adverse drug reactions in a tertiary hospital in Tabriz, Iran: a mixed-method study. *Health Sci Rep*. 2024;7(12):e70277. doi:10.1002/hsr2.70277.
14. Hakim JB, Painter JL, Ramcharran D, et al. The need for guardrails with large language models in pharmacovigilance and other medical safety critical settings. *Sci Rep*. 2025;15:27886. doi:10.1038/s41598-025-09138-0.
15. Silverman AL, Sushil M, Bhasuran B, et al. Algorithmic identification of treatment-emergent adverse events from clinical notes using large language models: a pilot study in inflammatory bowel disease. *Clin Pharmacol Ther*. 2024;115(6):1391–1399. doi:10.1002/cpt.3226.
16. Kopacheva E, Lincke A, Björneld O, Hammar T. Detecting adverse drug events in clinical notes using large language models. *Stud Health Technol Inform*. 2025;327:892–893. doi:10.3233/SHTI250495.
17. Fort G, Stone D, Lin C-N, Young A, Tan AC. irAE.AI: AI-powered exploration of real-world immune-related adverse events. *JAMIA Open*. 2026;9(3):ooag094. doi:10.1093/jamiaopen/ooag094.
