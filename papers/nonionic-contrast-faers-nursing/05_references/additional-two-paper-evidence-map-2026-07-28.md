# Evidence map for the two additional locally supplied articles

Date reviewed: 2026-07-28

## Overall assessment

These two articles concern ADE detection from unstructured clinical notes. They do not directly test our selected mobile capture plus LLM-generated reporting-draft workflow. Their value is more specific:

- Silverman et al. (2024) provides a rigorous model-development and evaluation example, including expert annotation, drug-event relation tasks, MedDRA coding, privacy controls and limitations of long-context reasoning.
- Kopacheva et al. (2025) provides preliminary evidence that even records selected using ADE diagnosis codes often fail to explicitly connect the ADE to a suspected drug.

The articles therefore strengthen the case for capturing structured relationships at the point of reporting, but they do not justify processing our local patient notes or claiming that a generative LLM is already accurate.

## Silverman et al. (2024)

Full citation:

Silverman AL, Sushil M, Bhasuran B, et al. Algorithmic Identification of Treatment-Emergent Adverse Events From Clinical Notes Using Large Language Models: A Pilot Study in Inflammatory Bowel Disease. *Clinical Pharmacology & Therapeutics*. 2024;115(6):1391-1399. doi:10.1002/cpt.3226. PMID:38459719.

### Study design

- Single-centre retrospective NLP study using de-identified UCSF clinical notes.
- Population: 928 adults with inflammatory bowel disease, represented by 928 outpatient notes from 2018-2020.
- Reference standard: five annotators from gastroenterology, pharmacy, pharmacovigilance and the patient community.
- Events: 703 hospitalization-associated serious adverse events; 411 notes documented at least one SAE.
- Coding: manually mapped to MedDRA version 23.0 preferred terms.
- Data split: 80% training, 10% validation and 10% testing.
- Main model: hierarchical UCSF-BERT, compared with several conventional machine-learning and deep-learning approaches.

### Prediction logic relevant to our framework

The authors separated ADE identification into linked tasks:

1. medication mentioned before hospitalization;
2. adverse event as the reason for hospitalization;
3. the medication-hospitalization-AE relationship triple.

This is important for our reporting template. A useful ADE record is not a bag of independent fields; it must preserve explicit relationships:

> suspected product -> administration/exposure -> event -> onset/timing -> escalation or seriousness -> management -> outcome

### Main results

- Across tasks, reported accuracy was approximately 88%-92%, while macro F1 was only 61%-68%.
- For hospitalization-AE relations, accuracy was 96% but macro F1 was 62%.
- Restricting candidate SAEs to a two-sentence window around hospitalization increased macro F1 from 62% to 68%.
- The medication-hospitalization-AE triple task achieved macro F1 of 61%.
- The model struggled with long-distance dependencies, long clinical chronologies, implied rather than explicit relationships, and combinations of nonspecific and specific event terms.

### Material we can use

- **Evaluation design:** model validation must include relation extraction, not only entity recognition.
- **Metric choice:** accuracy can look high despite modest class-balanced performance; any future pilot should report precision, recall and F1, not accuracy alone.
- **Terminology:** MedDRA preferred-term mapping is a separate expert-reviewed step and should not be treated as automatic ground truth.
- **Human reference standard:** multidisciplinary annotation and explicit adjudication rules are more defensible than using an LLM to grade itself.
- **Privacy:** the study used de-identified notes under IRB approval and a data-use framework, reinforcing our decision not to process local patient narratives in the present paper.
- **Design implication:** asking the nurse to capture drug, event and timing as separate structured fields may reduce the long-distance reasoning burden seen in retrospective note mining.

### Boundaries

- UCSF-BERT is an encoder model for classification/extraction, not a generative ChatGPT-like report writer.
- The study involved IBD therapies and hospitalization-associated SAEs, not contrast media or acute radiology nursing events.
- It used a model pretrained on 75 million clinical notes and cannot justify training or validating a model on our 39 local events.
- It did not establish causality between medication and event.
- Single-centre performance was not externally validated.

