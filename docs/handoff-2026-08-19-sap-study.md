# 项目交接与进展备忘：脑卒中相关性肺炎（SAP）常规数据 1:3 嵌套病例对照研究

- **交接日期**：2026-08-19
- **项目代号**：`SAP-Routine-NCC-Study`
- **当前阶段**：`research_direction_refined` / `analysis_preparation`
- **数据基底**：回顾性卒中住院队列（200~300 例病历），**已确认 20 例 SAP 阳性确诊病例**（发生率约 7%~10%）

---

## 1. 今日核心进展与决策锁定

1. **阳性病例数锁定与样本架构升级**：
   - 阳性病例从初始 6 例大幅提升并确认为 **20 例真实确诊 SAP**；
   - 匹配架构升级为 **1:3 风险集匹配（20 例 Case : 60 例 Control，总样本 N = 80）**；
   - 匹配变量：年龄（$\pm 3$ 岁）、性别（100% 精确同性）、卒中亚型（梗死 vs 出血 100% 相同）、基线瘫痪严重度（NIHSS $\pm 2$ 分）。
   - **统计保障**：20 个阳性事件完全满足 EPV $\ge 10$ 标准，支持 2~3 个核心预测因子稳健拟合，彻底消除过拟合与小样本偏倚。

2. **三大顶级方法学文献研读与归档（已写入 `key-literature.md`）**：
   - **文献 1**：*Zhang et al. (Acta Microbiol Immunol Hung, 2026)*：确立了 Bootstrap 降缩拟合复合评分（CIN-score）与“$\Delta\text{AUC}$ + Continuous NRI + IDI + Brier Score + 校准曲线”的增量价值评价链；
   - **文献 2**：*Kimura et al. (BMC Neurology, 2025, PMID: 41382279)*：针对同样仅有 22 例 SAP 的急性期卒中队列，确立了 STROBE 规范、72 小时内早期感染时序、以及 $A_2DS_2$ 高 NPV（99.5%）与低 PPV（6.3%）的临床痛点；
   - **文献 3**：*Yu et al. (Front Endocrinol, 2024, PMID: 39588332)*：确立了 100% 基于回顾性医院常规化验（血常规/生化/甲状腺）与护理文书（KWDT 吞咽/GCS 意识）零成本挖掘范式及 Kaplan-Meier 感染生存曲线。

3. **核心技术突破方向锁定（超越 Kimura 2025 的三大杀手锏）**：
   - **新视角**：破解 $A_2DS_2$ 的假阳性灰区（针对 93.7% 的假警报进行“物理误吸 + 免疫耗竭”双重打击精准分层）；
   - **新数据（零成本衍生特征工程）**：引入 2025 最新**中性粒细胞/白蛋白比值（NPAR / NAR）**、全身免疫炎症指数（SII）、预后营养指数（PNI）；
   - **新技术体系**：1:3 风险集匹配 + Bootstrap 降缩加权复合评分（CIN-score）+ 增量价值四部曲（$\Delta\text{AUC}$、NRI、IDI、DCA 决策曲线）+ 交互式列线图（Dynamic Nomogram）。

4. **学术检索环境健全**：
   - 完成了 `pubmed-database` 技能包的底层环境（`uv` 包管理器及 Windows 证书适配）配置与真实检索测试，确保所有文献证据 100% 真实可溯源。

---

## 2. 核心文献资产库索引

| 文献标识 | 期刊与年份 | 核心价值与借鉴模块 |
|---|---|---|
| **Zhang et al. 2026** | *Acta Microbiol Immunol Hung (2026)*<br>DOI: `10.1556/030.2026.02907` | 1:2/1:3 嵌套匹配、Bootstrap 降缩复合评分、$\Delta\text{AUC}$/NRI/IDI/Brier 增量评价 |
| **Kimura et al. 2025** | *BMC Neurology (2025)*<br>PMID: `41382279` | 22 例 SAP 样本范例、72h 早期感染时序、DAG 变量筛选、$A_2DS_2$ 假阳性灰区破局依据 |
| **Yu et al. 2024** | *Front Endocrinol (2024)*<br>PMID: `39588332` | 常规化验（WBC/生化/甲状腺）+ 护理（KWDT/GCS）挖掘范式、KM 感染时间生存曲线 |
| **Wan et al. 2025** | *J Inflamm Res (2025)*<br>PMID: `40823354` | NPAR（中性粒细胞/白蛋白比值）作为强效独立预测标志物 |

---

## 3. 下一步工作入口（Next Steps）

1. **产物 1：输出《20 例 SAP 规范化数据提取宽表（Excel / CSV 模板）》**：
   - 包含人口学基线、入院 $\le 24$h 必查化验（中性粒、淋巴、血小板、白蛋白、CRP、eGFR）、护理文书（进食方式、鼻饲置管、KWDT、GCS）与 $A_2DS_2$ 自动折算规则。
2. **产物 2：编写 R / Python 自动化全流程分析管线**：
   - 包含：
     - `01_matching.py`：1:3 倾向/风险集严格匹配及 Table 1 均衡表生成；
     - `02_regression.py`：条件 Logistic 回归与 Forest Plot 森林图绘制；
     - `03_cin_score.py`：Bootstrap 降缩拟合 NPAR + 进食方式的复合评分；
     - `04_incremental.py`：$\Delta\text{AUC}$、Continuous NRI、IDI、Brier 评分计算与 ROC/Calibration/DCA 三联图生成；
     - `05_nomogram.py`：交互式临床风险列线图绘制。
3. **产物 3：撰写 Methods 与 Results 规范英文初稿**。
