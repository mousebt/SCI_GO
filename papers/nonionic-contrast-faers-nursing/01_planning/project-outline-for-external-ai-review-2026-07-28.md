# Project Outline for External AI Review

## 1. Project identification

- **Project ID:** nonionic-contrast-faers-nursing
- **Current stage:** structural planning before full-manuscript revision
- **Target journal route:** Nursing Open first; Current Medical Science as fallback
- **Planned article type:** quantitative empirical research with an evidence-informed, unvalidated reporting workflow
- **Primary readers:** nursing researchers, radiology nurses, nursing managers, pharmacovigilance personnel and multidisciplinary iodinated-contrast safety teams
- **Approved structural decision:** APR-20260728-132232-75230b

## 2. Working title

### Recommended title

**FAERS Signals and Local Documentation Gaps for Non-Ionic Iodinated Contrast Media: Defining Requirements for a Standardized, Human-Reviewed Nursing Adverse-Event Reporting Workflow**

### Alternative title with a stronger digital-health emphasis

**From FAERS Signals to Nursing Adverse-Event Reporting: A Local Documentation Audit and Evidence-Informed Workflow Requirements for Non-Ionic Iodinated Contrast Media**

The recommended title does not foreground the large language model (LLM), because the present study does not implement or validate an LLM system.

## 3. One-sentence argument

In nursing reporting of suspected adverse events associated with non-ionic iodinated contrast media, FAERS signal and time-to-onset analyses identify contrast-specific events and timing information that should be prioritised, while a five-year local registry of 39 events is used to identify missing or weakly linked reporting fields; these two evidence sources inform a standardized, source-grounded and human-reviewed reporting specification whose effects require future testing.

## 4. Central organising principle

The manuscript is organised around **one nursing adverse-event reporting information chain**, not around three parallel technologies.

```text
Universal reporting requirements
        +
FAERS contrast-specific event and timing knowledge
        ↓
Local documentation-gap audit
        ↓
Reporting requirements specification
        ↓
Technology-neutral capture and review state
        ↓
Deterministic checks and human approval
        ↓
Institutional adverse-event report
```

### Functional division of the evidence

| Component | Function in the argument | What it does not establish |
|---|---|---|
| ICSR requirements and MedDRA | Define universal report validity, field structure and standard terminology | Local completeness or workflow performance |
| FAERS analysis | Provide contrast-specific event vocabulary, reporting priorities and timing patterns | Incidence, causality or a complete clinical guideline |
| Local five-year registry | Diagnose whether the existing record captures required fields and relationships | Incidence without a denominator; intervention effectiveness |
| Candidate digital implementation | Possible means of converting supplied information into a reviewable structured draft | No demonstrated usability, efficiency or source-fidelity improvement |
| Guardrails and human review | Proposed controls for source fidelity, missingness, terminology and unsafe inference | Elimination of all model errors |

## 5. Three design objectives

The framework has three **design objectives**, not three demonstrated outcomes.

### 5.1 Standardization and completeness

Mechanisms:

- ICSR-style minimum report elements;
- MedDRA preferred-term structure;
- explicit suspected-product-to-event relationship;
- contrast-specific prompts derived from FAERS signal clusters;
- explicit administration and onset timing informed by FAERS time-to-onset findings;
- required management, escalation and outcome fields.

### 5.2 Source fidelity and review safety

Mechanisms:

- the LLM may transform supplied information but may not add unsupported products, events, dates or outcomes;
- source-to-output drug and event matching;
- date/time consistency checking;
- missing and conflicting fields displayed explicitly;
- no automated causal attribution;
- no automated determination of seriousness, reportability or clinical management;
- mandatory nurse and pharmacovigilance/pharmacy/radiology review before submission.

Source fidelity and review safety are design goals only. No local LLM accuracy result will be reported.

### 5.3 Workflow usability and efficiency

Requirements for future implementation:

- concise capture of source information;
- conversion only into a reviewable structured draft;
- targeted prompts for missing required fields;
- human approval before reuse in the local reporting system.

The current study does not select or evaluate a user interface, input modality or automation model.

## 6. Study questions

### Primary empirical questions

