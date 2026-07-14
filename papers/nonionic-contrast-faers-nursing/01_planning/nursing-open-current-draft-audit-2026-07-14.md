# Nursing Open current-draft audit and edit queue

Paper ID: `nonionic-contrast-faers-nursing`  
Source file audited: `03_manuscript/main.md`  
Target route: Nursing Open first; Current Medical Science fallback  
Approval: `APR-20260714-153244-865f5c`  
Date: 2026-07-14  
Status: active edit queue

## 1. Overall diagnosis

The current `main.md` is a useful journal-agnostic English structural draft. It already has three important protections:

1. It clearly states the FAERS inference boundary.
2. It uses `[VERIFY]` tags for uncertain numerical and methodological details.
3. It keeps nursing implications bounded rather than claiming intervention efficacy.

However, it is not yet ready for Nursing Open because it still reads as a pharmacovigilance manuscript with a nursing discussion layer. Nursing Open requires the paper to be visibly relevant to nurses and nursing throughout the manuscript. The next revision should therefore convert the draft into a nursing-facing quantitative empirical article while preserving the pharmacovigilance evidence boundary.

## 2. One-sentence argument to enforce

In spontaneous FAERS reports involving four non-ionic iodinated contrast media, this study uses disproportionality and time-to-onset analyses to identify reportable adverse-event patterns and early clustering that may help radiology nursing teams prioritize surveillance and escalation, while not estimating incidence, proving causality, comparing absolute drug safety, or testing nursing interventions.

Every revised section must serve this sentence.

## 3. Terminology lock for the edit

| Canonical term | First-use definition | Action in next edit |
|---|---|---|
| iodinated contrast media (ICM) | iodinated contrast media (ICM) | Use ICM after first definition; specify non-ionic ICM when relevant |
| adverse event (AE) | adverse event (AE) | Use AE for FAERS report language; avoid ADR unless causality is intended |
| FAERS | US Food and Drug Administration Adverse Event Reporting System (FAERS) | Define once; use FAERS thereafter |
| preferred term (PT) | Medical Dictionary for Regulatory Activities preferred term (PT) | Replace any “indication” label for event terms |
| disproportionality signal | signal of disproportionate reporting | Avoid “risk signal” when it implies incidence or causality |
| time to onset (TTO) | time to onset (TTO) | Define calculation fields and exclusions |
| contrast-associated acute kidney injury (CA-AKI) | contrast-associated acute kidney injury (CA-AKI) | Use CA-AKI unless causality is established; preserve MedDRA PT names in Results |

## 4. Nursing Open compliance audit

| Requirement / expectation | Current draft status | Action |
|---|---|---|
| Article type: Empirical Research Quantitative | Not stated in manuscript; title says journal-agnostic draft | Add article-type planning note and prepare title page/main document split later |
| Double-blind review | Current main file contains no author identities, good start | Keep main document anonymized; create separate title page later |
| Structured abstract ≤300 words | Current abstract is structured but long and not Nursing Open-specific | Rewrite last using Nursing Open headings after Results/Discussion stabilize |
| No abbreviations/statistical parameters in abstract | Current abstract uses FAERS, PT-type wording, and numerical results | Final abstract must avoid abbreviations where possible and avoid detailed statistical parameters |
| Nursing relevance | Present in title, aim, intro, discussion; still secondary to pharmacovigilance | Move nursing surveillance problem earlier and make it the manuscript's stated reason for doing the analysis |
| Main text structure | Current structure is standard IMRaD | Convert to Nursing Open-friendly structure: Introduction, Background, The Study, Aim(s), Methods, Results, Discussion, Strengths/Limitations, Conclusion |
| EQUATOR checklist | Mentions READUS-PV only | Decide final checklist: likely STROBE plus pharmacovigilance reporting guidance / READUS-PV support |
| Required declarations | Draft placeholders exist | Keep placeholders; later finalize data, ethics, funding, COI, No Patient/Public Contribution |
| References | Not rebuilt | Rebuild verified English references after data/method details are stable |
| Figures/tables limit | Unknown because current file has text only | Build table/figure plan ≤10 items |

## 5. Section-by-section edit queue

### 5.1 Title

Current title:

> Safety Signals of Non-Ionic Iodinated Contrast Media in FAERS and Implications for Radiology Nursing Practice

Diagnosis:

- Searchable and bounded, but “Safety Signals” may sound like drug-safety ranking.
- Nursing appears only at the end.
- Nursing Open may require article type suffix.

Edit action:

- Later generate 3–5 title options after Results are verified.
- Preferred direction: “Adverse-event reporting patterns ... for radiology nursing surveillance”.

Priority: later, after Results and Discussion.

### 5.2 Abstract

Diagnosis:

- Already structured, but not in Nursing Open's exact structure.
- Too much methodological detail for the final 300-word limit.
- Contains unverified numerical results that should remain `[VERIFY]` until checked.

