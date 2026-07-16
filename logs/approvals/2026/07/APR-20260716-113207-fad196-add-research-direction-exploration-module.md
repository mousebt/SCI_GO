---
id: "APR-20260716-113207-fad196"
created_at: "2026-07-16T11:32:07+08:00"
updated_at: "2026-07-16T11:32:07+08:00"
status: pending
scope: "global"
paper_id: ""
risk: "medium"
git_commit: ""
supersedes: ""
superseded_by: ""
---

# Add research direction exploration module

## 当时的相关对话

User asked to add a system feature for research direction discussion and approved the proposed architecture.

## 当时已知的事实

Existing repository separates global config/templates/knowledge from per-paper workspaces. Current papers directory has active dirty worktree changes that must not be touched. A direction-exploration feature should live outside papers until a direction is promoted into a manuscript project.

## 假设与不确定性

Research direction exploration is a global pre-paper incubation workflow. It should not draft manuscript prose by default and should not fabricate data, methods, citations, novelty, or feasibility.

## 备选方案与权衡

Option A: add only documentation; Option B: add a reusable research_directions workspace, templates, policy, and startup instructions; Option C: modify the paper workflow directly. Preferred: Option B because it is isolated and reusable.

## 提请批准的计划

Create research_directions/ with inbox, active, archived, and templates; add config/research-direction-policy.md; add templates for direction.yaml, report, scorecard, and next-action plan; document startup command and promotion rules.

## 预计影响

Adds a global pre-paper workflow and templates. Does not alter existing paper files or current manuscript content. Future directions can be assessed before becoming paper projects.

## 原样批准问题

Approve adding the research direction exploration module as a global pre-paper workflow?

## 用户回复与处理结果

<!-- APPROVAL_RESPONSE -->
Pending user response.

