# Research direction exploration policy

Version: 1.0.0

Scope: global pre-paper workflow for exploring, comparing and selecting research directions before creating a paper workspace.

## Purpose

Research direction exploration is a pre-paper incubation process. Its job is to decide whether an idea is worth turning into a manuscript project, not to draft a manuscript prematurely.

Use this workflow when the user says phrases such as:

- `方向探讨：...`
- `启动研究方向探讨：...`
- `这个方向能不能做`
- `帮我找一个可发表方向`
- `围绕某个数据/科室/问题设计研究方向`

## Boundaries

During direction exploration, do not:

- write full manuscript sections unless the user explicitly promotes the direction to a paper project;
- invent data availability, sample size, statistical results, mechanisms, novelty, citations or journal acceptance likelihood;
- treat an interesting idea as publishable without feasibility evidence;
- mix multiple directions into an existing paper workspace;
- silently convert a direction into a `papers/<slug>/` project without user approval.

Allowed outputs:

- research direction brief;
- literature/competitor scan plan;
- feasibility scorecard;
- candidate research questions;
- data and ethics requirement list;
- journal fit and publication difficulty estimate;
- recommendation to proceed, revise, park or reject.

## Standard decision ladder

Assess every direction in this order:

1. **Clinical/research relevance** — why this matters and to whom.
2. **Paperable question** — whether it can become a focused manuscript question.
3. **Data availability** — what data are needed and whether they can plausibly be obtained.
4. **Method feasibility** — whether analysis can be completed with available tools and expertise.
5. **Ethics and governance risk** — whether approval, waiver or data access could block the work.
6. **Novelty and saturation** — whether similar work already exists and how crowded the space is.
7. **Journal fit and difficulty** — likely article type, audience and submission risk.
8. **Fastest safe next action** — the smallest step that reduces uncertainty.

## Scoring convention

Use a 1-5 score for each feasibility dimension:

- `1`: weak / currently blocking
- `2`: possible but high risk
- `3`: workable with known gaps
- `4`: strong
- `5`: very strong / low risk

Always explain the score in plain language. A direction with a high novelty score but missing data should not be recommended as "ready".

## Promotion rule

A research direction can be promoted into `papers/<slug>/` only after the user confirms:

1. the exact research question;
2. the available or planned data source;
3. the intended article type;
4. the target reader/journal direction;
5. the immediate next deliverable.

After promotion, the paper must follow `config/start-modes.md`, `config/writing-logic.md` and `config/project-policy.md`.

## Knowledge feedback

Lessons from a direction exploration can enter shared knowledge only if:

- the direction later produces a validated outcome, or
- the user manually approves a reusable lesson;
- the lesson is recorded with scope, evidence and limitations;
- `approved=yes` and `status=validated` before syncing into `knowledge/validated/`.

## Approval logging

Any global change to this policy or the research direction architecture requires an approval log with `scope=global`.

Any decision to promote a direction into a paper project should be recorded either:

- in the direction's `04_decisions/direction-decision.md`; and
- if it affects paper scope, target journal or manuscript strategy, in the normal approval log system.