1. Which preferred-term and system-organ-class signals are disproportionately reported for the selected non-ionic iodinated contrast media in FAERS?
2. What are the time-to-onset patterns among reports with usable exposure and event dates?
3. To what extent do the 39 local registered events document the fields and relationships required for pharmacovigilance reuse?

### Translational design question

4. How can FAERS-derived contrast-specific priorities and locally observed documentation gaps be translated into requirements for a standardized, human-reviewed mobile/LLM-assisted nursing reporting workflow?

The fourth question produces an evidence-to-requirement mapping and a proposed workflow. It does not produce a validated software intervention.

## 7. Study design

### Overall design

A three-component study:

1. retrospective FAERS disproportionality and time-to-onset analysis;
2. retrospective single-centre documentation-completeness audit;
3. transparent evidence-to-reporting-requirement mapping.

The study should not be labelled a mixed-methods study unless a genuine qualitative component is added.

## 8. Component 1: FAERS analysis

### 8.1 Data source

- US Food and Drug Administration Adverse Event Reporting System.
- Selected non-ionic iodinated contrast media.
- Exact study period: **[VERIFY]**
- Exposure dictionary and drug-cleaning rules: documented in the existing SQL audit.

### 8.2 Processing

- FDA-compatible case deduplication;
- drug-name normalization;
- MedDRA preferred-term and system-organ-class mapping;
- pooled and agent-specific analyses;
- exclusion of unusable date rows from time-to-onset analysis only.

### 8.3 Signal analysis

- Reporting odds ratio;
- proportional reporting ratio;
- information component;
- empirical Bayes geometric mean;
- strict signal definition requiring all four prespecified criteria;
- full signal set retained;
- top 30 strict signals with at least 10 reports displayed by EBGM05 ranking.

### 8.4 Validated FAERS results currently available

- 14,781 pooled analysis-base reports;
- 42,811 pooled preferred-term records;
- 951 pooled preferred-term rows meeting the minimum case threshold;
- 230 strict four-algorithm pooled preferred-term signals;
- 27 pooled system-organ-class rows;
- 2 strict four-algorithm system-organ-class signals;
- 9,069 evaluable pooled time-to-onset rows;
- 8,010 same-day rows (88.32%);
- 8,450 rows within one day (93.17%);
- pooled Weibull beta = 0.686271;
- pooled Weibull scale = 0.958471 days.

### 8.5 Interpretation boundary

FAERS findings are signals of disproportionate reporting. They do not establish incidence, causality, comparative drug safety, preventability or clinical-management effectiveness.

## 9. Component 2: local documentation-gap audit

### 9.1 Source

- Five-year local register of contrast-related adverse events.
- Author-reported total: 39 events.
- Exact institution and department: anonymised for double-blind review.
- Study dates: **[VERIFY]**
- Source-system description: **[VERIFY]**
- Event inclusion/exclusion criteria: **[VERIFY]**
- Ethics approval or waiver: **[VERIFY]**

The total of 39 must be verified against an authorised source before it is presented as a result.

### 9.2 Unit of analysis

One registered event record.

### 9.3 Proposed coding categories

Each field should be classified as:

- documented;
- partial or ambiguous;
- missing;
- not applicable, where justified.

Operational definitions should be finalised before aggregate results are calculated.

### 9.4 Event-level fields

- suspected contrast agent documented anywhere;
- contrast agent explicitly identified as the suspected product;
- event signs or symptoms;
- event date;
- administration date/time;
- onset time or observation window;
- severity, seriousness or escalation;
- management action;
- outcome;
- reporter role;
- relevant previous allergy or reaction history, if within the form's scope;
- sufficient patient identification within the authorised hospital system;
- sufficient reporter identification within the authorised hospital system.

### 9.5 Relationship-level fields

- suspected product explicitly linked to the event;
- administration explicitly linked to the event timeline;
- event explicitly linked to escalation or seriousness;
- event explicitly linked to management;
- event explicitly linked to outcome.

The audit must distinguish “a term appears somewhere” from “the record explicitly establishes the required relationship.”

### 9.6 Analysis

