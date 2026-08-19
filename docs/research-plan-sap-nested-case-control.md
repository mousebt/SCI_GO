# 脑卒中相关性肺炎（SAP）常规多模态数据 1:3 匹配嵌套病例对照研究方案
## (基于四篇顶刊方法学融合：Zhang et al., 2026 + Kimura et al., 2025 + Yu et al., 2024 + Wan et al., 2025)

**项目代号**：`SAP-Routine-NCC-Study`  
**版本**：v2.0 (2026-08-19 升级版)  
**设计类型**：单中心回顾性队列 1:3 嵌套病例对照研究（1:3 Matched Nested Case-Control Study）  
**数据基底**：200~300 例脑卒中住院患者历史常规病历、化验单与护理记录（**已确认 20 例 SAP 确诊阳性病例**，发生率约 7%~10%）  
**方法学对标**：
1. *Acta Microbiol Immunol Hung (2026, Zhang et al.)*: 增量价值分析（$\Delta\text{AUC}$、NRI、IDI、Brier 评分）与 Bootstrap 降缩复合评分构建；
2. *BMC Neurology (2025, Kimura et al., PMID: 41382279)*: 22 例 SAP 样本范例、72h 早期感染时序、DAG 变量筛选与 $A_2DS_2$ 假阳性灰区破局依据；
3. *Front. Endocrinol. (2024, Yu et al., PMID: 39588332)*: 常规检验（WBC/CRP/生化）、吞咽与意识量表（KWDT/GCS）与时序生存分析（Kaplan-Meier）；
4. *J. Inflamm. Res. (2025, Wan et al., PMID: 40823354)*: NPAR（中性粒细胞/白蛋白比值）零成本强效衍生标志物。

---

## 一、 研究背景与立题依据

1. **临床痛点**：脑卒中相关性肺炎（SAP）是急性卒中住院期间最常见的致命并发症，显著增加病死率并延长住院日。
2. **现有工具瓶颈（Kimura et al. 2025 揭示）**：临床常用的 $A_2DS_2$ 评分虽被广泛使用且 NPV 高达 99.5%，但在高危截断时**阳性预测值（PPV）仅为 6.3%（虚警率高达 93.7%）**，导致大量中高危灰区患者面临过度干预。
3. **创新切入点**：无需开展高成本的新化验，直接挖掘患者入院 24h 内已有的**常规血常规与生化衍生指标（NPAR、NLR、SII、白蛋白、eGFR）及常规护理文书（首次进食方式/鼻饲置管、GCS、洼田饮水试验 KWDT、门-筛查时延 DTS）**，通过 1:3 嵌套匹配与增量价值分析，证实其对 $A_2DS_2$ 具有显著的风险重分类（Continuous NRI）与预测增量价值。

---

## 二、 研究对象与 1:3 匹配流程（Flowchart）

```
                     【总队列：200~300 例急性脑卒中患者】
                                      │
                     ┌────────────────┴────────────────┐
                     ▼                                 ▼
            【病例组：全部 20 例 SAP】        【对照池：~180-280 例未发生 SAP】
                     │                                 │
                     └────────────────┬────────────────┘
                                      ▼
       【以 1:3 比例进行严格风险集匹配（Risk-Set Matched Sampling）】
          • 匹配变量 1：年龄（±3 岁）
          • 匹配变量 2：性别（100% 精确同性）
          • 匹配变量 3：初始瘫痪严重度 NIHSS 评分（±2 分）
          • 匹配变量 4：卒中亚型（脑梗死 vs 脑出血 100% 相同）
                                      │
                     ┌────────────────┴────────────────┐
                     ▼                                 ▼
               20 例 SAP 患者                    60 例精准匹配的 Control
                     │                                 │
                     └────────────────┬────────────────┘
                                      ▼
                 【最终核心分析数据集：总计 80 例深度比对】
```

### 1. 纳入标准（Inclusion Criteria）
- 年龄 $\ge 18$ 岁；
- 经头颅 CT/MRI 确诊为急性脑卒中（脑梗死或脑出血），发病至入院时间 $\le 7$ 天；
- 具有完整的入院首日血常规、生化及护理文书记录；
- 随访至卒中发病第 7~14 天或出院。

### 2. 排除标准（Exclusion Criteria）
- 入院前已存在活动性肺部感染或体温 $>38.0^\circ\text{C}$；
- 入院即刻行气管插管/有创机械通气；
- 既往严重终末期肾病（透析）或恶性肿瘤晚期。

---

## 三、 从常规病历中提取的变量清单（Zero-Cost Data Dictionary）

| 模块分类 | 变量名称 | 英文缩写 | 提取来源 | 数据类型 |
|---|---|---|---|---|
| **临床基准** | $A_2DS_2$ 评分 (0~10分) | $A_2DS_2$ | 临床评分表 | 连续/离散 |
| **神经与吞咽** | 格拉斯哥昏迷评分<br>洼田饮水试验评级 (1~5级)<br>基线 NIHSS 评分 | GCS<br>KWDT<br>NIHSS | 入院神经查体<br>护士床旁评估单<br>神经专科病历 | 离散 (3-15)<br>等级 (1-5)<br>连续 (0-42) |
| **常规血常规** | 中性粒细胞绝对值<br>淋巴细胞绝对值<br>中性粒/淋巴比值<br>全身免疫炎症指数 | $N$<br>$L$<br>NLR<br>SII | 入院第 1 次血常规<br>($N/L$)<br>($PLT \times N / L$) | 连续 ($10^9/\text{L}$)<br>连续<br>连续<br>连续 |
| **常规生化** | C反应蛋白<br>血清白蛋白<br>估算肾小球滤过率<br>空腹/随机血糖 | CRP<br>ALB<br>eGFR<br>GLU | 入院第 1 次生化单<br>生化单<br>根据肌酐计算<br>急诊生化 | 连续 (mg/L)<br>连续 (g/L)<br>连续 (mL/min)<br>连续 (mmol/L) |
| **护理敏感指标** | 首次吞咽筛查延迟时间<br>入院首日最高体温<br>喂养方式 | Delay<br>$T_{\max}$<br>Feeding | 护士体温单/记录单<br>体温单<br>医嘱/护理记录 | 连续 (小时)<br>连续 ($^\circ\text{C}$)<br>分类 (普食/增稠/胃管/禁食) |

