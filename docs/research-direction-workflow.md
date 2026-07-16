# Research direction workflow

This workflow turns a vague research idea into a documented decision: proceed, revise, park or reject.

## Startup command

Use one of:

- `方向探讨：<idea>`
- `启动研究方向探讨：<idea>`
- `研究方向：<idea>`

The assistant should create or update a workspace under:

```text
research_directions/active/<direction_id>/
```

Use `scripts/new-research-direction.ps1` for a new direction.

## Directory meaning

```text
research_directions/
  inbox/       # raw direction notes not yet formalized
  active/      # directions currently being explored
  archived/    # parked, rejected or completed directions
  templates/   # reusable direction templates
```

Each active direction has:

```text
<direction_id>/
  direction.yaml
  00_brief/
  01_landscape/
  02_feasibility/
  03_idea-bank/
  04_decisions/
  05_outputs/
  tmp/
```

## Workflow

1. **Capture**
   - Save the user's original idea in `00_brief/user-notes.md`.
   - Define the direction in one sentence.

2. **Frame**
   - Identify the clinical/research problem.
   - Identify the likely reader and article type.
   - State what must not be claimed.

3. **Landscape**
   - Search or plan a search for similar work.
   - Identify crowded areas, safer niches and likely target journals.
   - Do not cite papers that have not been checked.

4. **Feasibility**
   - Fill the feasibility scorecard.
   - Mark missing data, ethics blockers and analysis dependencies.

5. **Candidate questions**
   - Split the direction into paperable units.
   - Rank each candidate as quick-win, medium-risk, long-term or not recommended.

6. **Decision**
   - Recommend one of:
     - proceed to paper;
     - revise direction;
     - park for later;
     - reject.
   - Record the decision in `04_decisions/direction-decision.md`.

7. **Promotion**
   - If approved, create a paper workspace under `papers/<slug>/`.
   - Transfer only the relevant direction materials.
   - Keep the original direction workspace as the pre-paper audit trail.

## Required final outputs

Every completed direction exploration should have:

- `05_outputs/research-direction-report.md`
- `05_outputs/next-action-plan.md`
- `02_feasibility/feasibility-scorecard.md`
- `04_decisions/direction-decision.md`

