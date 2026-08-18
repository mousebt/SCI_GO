---
id: "APR-20260728-134825-fd1e8e"
created_at: "2026-07-28T13:48:25+08:00"
updated_at: "2026-07-28T13:48:26+08:00"
status: approved
scope: "paper"
paper_id: "nonionic-contrast-faers-nursing"
risk: "high"
git_commit: ""
supersedes: ""
superseded_by: ""
---

# Second external audit implementation and specification package

## 当时的相关对话

用户附加Gemini第二轮审计文本，并要求读取并执行。审计建议缩减LLM/App描写、补充本院纳排与数据路径、双人编码/伦理、术语清扫、FAERS清洗细节及JSON/guardrail补充材料。

## 当时已知的事实

当前正文已无独立LLM标题，39例不能量化漏报，IRB/第二评审人/本院结果仍缺失且不可虚构；现有SQL与证据目录可只读核对；可创建未验证、模型无关的需求规范附件。

## 假设与不确定性

用户授权实施可验证且不越界的建议；不接受由39例推断极度漏报、不虚构Kappa或IRB、不强制将FAERS术语改为sAE。

## 备选方案与权衡

A（执行）：筛选后落实正文收缩、方法输入清单、SQL证据核对和模型无关规范附件。B：照单全收并写入漏报、IRB、Kappa，违反证据纪律。C：仅记录评审不修改，不能满足用户执行要求。

## 提请批准的计划

采用A。检查SQL去重/药名清洗；压缩Discussion的具体移动/LLM实现；补充本院纳排和数据路径待填项；创建数据字典、JSON Schema和guardrail规则；保持IRB、双人编码和本院结果为缺失证据；执行术语和数字QA。

## 预计影响

修改英文稿局部段落、规划与证据清单，新增补充规范文件并更新变更日志；不改变FAERS结果，不写入虚构本院数据或系统性能。

## 原样批准问题

是否按第二轮外部审计中可验证且符合证据边界的建议实施上述修改？

## 用户回复与处理结果

<!-- APPROVAL_RESPONSE -->
### User response (verbatim)

用户附加审计文件并要求：Read and act on that content.

### Decision and resolution

- Decision: approved
- Recorded at: 2026-07-28T13:48:26+08:00
- Resolution: 按用户授权实施经证据纪律筛选后的第二轮审计建议；拒绝无分母漏报推断及虚构伦理、Kappa和模型性能。
