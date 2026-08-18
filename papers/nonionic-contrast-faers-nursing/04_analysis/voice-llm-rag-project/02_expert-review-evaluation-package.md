# Expert Review Package for the Evidence-Informed Contrast-Event Capture Fields

Version: 1.0  
Purpose: structured expert review of the candidate field set, field definitions, prompt rules and safety constraints  
Status: evaluation instrument; no expert results are implied by this document

## 1. Review objective

The review will determine whether each candidate field is necessary, clearly defined and feasible for nurses to capture after an iodinated contrast-associated adverse event. It will also determine whether each field should be required, conditionally required, optional, merged with another field or removed.

The review is a structured expert review. It must not be described as a Delphi study unless all formal Delphi procedures are implemented and reported.

## 2. Expert panel

The panel should include expertise in:

- radiology or contrast-media nursing;
- radiology;
- pharmacovigilance or medication safety;
- clinical informatics, where available.

For each expert, record:

- professional discipline;
- role and academic or clinical title;
- years of relevant experience;
- experience in contrast-media care;
- experience in adverse-event reporting;
- participation in Round 1 and Round 2.

No minimum panel size is invented in advance. The final manuscript must report the actual number, disciplines and response rate.

## 3. Materials supplied to experts

Experts will receive:

1. the candidate field dictionary;
2. definitions and allowed values;
3. the rationale for each field;
4. the evidence source for each field;
5. example neutral follow-up prompts;
6. model safety constraints;
7. instructions for scoring and free-text comments.

The source rationale will distinguish:

- universal reporting requirements;
- gaps observed in the 44-case manual registry dataset;
- contrast-specific prompts derived from FAERS;
- terminology support derived from MedDRA;
- source-fidelity and human-review requirements.

## 4. Rating domains

Each field will be scored on three four-point scales.

### 4.1 Necessity

1. Not necessary  
2. Probably unnecessary  
3. Probably necessary  
4. Necessary

### 4.2 Clarity

1. Unclear  
2. Requires major revision  
3. Requires minor revision  
4. Clear

### 4.3 Capture feasibility

1. Not feasible in the target nursing workflow  
2. Difficult to capture  
3. Feasible with minor workflow support  
4. Readily feasible

### 4.4 Field status

Experts will also select one:

- required;
- conditionally required;
- optional;
- merge;
- remove.

## 5. Quantitative summaries

For each field, report:

- number of responding experts;
- median and interquartile range for each rating domain;
- proportion rating the field 3 or 4 for necessity;
- proportion rating the field 3 or 4 for clarity;
- proportion rating the field 3 or 4 for feasibility;
- proposed field status distribution.

If content-validity indices are used, define them prospectively:

- Item-level content validity index (I-CVI): proportion of experts rating necessity as 3 or 4;
- Scale-level content validity index by average method (S-CVI/Ave): mean I-CVI across retained fields.

No universal acceptance threshold is imposed in this planning document. Before Round 1, the research team must document the threshold or decision rule it will use. Fields below the selected threshold will not be removed automatically; safety-critical fields and formal reporting requirements will undergo adjudication.

## 6. Qualitative review

Experts will provide free-text comments on:

- missing fields;
- fields that should be merged;
- fields inappropriate for nurse capture;
- conditional logic;
- ambiguous definitions;
- prompts that may induce anchoring;
- prompts that add avoidable burden;
- model outputs that require mandatory human review;
- clinical expressions that should remain in the nurse's original wording.

All comments will be coded into:

- retain without change;
- wording revision;
- definition revision;
- field merge;
- field split;
- status change;
- conditional-rule change;
- safety-rule change;
- new field;
- remove field;
- unresolved disagreement.

## 7. Review rounds

### Round 1

Experts independently rate all fields and submit comments.

The research team then:

1. summarizes quantitative ratings;
2. removes identifying information from comments;
3. documents every proposed change;
4. prepares a revised field dictionary;
5. records whether each comment was accepted, modified or rejected, with reasons.

### Round 2

Experts receive the revised dictionary and an anonymized summary of Round 1. They reassess:

- revised fields;
- disputed fields;
- new or merged fields;
- required versus conditional status;
- safety-critical constraints.

The final field set is frozen after Round 2 and versioned before system evaluation.

## 8. Adjudication rules