---

## 四、 核心统计分析路线图（Statistical Pipeline）

### 步骤 1：匹配前后基线特征对比（Table 1）
- 对比 6 例 Case 与 24 例 Control 在人口学、神经功能、常规化验及护理指标上的差异；
- 正态连续变量用均数 $\pm$ 标准差（$t$ 检验），非正态用中位数及四分位数（IQR，配对 Wilcoxon 符号秩检验），分类变量用频数及百分比（McNemar 配对卡方 / Fisher 精确检验）；
- 报告标准化差异（$|\text{Std Diff}| < 0.10$ 表示完美均衡）。

### 步骤 2：条件 Logistic 回归与 Forest Plot（Table 2 & Figure 1）
- 采用 **条件 Logistic 回归（Conditional Logistic Regression）** 分析 NLR、白蛋白、CRP、KWDT 及吞咽延迟时间与 SAP 的独立关联；
- 报告单因素（Unadjusted OR）与校正后比值比（Adjusted aOR, 95% CI, P 值）；
- 绘制 OR 森林图（Forest Plot）。

### 步骤 3：复合指标构建（CIN-score，对标 Zhang et al. 2026）
- 选取与 SAP 独立相关的 2~3 个常规指标（例如：NLR、ALB、吞咽延迟时间），通过 Bootstrap 惩罚逻辑回归系数构建加权的**“临床-炎症-护理复合评分（CIN-score）”**：
  $$\text{CIN-score} = \beta_0 + \beta_1 \cdot \text{Z(NLR)} + \beta_2 \cdot \text{Z(ALB)} + \beta_3 \cdot \text{Z(KWDT/Delay)}$$

### 步骤 4：增量价值评估（Table 3 & Figure 2，核心发文亮点）
构建两大竞争模型：
- **模型 A（Model-C）**：单用 $A_2DS_2$ 评分；
- **模型 B（Model-CM）**：$A_2DS_2$ 评分 + **CIN-score**。

评估指标：
1. **$\Delta\text{AUC}$**：DeLong 检验对比受试者工作特征曲线（ROC），证明 AUC 显著提升；
2. **净重新分类改善指数（Continuous NRI）**：量化纠正假阴性/假阳性的患者净比例；
3. **综合判别改善指数（IDI）** 与 **Brier Score**（评估总体预测误差降低）；
4. **校准度曲线（Calibration Plot）**：评价预测概率与实际发生率的一致性；
5. **临床决策曲线分析（DCA）**：评估在低阈值概率下的临床净获益。

### 步骤 5：感染时间-事件生存分析（Figure 3，对标 Yu et al. 2024）
- 绘制 Kaplan-Meier 曲线，Log-Rank 检验评估高 CIN-score 组 vs 低 CIN-score 组在入院 7~14 天内的**中位无感染生存时间（Infection-free survival time）**。

---

## 五、 全文图表规划（Tables & Figures Plan）

* **Table 1**：匹配后病例组（$n=6$）与对照组（$n=24$）基线临床、实验室与护理特征比较表；
* **Table 2**：条件 Logistic 回归分析表（单因素与多因素 aOR 及其 95% CI）；
* **Table 3**：模型预测性能与增量价值对比表（AUC、$\Delta\text{AUC}$、NRI、IDI、Brier 评分、校准截距与斜率）；
* **Figure 1**：研究人群筛选与 1:4 风险集匹配流程图（Flowchart）；
* **Figure 2**：差异生物标志物（NLR、SII、ALB、KWDT）在 Case 组与 Control 组中的箱线图（Boxplots）；
* **Figure 3**：
  * **(A)** Model-C vs. Model-CM 的 ROC 曲线对比图；
  * **(B)** Bootstrap 校准度曲线（Calibration curves）；
  * **(C)** 临床决策曲线（DCA plots）；
* **Figure 4**：基于高/低风险组的 Kaplan-Meier 无感染时间-事件生存曲线。

---

## 六、 执行时间表（4 周成稿计划）

| 周期 | 任务内容 | 交付产物 |
|---|---|---|
| **第 1 周** | 提取并清洗 Excel 表格中的常规化验、护理记录与 $A_2DS_2$ 评分 | 整理出规整的 30 行分析宽表 |
| **第 2 周** | 运行 R/Python 统计脚本，完成 1:4 匹配、条件回归、NRI/IDI 与高清绘图 | 输出 Table 1-3 及 Figure 1-4 高清图 |
| **第 3 周** | 撰写 Introduction、Methods 与 Results 章节（基于真实统计结果） | 完成英文稿主体 |
| **第 4 周** | 撰写 Discussion 机制讨论（结合 SIID 与吞咽病理）、语言润色与投稿自查 | 产出完整投稿 Submission Package |
