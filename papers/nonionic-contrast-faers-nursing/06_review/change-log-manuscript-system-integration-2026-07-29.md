# Manuscript system-integration change log

Date: 2026-07-29

## Scope

- Created `03_manuscript/main-en-system-v1.1-2026-07-29.md` while preserving the earlier v1.0 manuscript.
- Reframed the study from framework specification alone to registry audit, FAERS analysis, prototype implementation and synthetic engineering verification.
- Added reproducible Methods for the browser voice interface, local RAG knowledge base, hybrid extraction, GLM-4-Flash generation, transcript-span verification, guardrails and frozen synthetic evaluation.
- Added descriptive engineering Results for five synthetic cases and seven software tests.
- Revised the Abstract, Introduction, Discussion, Conclusion and Data availability statement to distinguish implemented functionality from untested clinical effectiveness.

## Evidence boundaries

- The engineering sample is five synthetic Mandarin text cases; it is not a clinical validation cohort.
- No inferential statistics, confidence intervals or significance claims were added.
- Real-audio recognition, nurse usability, clinical report quality and documentation burden remain unevaluated.
- The system is described as a research prototype, not an autonomous diagnostic or pharmacovigilance reporting tool.

## Verification

- Seven unit tests passed on 2026-07-29.
- Reported metrics were transcribed from the frozen deterministic and live LLM run records.
- No local registry, FAERS or clinical outcome value was newly inferred.
