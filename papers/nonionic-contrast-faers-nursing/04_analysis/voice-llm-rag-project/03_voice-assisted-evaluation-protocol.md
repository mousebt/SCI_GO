# Evaluation Protocol for Voice-Assisted, LLM- and RAG-Supported Contrast-Event Report Drafting

Version: 1.0  
Status: prespecified evaluation protocol; no performance results are implied

## 1. Evaluation objective

The evaluation will determine whether the voice-assisted workflow produces more complete and relationally explicit contrast-event report drafts while preserving fidelity to the nurse-provided source.

The evaluation separates:

1. speech-recognition performance;
2. LLM/RAG extraction and drafting performance;
3. final nurse-reviewed report quality;
4. documentation burden and usability.

## 2. System under evaluation

The frozen system will contain:

- one automatic speech recognition model;
- one LLM;
- one versioned RAG knowledge base;
- one fixed system prompt;
- one fixed structured output schema;
- one deterministic set of safety rules;
- one nurse-review interface.

The evaluated version must record:

- model names and versions;
- deployment location;
- temperature and generation parameters;
- retrieval model and version;
- chunking method;
- number of retrieved items;
- knowledge-base version;
- prompt version;
- schema version;
- evaluation date.

## 3. Knowledge-base boundary

The RAG knowledge base may contain:

- formal reporting-field definitions;
- MedDRA terms and approved synonyms;
- deterministic summaries of contrast-specific FAERS signals;
- FAERS TTO-derived timing prompts;
- neutral follow-up questions;
- missingness definitions;
- prohibited inference and human-review rules.

It must not contain patient-specific facts from the evaluation case, treatment recommendations generated from FAERS, or statements that convert a reporting signal into causality.

## 4. Evaluation phases

### Phase A: offline source-fidelity evaluation

Phase A tests whether the frozen system can transform standardised audio into an auditable draft.

#### Test materials

- de-identified standardised case scripts;
- cases covering gastrointestinal, skin/allergic-like, extravasation/local swelling, respiratory/nasal and neurological presentations;
- single-event and multi-event cases;
- complete and deliberately incomplete narratives;
- conflicting or uncertain statements;
- unanticipated events not included in FAERS prompts;
- numeric, medication-name and temporal expressions;
- standard Mandarin audio recorded under predefined noise conditions.

#### Reference standard

At least two clinical experts independently annotate:

- source-supported facts;
- applicable fields;
- acceptable synonyms;
- relationships;
- missing or uncertain fields;
- prohibited inferences;
- acceptable candidate MedDRA PTs.

Disagreements are adjudicated before evaluation. The reference set is frozen and inaccessible to the model.

#### Evaluation conditions

Recommended ablation:

1. structured prompting without RAG;
2. identical prompting with the approved RAG knowledge base.

The ASR model, LLM, generation parameters and output schema remain identical. This comparison isolates the contribution of the knowledge layer.

### Phase B: nurse crossover evaluation

Phase B evaluates documentation quality and workload under realistic use.

Each nurse completes matched standardised cases using:

- current manual documentation;
- the voice-assisted workflow.

The order of conditions is randomised. Cases are balanced by presentation type, number of facts, number of applicable fields, temporal complexity and expected management detail. The same nurse should not document the identical case in both conditions.

Outcome assessors are blinded to the documentation condition where feasible.

## 5. Independent units and repeated structure

- Phase A primary unit: standardised case-output run.
- Repeated model generations from the same case are technical repetitions and must not be treated as independent clinical cases.
- Phase B primary unit: nurse-case encounter.
- Reports are nested within nurses and cases.
- Crossover analyses must account for within-nurse pairing and case difficulty.

## 6. Primary endpoint

### Source-supported core-field completeness

For each report:

> Number of applicable core fields that are correctly populated and supported by the source ÷ number of applicable core fields in the reference standard × 100%.

A populated field containing unsupported or materially incorrect information is not counted as complete.

This endpoint combines completeness with fidelity and prevents a verbose but fabricated draft from receiving a high score.

## 7. Key secondary endpoints

### 7.1 Relationship explicitness

> Number of correctly represented applicable relationships ÷ number of applicable relationships in the reference standard × 100%.

Relationships:

- contrast product–administration;
- administration–event;
- event–management;
- management–response;
- event–outcome.

### 7.2 Unsupported-fact rate

> Number of report facts unsupported by the source or nurse confirmation ÷ total number of report facts × 100%.

### 7.3 Omission rate

> Number of reference-standard facts absent from the report ÷ total source-supported reference facts × 100%.

### 7.4 Critical-error rate

Reports containing at least one:

- negation error;
- patient or actor error;
- medication or dose error;
- temporal reversal;
- relationship error;
- unwarranted certainty upgrade.

### 7.5 Field and relation extraction

Report precision, recall and F1 for:

- product;
- administration;
- event;
- timing;
- management;
- outcome;
- each relation class.

Accuracy alone is insufficient because fields and relation classes may be imbalanced.

## 8. Speech-recognition outcomes

- character error rate for the full transcript;
- error rate for contrast-agent names;
- error rate for numbers, doses and time expressions;
- omission of negation;
- clinically consequential ASR error rate.

ASR errors and LLM errors must be reported separately.

## 9. Nursing workflow outcomes

- time from documentation start to final confirmation;
- number of edited fields;
- number of inserted, deleted and substituted characters;
- proportion of drafts accepted without substantive change;
- proportion returned or rejected;
- perceived workload using a prespecified instrument;
- usability using a prespecified instrument;
- qualitative comments on missing prompts and workflow burden.

These outcomes may only be reported after Phase B.

## 10. Error taxonomy

1. Source omission  
2. Unsupported addition  
3. Negation error  
4. Actor or subject error  
5. Medication or dose error  
6. Timing error  
7. Relationship error  
8. Terminology mapping error  
9. Certainty upgrade  
10. Failure to retain original wording  
11. Failure to identify missing information  
12. Unsafe recommendation or automated decision

## 11. Rating form

| Domain | Reference | Output | Correct | Source supported | Error type | Severity | Reviewer note |
|---|---|---|---|---|---|---|---|
| Product |  |  | Yes/No/NA | Yes/No |  |  |  |
| Administration |  |  | Yes/No/NA | Yes/No |  |  |  |
| Event |  |  | Yes/No/NA | Yes/No |  |  |  |
| Timing |  |  | Yes/No/NA | Yes/No |  |  |  |
| Management |  |  | Yes/No/NA | Yes/No |  |  |  |
| Outcome |  |  | Yes/No/NA | Yes/No |  |  |  |
| Relationship |  |  | Yes/No/NA | Yes/No |  |  |  |

## 12. Statistical analysis plan

### Phase A

- Report endpoint means with standard deviations or medians with interquartile ranges, as appropriate.
- Report case-level distributions rather than technical-run totals alone.
- Compare no-RAG and RAG conditions using paired case-level differences.
- Report the mean or median paired difference and a 95% confidence interval.
- If multiple repeated generations are used, summarize them within case or use a model that accounts for repeated runs.
- Report precision, recall and F1 with confidence intervals for field and relation classes.
- Report exact counts of critical errors.

### Phase B

- Analyse nurse-case encounters while accounting for clustering by nurse and case.
- Use a paired or mixed-effects analysis appropriate to the final sample size and endpoint distribution.
- Include documentation condition, order and period as prespecified effects where supported by the design.
- Report effect estimates and 95% confidence intervals.
- Define one primary endpoint; treat other outcomes as secondary or exploratory.
- Define the multiplicity strategy before data inspection.

No final statistical test, sample size or software version is specified until pilot variance, nurse numbers and case numbers are available.

## 13. Sample-size planning

Sample size will be based on the expected paired difference in source-supported core-field completeness.

Required pilot inputs:

- current-workflow completeness;
- voice-assisted completeness;
- standard deviation of paired differences;
- within-nurse correlation;
- number of evaluable nurses;
- number of cases per nurse;
- expected attrition or unusable audio.

The final calculation, assumptions and target sample size must be frozen before Phase B.

## 14. Acceptance criteria

Before evaluation, the team must prespecify:

- minimum acceptable source-supported completeness;
- maximum acceptable unsupported-fact rate;
- zero-tolerance critical errors, if selected;
- acceptable clinically consequential ASR error rate;
- acceptable nurse-review requirement;
- criteria for stopping or revising the workflow.

No acceptance threshold is invented in this document.

## 15. Safety monitoring

Immediately flag:

- an unsupported product or dose;
- a reversed negation;
- a fabricated treatment;
- an automated causality or seriousness determination;
- a generated recommendation not present in the approved knowledge base;
- output presented as final without nurse confirmation.

Any such event triggers root-cause review of ASR, retrieval, prompt, model and interface components.

## 16. Reporting template

### Phase A Results

> The offline evaluation included [number] standardised cases and [number] model runs. Source-supported core-field completeness was [value] without RAG and [value] with RAG, corresponding to a paired difference of [value] (95% CI [value] to [value]). Relationship explicitness was [value] and [value], respectively. Unsupported facts occurred in [number] of [number] outputs. The most frequent errors were [types].

### Phase B Results

> [Number] nurses completed [number] nurse-case encounters. Compared with current documentation, the voice-assisted workflow changed source-supported core-field completeness by [effect and 95% CI] and documentation time by [effect and 95% CI]. The unsupported-fact rate was [value]. Workload and usability results are reported in Table [number].

Bracketed values must be replaced with observed results. These templates must not be inserted into a completed Results section before evaluation.

