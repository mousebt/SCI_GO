# Evidence map for two locally supplied articles

Date reviewed: 2026-07-28

## Bottom line

The two articles are complementary:

- Kabiri et al. (2024) supplies the nursing and implementation rationale: ADR documentation and reporting can be audited using explicit criteria, and common barriers include workload, lack of an accessible reporting system, limited readiness for change, and limited awareness of ADR documentation.
- Hakim et al. (2025) supplies the LLM safety architecture: pharmacovigilance generation should be source-grounded, constrained by structured fields and terminology checks, visibly flag uncertainty, and remain subject to expert human review.

Together they support this bounded article logic:

> FAERS defines high-priority contrast-event terms and timing fields; the local 39-event registry identifies which required reporting fields are missing under the existing workflow; a mobile interface may lower the burden of first capture; an LLM may transform captured content into a structured draft, but deterministic checks and human approval are required before submission.

Neither article directly validates voice/photo capture, a mobile nursing interface, or an LLM-generated contrast-media ADE report. Those elements must remain a proposed framework unless prospectively tested.

## Kabiri et al. (2024)

Citation:

Kabiri N, Hajebrahimi S, Rahmani P, Molaei Tavani F, Saghaleini SH, Razi Soofiyani S, Talebpour A. Implementing Best Practices for Nurses in Detecting and Reporting Adverse Drug Reactions in a Tertiary Hospital in Tabriz, Iran: A Mixed-Method Study. *Health Science Reports*. 2024;7(12):e70277. doi:10.1002/hsr2.70277.

### Study structure

- One internal-medicine ward in a tertiary hospital.
- Sequential explanatory mixed-methods implementation study informed by the JBI Evidence-Based Healthcare model.
- Baseline and follow-up audits involving the same 23 nurses.
- Two focus groups involving one health executive, seven nurses and two patients.
- Sequence: baseline audit -> barrier analysis and implementation strategies -> follow-up audit.

### Audit criteria useful to our local review

1. Full medical history, including drug allergies and previous ADRs, documented at admission.
2. ADR record included drug name, signs, symptoms, severity, time to onset and event date.
3. Drug-allergy status checked before another drug was prescribed, dispensed or administered.
4. Multifaceted strategies used to promote ADR reporting.
5. Staff trained in ADR reporting requirements.
6. Reporting tools/forms easily accessible.
7. ADRs reported accurately and in a timely manner.

For our retrospective 39-event dataset, criteria 2, 6 and 7 are the closest fit. Criteria 1 and 3 concern broader medication-safety practice, while criteria 4 and 5 are organisational indicators. We should not present this nurse questionnaire as a validated event-level completeness instrument.

### Findings useful to our argument

- Compliance with detailed ADR documentation was 39% at baseline and 70% at follow-up.
- Four barriers were time/workload, lack of a proper reporting system, limited readiness for change, and limited awareness of ADR documentation.
- The improvement package used guidelines, meetings, instructions, education and workflow changes.

This supports treating nursing ADR reporting as a workflow and documentation-design problem, not only a knowledge problem. It also supports auditing field completeness and reporting-route accessibility.

### Appropriate manuscript uses

- Introduction: nurses are positioned to detect reactions, while reporting can be hindered by workload, unclear procedures and inaccessible systems.
- Local methods: justify a structured completeness audit of the 39 registered events.
- Discussion: a rapid first-capture route addresses a documented class of workflow barriers, while our study does not test reporting improvement.
- Future study: baseline audit -> barrier analysis -> pilot implementation -> follow-up audit.

### Boundaries

- Single ward and small sample; no universal prevalence claims.
- The intervention was educational and organisational, not mobile or LLM-based.
- The study did not measure ADE incidence, causal attribution, patient outcomes or LLM performance.
- Its improvement percentages cannot be transferred to our hospital.

## Hakim et al. (2025)

Citation:

Hakim JB, Painter JL, Ramcharran D, Kara V, Powell G, Sobczak P, Sato C, Bate A, Beam A. The need for guardrails with large language models in pharmacovigilance and other medical safety critical settings. *Scientific Reports*. 2025;15:27886. doi:10.1038/s41598-025-09138-0.

### Study structure

