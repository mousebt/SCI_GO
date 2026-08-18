---
id: "APR-20260728-112303-0de387"
created_at: "2026-07-28T11:23:03+08:00"
updated_at: "2026-07-28T13:22:32+08:00"
status: revised
scope: "paper"
paper_id: "nonionic-contrast-faers-nursing"
risk: "high"
git_commit: ""
supersedes: ""
superseded_by: ""
---

# FAERS-local-audit-LLM manuscript architecture

## 当时的相关对话

用户提出：好，我们现在来确定整个文章的结构。当前稿件已包含FAERS v10结果、本院5年39例待核验登记事件，以及手机端采集和LLM生成ADE上报草稿的框架；四篇全文文献已完成证据映射。

## 当时已知的事实

FAERS有14,781份POOLED reports、230个严格四算法PT signals和9,069条可评估TTO记录；本院39例仅有总数，字段完整性结果、研究期和伦理路径待核验；当前未实施或验证手机/LLM系统；Kabiri支持护士上报审计，Hakim支持guardrails和人工审核，Silverman/Kopacheva支持文本实体与药物-事件关系抽取但不支持多模态报告生成。

## 假设与不确定性

目标仍为Nursing Open优先；文章定位为定量实证研究；作者希望保留AI元素但不虚构模型性能；本院数据将以字段和关系完整性审计呈现而非发生率。

## 备选方案与权衡

A（推荐）：FAERS信号/TTO与本院39例字段完整性审计为实证主体，证据到字段的映射为研究输出，LLM置于讨论和框架图中且明确未验证。B：改为LLM框架开发论文，需要新增专家共识、原型或前瞻验证，目前证据不足。C：FAERS为唯一主体，删除本院和LLM，可最简洁但失去用户希望的护理上报创新。

## 提请批准的计划

采用A。重构为三段证据链：FAERS确定应报告什么和何时报告；本院39例审计显示旧表缺哪些字段及关系；据此提出手机端轻量采集、LLM结构化草稿、硬性一致性校验和人工审核的未来框架。标题不突出已验证LLM；结果不报告LLM性能；讨论从具体护理对策改为报告字段、关系、guardrails和未来验证。照片仅作为受政策限制的可选输入，不作为核心。

## 预计影响

将重排标题、摘要、引言、方法、结果和讨论目录；保留已验证FAERS数字；新增本院字段完整性表和证据-字段映射表的位置；将当前外渗/过敏/肾损伤的分散讨论合并为FAERS-informed capture priorities；更新research brief、main manuscript和change log。

## 原样批准问题

是否批准按方案A重构全文：以FAERS和本院39例字段完整性审计为实证主体，LLM仅作为人审式报告草稿框架，并将照片降为可选而非核心？

## 用户回复与处理结果

<!-- APPROVAL_RESPONSE -->
### User response (verbatim)

用户后续回复：这个逻辑链条是通畅的，我的问题是会不会有堆砌的感觉。随后提出：如果把结论放在护士上报ade的规范性、准确性、便利性提高。那faers是基座，本院是问题发现，llm是便捷性。

### Decision and resolution

- Decision: revised
- Recorded at: 2026-07-28T13:22:32+08:00
- Resolution: 原方案未直接执行全文重构。用户将主线进一步收束为护士ADE上报信息链，并要求规范性、准确性和便利性作为框架设计目标；需建立修订方案日志。
