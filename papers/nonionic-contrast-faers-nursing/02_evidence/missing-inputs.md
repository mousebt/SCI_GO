# 作者补充与核对清单

以下项目不会由 AI 猜测。未解决前，主稿中的相应位置保留 `[VERIFY]`。

## A. 影响结果可信度的必需材料

- 原始分析脚本、查询语句或可复现的分析流程。
- FAERS 各季度下载清单、下载日期，以及 2025 Q4 文件是否已正式发布并完整纳入。
- 去重前后记录数、deleted case 排除数、纳入流程各节点数量。
- 四种药物的完整检索词典：通用名、商品名、拼写变体、盐型及排除规则。
- MedDRA 版本、PT 映射方法、旧术语处理方法、SOC 分配规则。
- ROR、PRR、BCPNN、MGPS 的完整公式、阈值、比较背景和全部输出；尤其补齐当前表格缺失的 EBGM/EBGM05。
- 四个造影剂分别分析的结果；如未做，需确认是否保持合并分析并说明理由。
- 27 个 SOC 的完整结果及其中 9 个阳性 SOC 的数值。
- 24 个阳性 PT 的完整结果表，并核对所有英文 MedDRA 标准名称。
- TTO 清洗流程、使用的日期字段、部分日期处理、同日事件定义、分组数值、中位数/IQR、Weibull 精确参数及置信区间。
- 图1—图3的原始数据和可编辑源文件，纠正原稿中重复图号。

## B. 投稿前必需确认

- 作者姓名、单位、通讯作者、邮箱、ORCID。
- 机构伦理审查/豁免结论及编号（如适用）。
- 资金来源、利益冲突、作者贡献、致谢。
- 数据和代码是否公开；若公开，拟使用的仓库和链接。
- 单位所说“4区”究竟指 JCR Q4、中科院4区，还是 Scopus 分区；此项留到下一轮期刊讨论。

## C. 参考文献和护理建议

- 现有中英文双列参考文献不直接沿用，需逐条核对 DOI、作者、刊名、年份、卷期页码。
- 原稿第8条中英文信息明显不对应，必须删除错误译文并重新核验原条目。
- 50%硫酸镁、中药外敷、马铃薯片、固定饮水量、统一停药、固定留观30分钟等表述，只有在当前国际指南或高质量证据明确支持且适用情境清楚时才可恢复。
- 造影剂加温、留置针规格、穿刺部位和注射速率必须按适用场景和现行指南写，不能写成普遍有效的干预。

## 建议交付顺序

1. 先提供分析脚本/结果表和图源文件。
2. 再补作者与伦理信息。
3. 确认“4区”的机构口径后锁定期刊。
4. 最后完成文献核验、期刊格式适配和投稿文件。
# Local clinical nursing record inputs

The current Nursing Open-facing manuscript now includes a planned local clinical nursing record contextualization layer. Fill `02_evidence/local-clinical-record-template.csv` before finalizing Results, Discussion, Abstract, Ethics, and Data Availability.

Minimum local data needed:

1. Local study period.
2. Total number of non-ionic ICM administrations.
3. Local registered contrast-related adverse events.
4. Event categories: extravasation/access-site, cutaneous/respiratory, cardiopulmonary, kidney-related, other.
5. Event timing or observation window if recorded.
6. Nursing interventions and escalation actions.
7. Outcomes and documentation completeness.
8. Local ethics/IRB/exemption or quality-improvement determination.

If the total administration denominator is unavailable, do not calculate local proportions; use local records only as descriptive contextualization.
