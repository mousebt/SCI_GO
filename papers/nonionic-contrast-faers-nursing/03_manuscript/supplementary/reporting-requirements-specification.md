# Supplementary reporting requirements specification

**Status:** Draft analytical output; not clinically validated and not implemented in software.

**Purpose:** Define a model-independent structure for converting a nurse-observed suspected contrast-related adverse event into a reviewable safety-report draft.

## Evidence hierarchy

1. **Universal minimum elements:** verified ICSR/E2B guidance **[EVIDENCE NEEDED: final formal citation]**.
2. **Standard terminology:** MedDRA-compatible candidate terms while preserving original clinical wording.
3. **Contrast-specific prompts:** FAERS PT/SOC signals and time-to-onset patterns.
4. **Local gap controls:** verified missing or ambiguous fields from the 39-record audit **[EVIDENCE NEEDED]**.
5. **Source-fidelity controls:** pharmacovigilance LLM literature and deterministic validation rules.

FAERS-derived prompts do not determine whether an event is reportable. The specification always permits an unrestricted other-event entry.

## Core data dictionary

| Field | Type | Requirement | Source status | Intended use | Boundary |
|---|---|---|---|---|---|
| `reporter_identifiable_within_authorised_system` | yes/no/unclear | Minimum-validity check | Human confirmed | Establish whether follow-up is possible | Do not transmit direct identifiers outside the authorised system |
| `reporter_role` | coded string + original wording | Required when available | Explicit/missing | Route review responsibility | No automatic credential inference |
| `patient_identifiable_within_authorised_system` | yes/no/unclear | Minimum-validity check | Human confirmed | Permit authorised case follow-up | No public or external identifiers |
| `suspected_products[].original_name` | string | Required | Explicit/unclear/missing | Preserve source product wording | Do not invent a product |
| `suspected_products[].normalized_candidate` | string/null | Reviewable suggestion | Derived | Support generic-name standardization | Must not replace original wording automatically |
| `administration_context` | string/null | Contrast-specific | Explicit/unclear/missing | Record procedure or route context | No inference from event type alone |
| `administration_datetime` | partial date-time/null | Contrast-specific | Explicit/unclear/missing | Support temporal interpretation | Preserve precision; do not fabricate time |
| `events[].original_wording` | string | Required | Explicit/unclear/missing | Preserve observed event | Unrestricted other-event wording must remain available |
| `events[].candidate_meddra_pt` | string/null | Reviewable suggestion | Derived | Support standard coding | Human confirmation required |
| `product_event_relationships[].support` | yes/no/unclear | Required relationship | Explicit/unclear/missing | Show whether the input links product and event | Temporal proximity is not causality |
| `onset_datetime_or_window` | partial date-time or interval/null | Contrast-specific | Explicit/unclear/missing | Record onset or observation timing | Do not convert vague timing into exact time |
| `seriousness_or_escalation` | structured object | Required when available | Explicit/unclear/missing | Record observed escalation and possible seriousness criteria | Final seriousness/reportability requires human determination |
| `management_actions[]` | string array | Required when available | Explicit/unclear/missing | Preserve actions taken | No treatment recommendation generation |
| `outcomes[]` | string array | Required when available | Explicit/unclear/missing | Preserve documented outcome | Do not infer resolution |
| `missing_required_fields[]` | field-name array | System generated | Deterministic | Focus follow-up questions | Missingness is not a negative clinical finding |
| `source_conflicts[]` | structured array | System generated | Deterministic | Direct human review to inconsistencies | A flag is not an adjudication |
| `review_status` | pending/approved/rejected | Required | Human controlled | Prevent unreviewed submission | Default is `pending_human_review` |

## Relationship model

The specification treats a report as linked information rather than isolated named entities:

```text
suspected product
    -> administration context and time
    -> observed event in original wording
    -> onset time or observation window
    -> escalation/seriousness information
    -> management
    -> outcome
```

If any arrow is unsupported by the source, the relationship remains `unclear`. The system must not fill a missing relationship by relying only on chronological order or known FAERS signals.

## Review-state logic

```text
captured
  -> structured_draft
  -> deterministic_checks_completed
  -> pending_human_review
  -> approved OR returned_for_clarification OR rejected
  -> eligible_for_authorised_submission only after approval
```

No LLM or other automated component may move a draft directly to submission.

## Implementation-neutral boundary

The stable deliverable is the data dictionary, relationship model, JSON schema, deterministic rules and review-state logic. A mobile form, voice transcription service or LLM is only a possible implementation. Image input is outside the current study.
