---
id: "APR-20260716-115654-791c4e"
created_at: "2026-07-16T11:56:54+08:00"
updated_at: "2026-07-16T11:56:54+08:00"
status: pending
scope: "global"
paper_id: ""
risk: "low"
git_commit: ""
supersedes: ""
superseded_by: ""
---

# Convert research direction workflow into skill

## 当时的相关对话

User asked to make the newly added research direction feature into a skill.

## 当时已知的事实

The repository already contains research_directions/, config/research-direction-policy.md, docs/research-direction-workflow.md, and scripts/new-research-direction.ps1. Existing paper project files remain dirty and must not be touched.

## 假设与不确定性

The skill should live in the repository under skills/research-direction so it is versioned with SCI_GO. The skill should drive thinking and workflow; research_directions/ stores actual direction artifacts.

## 备选方案与权衡

Option A: keep only project workflow; Option B: add repository skill under skills/research-direction; Option C: install globally into user Codex home. Preferred: Option B now, with optional global install later.

## 提请批准的计划

Create skills/research-direction/SKILL.md with concise trigger and workflow instructions, add agents/openai.yaml, add reference files for scorecard and promotion checklist, and update AGENTS to require reading this skill for direction exploration.

## 预计影响

Adds a reusable skill wrapper without changing existing paper content. Future direction exploration requests can follow skill instructions and use the existing workspace/templates.

## 原样批准问题

Approve converting the research direction workflow into a repository skill?

## 用户回复与处理结果

<!-- APPROVAL_RESPONSE -->
Pending user response.