- documented, partial/ambiguous and missing `n/N (%)` for each field;
- valid-report minimum-element completeness;
- optional composite completeness summary only if its scoring rule is specified in advance;
- no incidence estimate unless a complete exposure denominator and event definition are verified;
- two reviewers should independently code the records **[VERIFY: feasibility and reviewer availability]**;
- disagreements should be resolved by consensus or a third reviewer;
- raw agreement should be reported, with Cohen's kappa and a confidence interval for suitable categorical fields; no target kappa threshold should be imposed.

### 9.7 Local evidence still needed

- **[EVIDENCE NEEDED]** verified total and five-year study period;
- **[EVIDENCE NEEDED]** aggregate completeness counts;
- **[EVIDENCE NEEDED]** coding rules for partial/ambiguous fields;
- **[EVIDENCE NEEDED]** ethics and data-governance route;
- **[EVIDENCE NEEDED]** optional denominator of all contrast administrations.

### 9.8 Under-reporting boundary

The presence of 39 registered events over five years cannot by itself demonstrate or quantify under-reporting. Such an inference would require a verified exposure denominator, a defined expected event range and/or authorised case ascertainment from additional sources. The current local component is limited to the completeness of available records.

## 10. Component 3: evidence-to-reporting-requirement mapping

### 10.1 Purpose

To connect empirical findings to reporting-system requirements without claiming that the proposed system has been implemented.

### 10.2 Mapping logic

| Evidence source | Evidence type | Derived requirement |
|---|---|---|
| ICSR requirements | Universal report validity | reporter, patient, suspected product and suspected event |
| MedDRA | Standard terminology | preferred event term plus preserved original wording |
| FAERS signal clusters | Contrast-specific content | targeted prompts for visible, respiratory, cardiopulmonary, access-site and other priority events |
| FAERS time-to-onset | Contrast-specific timing | administration time and event-onset/observation-window fields |
| Local audit | Actual documentation gaps | mandatory fields, missing-field prompts and clearer product-event relationships |
| LLM safety literature | Known generation risks | source grounding, mismatch checks, uncertainty display and human review |

### 10.3 Framework output

The proposed structured draft should contain:

```text
reporter_status:
patient_identifier_in_authorised_system:
suspected_product:
administration_context:
administration_time:
event_manifestation_original_text:
candidate_standard_event_term:
product_event_link_supported_by_input: yes/no/unclear
onset_time_or_window:
seriousness_or_escalation:
management:
outcome:
missing_required_fields:
source_conflicts:
review_status: pending_human_review
```

The LLM must preserve `unclear` and must not convert temporal proximity into causal attribution. FAERS-informed prompts must coexist with unrestricted “other event” entry and preservation of original wording to reduce anchoring on known signals.

### 10.4 Stakeholder confirmation

Before software development, intended users and governance stakeholders should review field relevance, clarity, feasibility, missing requirements and final approval responsibilities. This should be described as stakeholder confirmation or pre-implementation requirements review unless a formal consensus method is actually performed. The study should not be labelled “Phase 0” without a verified methodological framework.

### 10.5 Supplementary implementation specification

The supplement prioritises the data dictionary and relationship model (`03_manuscript/supplementary/reporting-requirements-specification.md`), machine-readable schema (`reporting-draft.schema.json`), and deterministic guardrails and review rules (`guardrail-rules.csv`). These are draft, unvalidated requirements artifacts. A model-specific prompt is not part of the stable specification.

## 11. Proposed manuscript structure

### Abstract

Use the Nursing Open structured format:

- Aim(s)
- Design
- Data Sources
- Methods
- Results
- Conclusion
- Implications for the Profession and/or Patient Care
- Impact
- Reporting Method
- Patient or Public Contribution

The abstract must present verified FAERS and local audit results. The LLM workflow should appear only as a proposed implication.

### 1. Introduction

#### Paragraph 1: nursing relevance

Introduce suspected contrast-related adverse events as a documentation and reporting problem in the radiology nursing workflow.

#### Paragraph 2: contribution and limitation of FAERS

Explain that FAERS identifies rare or disproportionate reporting patterns and timing but does not automatically translate them into nurse-facing reporting requirements.

#### Paragraph 3: documentation problem

Use nursing ADR-reporting and clinical-text literature to distinguish event mention from complete, explicitly linked and reusable pharmacovigilance documentation.

#### Paragraph 4: unresolved gap and study aim