- Formal reporting requirements cannot be removed solely because they are difficult to capture; they may be changed from required to conditionally required only with documented justification.
- FAERS-derived items are prompts, not mandatory event labels.
- An unrestricted "other event" field and the original wording must be retained.
- Missing information must remain missing, unknown, not applicable or pending confirmation.
- The model may not infer causality, seriousness, reportability or treatment.
- A field without a patient-specific source cannot be populated by the model.

## 9. Expert review form

| Module | Field | Evidence source | Necessity 1–4 | Clarity 1–4 | Feasibility 1–4 | Status | Comments |
|---|---|---|---:|---:|---:|---|---|
| Case/source | Case identifier | reporting requirement |  |  |  |  |  |
| Case/source | Documentation date and time | reporting requirement |  |  |  |  |  |
| Case/source | Reporter role | reporting requirement/local gap |  |  |  |  |  |
| Patient | Sex | local registry/reporting requirement |  |  |  |  |  |
| Patient | Age at event | local registry/reporting requirement |  |  |  |  |  |
| Patient | Relevant allergy history | contrast-care guidance |  |  |  |  |  |
| Patient | Previous contrast reaction | contrast-care guidance |  |  |  |  |  |
| Product | Iodinated contrast generic name | reporting requirement/local gap |  |  |  |  |  |
| Product | Brand or manufacturer | reporting requirement |  |  |  |  |  |
| Administration | Dose and unit | reporting requirement/local gap |  |  |  |  |  |
| Administration | Route | reporting requirement/local gap |  |  |  |  |  |
| Administration | Site | local gap/contrast-care workflow |  |  |  |  |  |
| Administration | Rate | local gap/contrast-care workflow |  |  |  |  |  |
| Examination | Examination type | local gap |  |  |  |  |  |
| Timing | Administration start and end | reporting requirement/local gap |  |  |  |  |  |
| Event | Original nurse wording | source-fidelity rule |  |  |  |  |  |
| Event | Manifestation list | local registry/FAERS |  |  |  |  |  |
| Event | Candidate MedDRA PT | terminology support |  |  |  |  |  |
| Timing | Event onset | reporting requirement/FAERS TTO |  |  |  |  |  |
| Timing | Administration-to-onset interval | FAERS TTO/local gap |  |  |  |  |  |
| Event | Duration and progression | reporting requirement/local gap |  |  |  |  |  |
| Observation | Vital signs | contrast-care workflow |  |  |  |  |  |
| Management | Infusion stopped or modified | contrast-care workflow |  |  |  |  |  |
| Management | Nursing measures | local gap |  |  |  |  |  |
| Management | Medication and dose | reporting requirement/local gap |  |  |  |  |  |
| Escalation | Physician contacted | nursing workflow |  |  |  |  |  |
| Escalation | Resuscitation, observation or admission | reporting requirement |  |  |  |  |  |
| Outcome | Recovered, improving, unresolved, worsened or unknown | reporting requirement/local gap |  |  |  |  |  |
| Follow-up | Follow-up method and time | reporting requirement/local gap |  |  |  |  |  |
| Relationship | Product–administration relation | structured-report logic |  |  |  |  |  |
| Relationship | Administration–event relation | local gap/FAERS TTO |  |  |  |  |  |
| Relationship | Event–management relation | local gap |  |  |  |  |  |
| Relationship | Management–outcome relation | local gap |  |  |  |  |  |
| Quality | Source text for each populated field | LLM guardrail |  |  |  |  |  |
| Quality | Missingness or uncertainty state | LLM guardrail |  |  |  |  |  |
| Review | Nurse edits and final confirmation | human-review guardrail |  |  |  |  |  |

## 10. Expert review output table

| Field | Round 1 result | Revision | Round 2 result | Final status | Rationale |
|---|---|---|---|---|---|
|  |  |  |  |  |  |

## 11. Manuscript-ready reporting template

> A two-round structured expert review was conducted with [actual number] experts in [disciplines]. Experts rated each candidate field for necessity, clarity and capture feasibility on four-point scales and assigned a proposed field status. Round 1 comments were mapped to prespecified change categories and used to revise the field dictionary. Round 2 focused on revised and disputed fields. The final set contained [actual number] fields across [actual number] modules. The median ratings, content-validity indices, response rates and field-level decisions are reported in Supplementary Table [number].

The bracketed values must be replaced with observed review results before this paragraph is used as a completed Results statement.

