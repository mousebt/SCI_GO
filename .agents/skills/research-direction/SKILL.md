---
name: research-direction
description: Explore and evaluate research directions before manuscript creation. Use when the user asks for 方向探讨、启动研究方向探讨、研究方向、这个方向能不能做、帮我找一个可发表方向、课题孵化、选题评估, or wants to turn a vague clinical/data/research idea into candidate publishable questions, feasibility scoring, journal fit, data/ethics requirements, and a proceed/revise/park/reject decision without drafting a paper yet.
---

# Research Direction

## Core rule

Use this skill as a pre-paper incubator. Do not create a paper workspace or draft full manuscript prose until the user explicitly approves promotion into a paper project.

Follow the repository policy in `config/research-direction-policy.md` when working inside SCI_GO. If that file exists, read it before acting.

## Workflow

1. **Capture**
   - Preserve the user's original idea in plain language.
   - If this is a new direction in SCI_GO, create a workspace with `scripts/new-research-direction.ps1`.
   - If a direction workspace already exists, continue inside it.

2. **Frame**
   - Write one sentence:
     `In [setting/problem], this direction explores [question] using [possible data/method] to produce [paperable contribution], within [boundary].`
   - Name what must not be claimed.

3. **Split into paperable units**
   - Generate 3-5 candidate questions.
   - Classify each as quick-win, medium-risk, long-term, or not recommended.
   - For every candidate question, report the number of finished papers that directly support the direction. Count only verified, already completed research outputs such as published articles, accepted articles, theses/dissertations, or preprints with a full manuscript; do not count protocols, editorials, comments, conference abstracts without full papers, or unchecked search hits.
   - If a candidate has `0` finished-paper support, label it as exploratory. Show only the highest-feasibility exploratory candidates, with a hard cap of `min(2, floor(20% of the displayed recommended candidates))`. If the displayed recommendation set is too small for one unsupported candidate to stay within the 20% cap, omit unsupported candidates from the ranked recommendations and list them only under missing evidence or future exploration.
   - Avoid turning one vague direction into one oversized paper.

4. **Assess feasibility**
   - Score 1-5:
     data availability, data quality, sample size plausibility, method feasibility, ethics/governance, literature saturation, clinical/nursing relevance, journal fit, speed to manuscript, overall publication feasibility.
   - Explain every score. Mark unknowns as unknown; never invent availability or results.
   - Literature saturation must include the finished-paper support count and distinguish "no finished-paper support" from "no checked support yet".
   - For detailed scoring definitions, read `references/scorecard.md`.

5. **Landscape**
   - Identify what must be checked in the literature and likely competitors.
   - Browse/search when the answer depends on current publications, journal status, guidelines, or exact citations.
   - Do not cite or summarize unchecked papers as evidence.
   - When recommending directions, verify and show how many finished papers support each candidate before treating it as paperable.

6. **Recommend**
   - Choose one: proceed to paper, revise direction, park for later, reject.
   - Give the fastest uncertainty-reducing next step.
   - Do not let unsupported exploratory candidates exceed 20% of the displayed recommendations, and never display more than two unsupported exploratory candidates.

7. **Promote only with approval**
   - Before creating `papers/<slug>/`, confirm:
     exact question, data source, article type, target reader/journal direction, and immediate deliverable.
   - For the full promotion checklist, read `references/promotion-checklist.md`.

## SCI_GO file outputs

For a new direction, use:

```powershell
powershell -ExecutionPolicy Bypass -File scripts/new-research-direction.ps1 -Title "<direction title>" -OriginalIdea "<user's idea>"
```

Then update these files:

- `00_brief/user-notes.md`
- `00_brief/initial-question.md`
- `02_feasibility/feasibility-scorecard.md`
- `03_idea-bank/candidate-questions.md`
- `05_outputs/research-direction-report.md`
- `05_outputs/next-action-plan.md`
- `04_decisions/direction-decision.md` when a decision is made

Use `tmp/` only for disposable intermediate files.

## Output style

Return:

1. one-sentence direction;
2. ranked candidate questions, each with `finished-paper support: N`;
3. feasibility scorecard summary;
4. key missing evidence;
5. recommendation;
6. next action.

Keep language direct and decision-oriented. A useful "not worth doing yet" is better than a polished but unrealistic idea.