State that few studies connect contrast-specific FAERS evidence, local nursing documentation gaps and practical requirements for a low-burden reporting workflow.

### 2. Methods

- 2.1 Study design
- 2.2 FAERS data source and exposure definition
- 2.3 Report identification and deduplication
- 2.4 MedDRA coding
- 2.5 Disproportionality analysis
- 2.6 Time-to-onset analysis
- 2.7 Local registry source and eligibility
- 2.8 Local field- and relationship-completeness coding
- 2.9 Evidence-to-reporting-requirement mapping
- 2.10 Ethics and data governance
- 2.11 Statistical analysis, software and reporting guidance

### 3. Results

- 3.1 FAERS report selection and characteristics
- 3.2 System-organ-class and preferred-term signals
- 3.3 Time-to-onset patterns
- 3.4 Local field completeness **[EVIDENCE NEEDED]**
- 3.5 Local relationship completeness **[EVIDENCE NEEDED]**
- 3.6 Derived contrast-specific reporting requirements

No LLM performance, usability or intervention-effect result should appear.

### 4. Discussion

#### 4.1 Principal findings

Integrate the FAERS priorities, early timing pattern and local documentation gaps in one paragraph.

#### 4.2 FAERS-informed capture priorities

Discuss event clusters as reporting prompts, not as evidence for specific nursing interventions.

#### 4.3 Local documentation gaps

Explain the difference between recording an event term and producing a complete pharmacovigilance-ready report.

#### 4.4 Requirements for standardization, source fidelity and workflow usability

Present the technology-neutral requirements:

- standardized fields and terminology support standardization and completeness;
- source grounding, guardrails and human review support source fidelity and review safety;
- concise first capture and a reviewable draft state define future usability and efficiency targets without asserting improvement.

These are design mechanisms, not demonstrated improvements.

#### 4.5 Future validation

A future pilot should assess:

- required-field completeness;
- proportion satisfying minimum valid-report elements;
- product-event relation completeness;
- source fidelity;
- hallucinated or omitted fields;
- expert-reviewed accuracy;
- completion time;
- number of edits;
- usability;
- perceived workload.

#### 4.6 Strengths and limitations

Include:

- spontaneous-reporting bias and absence of exposure denominator;
- inability to establish causality;
- small, single-centre local registry;
- possible documentation bias;
- dependence on retrospective record quality;
- framework not implemented;
- no LLM performance or nurse-usability testing;
- mobile voice/image evidence remains limited;
- external clinical-text studies used different populations and tasks.

### 5. Conclusion

The conclusion should state that:

1. FAERS identified contrast-specific reporting priorities and an early reporting window;
2. the local audit evaluates whether the existing workflow captures the required fields and relationships;
3. these findings specify requirements for a standardized, source-grounded and human-reviewed reporting workflow;
4. actual improvement requires prospective validation.

Avoid “improved,” “increased,” “demonstrated effectiveness” or similar completed-effect wording.

## 12. Proposed tables and figures

### Main tables

- **Table 1:** FAERS report characteristics.
- **Table 2:** Priority SOC/PT signals and key TTO summary.
- **Table 3:** Local field- and relationship-completeness audit, `n/N (%)` **[EVIDENCE NEEDED]**.
- **Table 4:** Evidence-to-reporting-requirement matrix.

### Main figures

- **Figure 1:** FAERS and local-data study flow.
- **Figure 2:** Time-to-onset distribution.
- **Figure 3:** Reporting requirements -> structured draft state -> deterministic checks -> human approval.

### Supplementary material

- complete strict PT signal set;
- agent-specific signal outputs;
- complete SOC results;
- detailed TTO and Weibull outputs;
- local coding dictionary;
- reporting-field operational definitions;
- draft reporting requirements specification;
- machine-readable reporting-draft JSON Schema;
- deterministic guardrail and human-review rules.

## 13. Role of the four reviewed articles

1. **Kabiri et al., 2024; doi:10.1002/hsr2.70277**
   Supports nurse-focused ADR documentation audit criteria, reporting barriers and an implementation-study sequence.

2. **Hakim et al., 2025; doi:10.1038/s41598-025-09138-0**
   Supports ICSR structure, source-grounded text transformation, terminology mismatch checks, uncertainty communication and mandatory human review.