- Task: transform Japanese individual case safety reports (ICSRs), containing structured fields and narrative, into English narratives.
- Private GSK safety database with more than four million cases over more than two decades.
- Model-development corpus: 131,037 pharmacovigilance and translation examples.
- Human evaluation: 210 stratified Japanese cases assessed by pharmacovigilance experts.
- Guardrails: document-level input screening, drug/AE mismatch checks, and token-level uncertainty highlighting.

### Reporting structure useful to our framework

The paper states that a valid ICSR requires:

1. an identifiable reporter;
2. an identifiable patient;
3. at least one suspected adverse reaction;
4. at least one suspected product.

It also describes seriousness, dates, reporter details, demographics, reaction details and implicated product. This supports separating minimum validity fields, clinically useful structured fields and optional narrative context.

“Identifiable” means identifiable within an authorised institutional workflow; it is not permission to transmit direct identifiers to a public LLM.

### Findings useful to our argument

The study demonstrates why an LLM output must remain a draft:

- In the 210-case assessment, 73 cases (35%) were marked clinically accurate.
- Error categories included wrong drug name/information (60%), wrong dates/times (64%), incorrect or missing AE/wrong outcome (71%), and time-to-onset issues (23%).
- A mismatch guardrail flagged all spontaneously hallucinated drug names in a randomly selected 20-case subset, but did not catch every other terminology error.
- Document-level screening had an AUROC of 0.80 for distinguishing validation from extraneous documents.
- Uncertainty measures were used to route review, not to eliminate every error.

### Appropriate manuscript uses

- Define the LLM as a source-to-structured-draft transformer, not a clinical decision-maker.
- Reject or quarantine inputs outside the ADE-capture format.
- Prevent introduction of a contrast agent or event term absent from the source.
- Preserve source dates/times and flag missing or conflicting timing.
- Flag uncertain or unmatched terms.
- Prohibit automated causality, seriousness, reportability or treatment decisions.
- Require nurse and pharmacovigilance/pharmacy/radiology review before submission.
- In a future pilot, measure source fidelity, hallucinated fields, omitted fields, correction burden, review time, draft completeness and post-review accuracy.

### Boundaries

- This was Japanese-to-English ICSR narrative generation, not voice transcription, image interpretation or mobile intake.
- The models used a large proprietary corpus; performance cannot be assumed for a general LLM or our 39 cases.
- The study did not show improved nurse reporting, workflow efficiency or patient outcomes.
- The successful drug-name check was evaluated in a selected 20-case subset and does not cover all error types.

## Combined material for the present paper

### Evidence chain

1. Kabiri supports auditing documentation completeness, system accessibility and timeliness, and identifies workflow barriers.
2. The verified local 39-event registry can quantify missing reporting fields, but cannot establish incidence without a denominator.
3. FAERS signal clusters and ICSR-style fields define what a reusable ADE report should contain.
4. Brief text or voice may be proposed as a first-capture route; image capture remains optional and policy-dependent.
5. The LLM converts only supplied content into a structured draft and asks for missing fields.
6. Source/output terminology matching, date/time checks, missing-field flags and human review provide safety controls.
7. A future study can compare completeness, timeliness, source fidelity, correction burden and usability before and after implementation.

### Fields for the 39-event completeness audit

- suspected contrast agent;
- signs/symptoms;
- event date;
- administration time;
- onset time or observation window;
- severity/seriousness or escalation;
- management action;
- outcome;
- reporter role;
- allergy/previous reaction history, if present on the original form;
- sufficient patient identification inside the authorised hospital system;
- sufficient reporter identification inside the authorised hospital system.

For each field, report `documented n/N (%)`, `missing n/N (%)`, and the rule for partial or ambiguous entries. These values must come from the actual records and must not be simulated from FAERS.

### Candidate discussion wording

> Evidence from nursing ADR implementation research indicates that reporting gaps may reflect workload, system accessibility, unclear procedures and incomplete documentation. We therefore treat the local registry as evidence of reporting-field completeness rather than as an incidence dataset. The proposed LLM layer is restricted to transforming nurse-supplied content into a structured draft. Because pharmacovigilance LLM outputs may contain incorrect products, dates, event terms or outcomes, the workflow requires source-to-output consistency checks, explicit missing-field flags and human approval before submission.

This is discussion material, not a result of the current study.
