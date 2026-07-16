# Research directions

This area is for exploring research directions before they become manuscript projects.

Use it for questions like:

- Is this idea publishable?
- What is the safest SCI angle?
- What data would be needed?
- Which candidate paper should be written first?
- Should this direction be promoted into a `papers/<slug>/` project?

Research directions are not manuscripts. Do not draft full paper text here unless a direction is promoted into a paper workspace.

## Layout

```text
research_directions/
  inbox/       # raw unstructured direction notes
  active/      # current direction explorations
  archived/    # parked/rejected/completed directions
  templates/   # reusable templates
```

## Startup

Run:

```powershell
powershell -ExecutionPolicy Bypass -File scripts/new-research-direction.ps1 -Title "your direction title"
```

Or ask:

```text
方向探讨：your direction title
```

## Promotion

Only promote a direction into `papers/<slug>/` after the user confirms the exact research question, data source, article type, target reader and immediate next deliverable.