## Kopacheva et al. (2025)

Full citation:

Kopacheva E, Lincke A, Björneld O, Hammar T. Detecting Adverse Drug Events in Clinical Notes Using Large Language Models. *Studies in Health Technology and Informatics*. 2025;327:892-893. doi:10.3233/SHTI250495. PMID:40380603.

### Evidence level

This is a two-page short communication describing ongoing research. Its results are preliminary and should be used as corroborating evidence, not as the principal validation study for our LLM framework.

### Study design and preliminary findings

- Retrospective Swedish geriatric-clinic EHR data from 2018-2022.
- 905 discharge notes with ADE diagnosis codes, representing 199 patients.
- Notes were pre-annotated using a Swedish clinical BERT model, then refined and relation-annotated by two pharmacist domain experts.
- The text described ADEs in 56% of the annotated material.
- Only 135 discharge notes (14.9%) explicitly mentioned an ADE together with a specific drug.
- Reported task-level performance in the ongoing work included macro F1 of 0.84 for named-entity recognition and F1 of 0.70 for relation extraction.

### Material we can use

- The presence of an ADE diagnosis code does not guarantee an adequate narrative description.
- Mentioning an ADE is not the same as documenting the suspected drug-ADE relationship.
- Entity recognition can perform better than relation extraction, supporting a structured form that explicitly links the suspected contrast agent to the observed event.
- For the local 39-event review, “suspected contrast agent explicitly linked to the event” should be counted separately from “contrast agent name appears somewhere on the form.”

### Boundaries

- Results are preliminary and presented in a short communication.
- The sample consists of Swedish geriatric discharge notes, not nursing ADE reports or contrast-media events.
- The work is based on BERT extraction, not generative report drafting, voice input or image interpretation.
- The reported 14.9% must not be transferred to our local dataset.

## How the four papers now work together

| Article | Main contribution to our paper | What it cannot support |
|---|---|---|
| Kabiri et al. 2024 | Nursing reporting barriers, audit criteria and implementation-study structure | Mobile/LLM effectiveness |
| Hakim et al. 2025 | ICSR fields, source-grounded generation, guardrails and mandatory human review | Accuracy of our workflow or multimodal capture |
| Silverman et al. 2024 | Expert annotation, MedDRA coding, relation tasks, evaluation metrics and privacy boundary | Generative report writing or contrast-specific performance |
| Kopacheva et al. 2025 | Documentation gap between ADE mention and explicit drug-ADE linkage | General prevalence or a validated intervention effect |

## Revised use of the local 39-event dataset

The two new articles make the local analysis more precise. The local table should distinguish:

- contrast agent documented anywhere;
- contrast agent explicitly identified as the suspected product;
- event manifestation documented;
- suspected product and event explicitly linked;
- administration date/time documented;
- onset or observation window documented;
- seriousness or escalation documented;
- management documented;
- outcome documented;
- reporter role documented;
- fields sufficient for a valid institutional safety report.

For each field, report documented, partial/ambiguous and missing counts. The coding rules should be written before reviewing the aggregate results.

## Implication for the proposed LLM output

The LLM should produce relational structured output rather than merely extracting isolated terms:

```text
suspected_product:
event_manifestation:
product_event_link_supported_by_input: yes/no/unclear
administration_time:
onset_time_or_window:
seriousness_or_escalation:
management:
outcome:
missing_required_fields:
source_conflicts:
review_status: pending_human_review
```

The model must not convert `unclear` into a positive drug-event link or infer causality from temporal sequence alone.

## Recommended manuscript role

- Use Silverman in the Discussion and future validation section.
- Use Kopacheva in the Introduction or Discussion to support the distinction between ADE mention and explicit product-event documentation.
- Do not add either paper to the current Results, because our Results must report only FAERS outputs and verified local data.
- Do not reopen the EHR-text extraction direction for the current paper; these studies actually demonstrate its data, annotation, privacy and validation burden.