3. **Silverman et al., 2024; doi:10.1002/cpt.3226**
   Supports expert annotation, MedDRA mapping, relation-extraction evaluation and the limitations of long-context clinical reasoning.

4. **Kopacheva et al., 2025; doi:10.3233/SHTI250495**
   Provides preliminary evidence that ADE documentation may fail to explicitly link the event to a suspected drug.

None directly validates mobile voice/image capture plus generative LLM report drafting.

## 14. Claims that the current study may make

- FAERS showed specific signals of disproportionate reporting.
- The evaluable FAERS reports showed an early time-to-onset pattern.
- The verified local audit showed specific reporting-field or relationship gaps **[EVIDENCE NEEDED]**.
- FAERS, ICSR requirements and local gaps can inform reporting-system requirements.
- A mobile/LLM layer may be proposed as a human-reviewed drafting mechanism.

## 15. Claims that the current study must not make

- incidence or absolute risk;
- comparative safety ranking;
- drug-event causality;
- prevention of ADEs by nursing interventions;
- improvement in nursing quality;
- proven improvement in reporting completeness, accuracy or timeliness;
- proven convenience or reduced workload;
- validated LLM performance;
- safe automated report submission;
- automatic determination of causality, seriousness, reportability or treatment.

## 16. Main structural risks

### Risk 1: perceived component stacking

The paper may look like FAERS, a small local audit and an LLM concept placed together.

Mitigation:

- keep one reporting-information-chain question;
- give every evidence source one non-overlapping role;
- integrate them in one evidence-to-requirement table;
- keep the LLM out of empirical Results;
- avoid separate disease-event discussion chapters.

### Risk 2: AI novelty without AI validation

Mitigation:

- do not foreground LLM in the recommended title;
- describe an “LLM-assisted draft layer,” not an AI system;
- state that no model was implemented or evaluated;
- make the empirical novelty the translation of FAERS and local gaps into reporting requirements.

### Risk 3: insufficient weight of 39 local events

Mitigation:

- use the records for field- and relationship-completeness auditing, not epidemiology;
- report exact counts and transparent coding rules;
- avoid inferential claims;
- consider independent duplicate review.

### Risk 4: no empirical basis for source-fidelity or usability improvement

Mitigation:

- label them design objectives;
- describe guardrails and human review as source-fidelity mechanisms, not measured accuracy;
- describe low-burden capture and draft generation as usability mechanisms, not measured convenience;
- reserve improvement claims for a future prospective pilot.

## 17. Questions for external AI reviewers

Please evaluate the outline rather than rewrite it immediately.

1. Does the manuscript read as one sequential argument or as a stack of FAERS, local audit and LLM components?
2. Is the distinction between universal ICSR requirements and contrast-specific FAERS knowledge methodologically clear?
3. Is a 39-record local documentation audit sufficient as problem evidence if no incidence claim is made?
4. Should the evidence-to-reporting-requirement mapping appear in Results or only in Discussion?
5. Is “quantitative empirical research with an evidence-informed reporting workflow” an appropriate article positioning?
6. Does the proposed framework have enough nursing relevance for Nursing Open?
7. Should LLM be omitted from the title, retained in the alternative title, or removed from the present paper?
8. Are standardization/completeness, source fidelity/review safety and workflow usability/efficiency adequately separated as design objectives rather than demonstrated outcomes?
9. Are any major methodological steps missing from the local documentation audit?
10. Is the selected distinction between FAERS adverse events, local suspected contrast-related adverse events and source-specific ADR terminology sufficiently clear?
11. Which section or component should be removed if the paper remains too broad?
12. What is the strongest likely reviewer objection, and what additional evidence would most efficiently address it?

## 18. Current go/no-go conditions

The manuscript can proceed to structural revision after:

- author verification of the local study period and 39-event total;
- completion of the local field- and relationship-completeness table;
- confirmation of ethics/data-governance language;
- final verification of ICSR minimum-field guidance;
- final decision on whether a second local reviewer is available.

Until these are complete, local results must remain marked **[EVIDENCE NEEDED]**, and the LLM workflow must remain explicitly unvalidated.