Edit action:

- Do not finalize now.
- After Results and Discussion, rewrite under Nursing Open headings: Aim(s), Design, Data Sources, Methods/Review Methods, Results, Conclusion, Implications, Impact, Reporting Method, Patient/Public Contribution.

Priority: last.

### 5.3 Introduction

Diagnosis:

- Current Introduction is coherent and appropriately bounded.
- Nursing relevance appears in paragraph 2, which is acceptable but can be stronger for Nursing Open.
- The gap is phrased as “nursing-focused synthesis” rather than a sharper nursing-workflow problem.

Edit action:

- Rebuild as four paragraph jobs:
  1. ICM safety events matter in imaging workflows.
  2. Radiology nurses need surveillance priorities and time windows.
  3. FAERS can reveal reporting patterns but cannot prove incidence/causality.
  4. Present study converts FAERS signal/TTO patterns into bounded nursing surveillance implications.

Priority: after Results and Methods.

### 5.4 Methods

Diagnosis:

- Strongest section in terms of transparency because it already marks missing details.
- Too many `[VERIFY]` items remain for submission.
- Nursing Open reviewers will likely focus on reproducibility, data cleaning, and reporting checklist fit.

Edit action:

- Convert to Nursing Open headings:
  - Design
  - Data source
  - Case identification
  - AE coding
  - Disproportionality analysis
  - TTO analysis
  - Ethical considerations
- Keep all unknowns as `[VERIFY]` or `[AUTHOR INPUT REQUIRED]`.
- Add explicit “No patient or public involvement in study design/conduct” only in declarations/abstract, not Methods unless required.

Priority: second after Results audit.

### 5.5 Results

Diagnosis:

- Results are already separated into report characteristics, SOC/PT signals, and TTO.
- They still mix some interpretation and explanatory boundary text.
- Several key data points require verification.
- SOC-level output is missing.
- EBGM is claimed in Methods but not represented in the Results table evidence.

Edit action:

- Rewrite Results in four evidence-first subsections:
  1. Report selection and characteristics.
  2. SOC-level signals.
  3. PT-level signals and nursing-relevant clusters.
  4. TTO distribution and early clustering.
- Move interpretive boundary sentences that are not direct results into Discussion or a short final sentence.
- Mark missing SOC/EBGM/table evidence clearly.

Priority: first substantive manuscript edit.

### 5.6 Discussion

Diagnosis:

- Current Discussion is already cautious and useful.
- Nursing implications are strong, but some specific workflow suggestions still need guideline support.
- This section will decide Nursing Open fit.

Edit action:

- Rebuild around seven paragraph jobs:
  1. Principal findings for nursing surveillance.
  2. Extravasation/access-site monitoring.
  3. Hypersensitivity/cardiopulmonary readiness.
  4. Kidney-related findings and CA-AKI boundary.
  5. Nursing workflow implications as surveillance framework, not intervention package.
  6. Strengths and limitations.
  7. Future research / QI validation.
- Any specific practice action without current guideline support gets `[EVIDENCE NEEDED]`.

Priority: after Introduction/Methods or alongside them once Results are stable.

### 5.7 Conclusion

Diagnosis:

- Already appropriately bounded.
- Needs slightly more Nursing Open emphasis on “profession and/or patient care” while preserving limitations.

Edit action:

- Keep as contribution → evidence → nursing implication → boundary.
- No new data.

Priority: after Discussion.

### 5.8 Declarations

Diagnosis:

- Placeholders are present.
- Nursing Open requires these to be explicit.

Edit action:

- Add or finalize:
  - Ethics approval / exemption wording.
  - Consent statement.
  - Data availability.
  - Code availability.
  - Funding.
  - Conflict of interest.
  - Author contributions.
  - No Patient or Public Contribution.

Priority: before submission package, after author input.

## 6. Immediate Results-specific evidence checklist

Before or during the Results rewrite, resolve or preserve `[VERIFY]` for:

1. 14,780 eligible reports.
2. 42,808 AE records.
3. 951 PTs.
4. 27 SOCs.
5. Nine positive SOCs and their exact estimates.
6. 24 positive PT signals.
7. Exact ROR/CI formatting for extravasation and other leading PTs.
8. Whether PRR, IC, and EBGM were calculated for every displayed signal.
9. Exact count corresponding to 81.56% within 24 hours.
10. TTO median, IQR, interval categories, Weibull shape/scale, and confidence intervals.

## 7. Recommended next action

Proceed to a controlled Results rewrite in `03_manuscript/main.md`:

- Keep all existing numerical values unless contradicted by verified source output.
- Do not invent missing SOC/EBGM/TTO details.
- Mark missing source evidence with `[VERIFY]` or `[EVIDENCE NEEDED]`.
- Preserve the Nursing Open framing but keep Results observational.

This produces a better working manuscript while keeping the data-verification burden visible.
