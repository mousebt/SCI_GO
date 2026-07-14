-- =================================================================
-- 药物不良反应 (ADR) 信号挖掘脚本 V9 优化版
-- 基于单药挖掘222.sql，保留原始表计算逻辑，优化写法：
-- [Fix1] res_drug_base 去掉重复的 INDEX(primaryid)
-- [Fix2] @N_total 改用子查询 COUNT(*) 替代 COUNT(DISTINCT)，减少排序开销
-- [Fix3] 将 a 和 a+c 的计算拆分为两步：
--        a    从已过滤的 res_drug_reac 直接算（不碰全量 reac）
--        a+c  从预计算缓存表 cache_pt_stats_v2 按 ym 范围 SUM 聚合（毫秒级）
--             需要提前执行一次 setup_pt_stats_cache.sql 建好缓存表
-- [Fix4] is_prr_signal 通过多层子查询直接计算，去掉 INSERT 占位 + UPDATE
-- [Opt1] 三类配置分开存为独立小表，JOIN 不需要额外 WHERE type= 条件
-- =================================================================

SET SESSION group_concat_max_len = 100000;
SET SESSION tmp_table_size = 536870912;
SET SESSION max_heap_table_size = 536870912;
SET SESSION lock_wait_timeout = 10;            -- DROP TABLE 遇到 MDL 锁时 10s 超时报错，而非无限卡死
SET SESSION innodb_lock_wait_timeout = 10;     -- InnoDB 行锁同样快速超时

-- 1. 配置参数
SET @TARGET_DRUG_LIST = '["Ioversol","Iohexol","Iopamidol","Iodixanol"]';
SET @START_DT = '20040101';
SET @END_DT   = '20251231';

SET @ENABLE_FILTER = 1;
SET @EXCLUDE_PT_LIST  = '[]'; 
SET @EXCLUDE_SOC_LIST = '[]';

-- =================================================================
-- 步骤 0：初始化环境与日志
-- =================================================================
DROP TABLE IF EXISTS tmp_mining_log;
CREATE TABLE tmp_mining_log (
    step_id INT AUTO_INCREMENT PRIMARY KEY,
    step_info VARCHAR(255),
    row_count INT,
    log_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- [Opt1] 三类配置分开存，JOIN 时不需要额外 WHERE type='...' 条件
DROP TABLE IF EXISTS tmp_target_drugs;
CREATE TABLE tmp_target_drugs (drugname VARCHAR(255) PRIMARY KEY) DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
INSERT INTO tmp_target_drugs
SELECT DISTINCT drugname FROM JSON_TABLE(@TARGET_DRUG_LIST, "$[*]" COLUMNS(drugname VARCHAR(255) PATH "$")) as jt;

DROP TABLE IF EXISTS tmp_exclude_pt;
CREATE TABLE tmp_exclude_pt (pt_name VARCHAR(255) PRIMARY KEY) DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
INSERT INTO tmp_exclude_pt
SELECT DISTINCT pt_name FROM JSON_TABLE(@EXCLUDE_PT_LIST, "$[*]" COLUMNS(pt_name VARCHAR(255) PATH "$")) as jt;

DROP TABLE IF EXISTS tmp_exclude_soc;
CREATE TABLE tmp_exclude_soc (soc_name VARCHAR(255) PRIMARY KEY) DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
INSERT INTO tmp_exclude_soc
SELECT DISTINCT soc_name FROM JSON_TABLE(@EXCLUDE_SOC_LIST, "$[*]" COLUMNS(soc_name VARCHAR(255) PATH "$")) as jt;

INSERT INTO tmp_mining_log (step_info, row_count) 
SELECT '步骤 0：配置参数初始化完成', 
    (SELECT COUNT(*) FROM tmp_target_drugs) 
    + (SELECT COUNT(*) FROM tmp_exclude_pt)
    + (SELECT COUNT(*) FROM tmp_exclude_soc);

-- =================================================================
-- 步骤 1：构建目标药物队列 (res_drug_base) N_drug从这来，就是a+b
-- =================================================================
DROP TABLE IF EXISTS res_drug_base;
CREATE TABLE res_drug_base (
    primaryid BIGINT,drugname varchar(255),fda_dt varchar(20)  -- [Fix1] 去掉多余的 INDEX(primaryid)，PRIMARY KEY 已覆盖
) DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO res_drug_base
SELECT DISTINCT dr.primaryid,td.drugname,d.fda_dt
FROM drug dr
inner join drug_clean dc on dc.drugname=dr.drugname
JOIN demo_clean d  ON dr.primaryid = d.primaryid
JOIN tmp_target_drugs td ON dc.drugname_clean = td.drugname  -- [Opt1] JOIN 替代 IN(subquery)
WHERE dr.role_cod = 'PS' 
  and d.occp_cod IN ("MD","PH","OT","RN","HP") 
  AND d.fda_dt BETWEEN @START_DT AND @END_DT;

INSERT INTO tmp_mining_log (step_info, row_count)
SELECT '步骤 1：筛选目标药物报告数 (Role=PS)', COUNT(*) FROM res_drug_base;

-- =================================================================
-- 步骤 2：提取并清洗不良反应 (res_drug_reac) 这就是所有的a，等待下一步group by
-- 使用新的 reac 表结构
-- =================================================================
DROP TABLE IF EXISTS res_drug_reac;
CREATE TABLE res_drug_reac (
    primaryid BIGINT,
    pt VARCHAR(255),
    INDEX(pt),
    INDEX(primaryid)
) DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO res_drug_reac
SELECT distinct r.primaryid, r.pt
FROM reac r
INNER JOIN res_drug_base b ON r.primaryid = b.primaryid
LEFT JOIN tmp_exclude_pt ex_pt   ON r.pt = ex_pt.pt_name
LEFT JOIN meddra_soc mh          ON r.pt = mh.pt_name_en
LEFT JOIN tmp_exclude_soc ex_soc ON mh.soc_name_en = ex_soc.soc_name
WHERE r.pt IS NOT NULL AND r.pt != ''
  AND (@ENABLE_FILTER = 0 OR (ex_pt.pt_name IS NULL AND ex_soc.soc_name IS NULL));

INSERT INTO tmp_mining_log (step_info, row_count)
SELECT '步骤 2：提取目标组清洗后的 PT 记录数', COUNT(*) FROM res_drug_reac;

-- =================================================================
-- 步骤 3：计算 N_total、N_drug、a、a+c
-- =================================================================

-- 3.1 N_total：时间范围内的全库唯一病例数（原始表，真实值）a+b+c+d

SELECT @N_total := COUNT(*) FROM (
    SELECT DISTINCT primaryid FROM demo_clean
    WHERE fda_dt BETWEEN @START_DT AND @END_DT
) t_total;

-- N_drug：目标药的唯一病例数，直接从 res_drug_base 数 a+b
SELECT @N_drug := COUNT(*) FROM res_drug_base;

INSERT INTO tmp_mining_log (step_info, row_count)
SELECT CONCAT('步骤 3.1：a+b+c+d=', @N_total, ', a+b=', @N_drug), 0;

-- 3.2 计算 a（目标药 + 目标 PT 的报告数）
-- [Fix3-A] 直接从 res_drug_reac 计算，完全不需要再扫描全量 reac
DROP TABLE IF EXISTS tmp_pt_a;
CREATE TABLE tmp_pt_a (
    pt VARCHAR(255) PRIMARY KEY,
    a  INT
) DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO tmp_pt_a
SELECT pt, COUNT(*) AS a
FROM (
    SELECT DISTINCT pt, primaryid FROM res_drug_reac  -- 先去重，再 COUNT(*)
) t
GROUP BY pt
HAVING COUNT(*) >= 3;

INSERT INTO tmp_mining_log (step_info, row_count)
SELECT '步骤 3.2：统计目标药 PT 频次 a（a >= 3）', COUNT(*) FROM tmp_pt_a;

-- 3.3 计算 a+c（目标 PT 在全库时间范围内的总报告数）
-- [Fix3-B] 从预计算缓存表 cache_pt_stats_v2 按 ym 范围聚合，毫秒级完成。
--          cache_pt_stats_v2 结构：(ym CHAR(6), pt VARCHAR(255), case_count INT)
--          需提前执行 setup_pt_stats_cache.sql 建好该缓存表。
DROP TABLE IF EXISTS tmp_pt_ac;
CREATE TABLE tmp_pt_ac (
    pt       VARCHAR(255) PRIMARY KEY,
    a_plus_c INT
) DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO tmp_pt_ac (pt, a_plus_c)
SELECT c.pt, SUM(c.case_count) as total_count
FROM cache_pt_stats_v2 c
WHERE c.ym BETWEEN LEFT(@START_DT, 6) AND LEFT(@END_DT, 6) AND c.pt IN (SELECT pt FROM tmp_pt_a) 
GROUP BY c.pt;


INSERT INTO tmp_mining_log (step_info, row_count)
SELECT '步骤 3.3：统计目标 PT 全库频次 a+c（缓存加载）', COUNT(*) FROM tmp_pt_ac;

-- =================================================================
-- 步骤 4：生成最终信号挖掘结果表 (修复 BIGINT 溢出与列引用问题)
-- =================================================================
DROP TABLE IF EXISTS res_drug_pt_signals;
CREATE TABLE res_drug_pt_signals AS
SELECT 
    *,
    -- 最终信号判定
    IF(a >= 3 AND ROR_025 > 1, 1, 0) AS is_ror_signal,
    IF(a >= 3 AND PRR >= 2 AND chi_squared >= 4, 1, 0) AS is_prr_signal,
    IF(EB05 >= 2, 1, 0) AS is_mgps_signal,
    -- 格式化输出 ROR (95% CI)
    IF(ROR IS NOT NULL, CONCAT(FORMAT(ROR, 2), ' (', FORMAT(ROR_025, 2), ', ', FORMAT(ROR_975, 2), ')'), NULL) AS ror_95ci_range
FROM (
    -- 第二层：执行复杂计算
    SELECT
        base.*,
        -- 1. MGPS 核心指标
        ROUND( (CAST((a+b) AS DOUBLE) * (a+c)) / @N_total, 4) AS expected_E,
        ROUND( (a + 0.5) / ((CAST((a+b) AS DOUBLE) * (a+c)) / @N_total + 0.5), 2) AS EBGM,
        ROUND( EXP(LOG((a + 0.5) / ((CAST((a+b) AS DOUBLE) * (a+c)) / @N_total + 0.5)) - 1.645 * SQRT(1.0/a + 0.1)), 2) AS EB05,
        -- 2. ROR 置信区间 (使用 DOUBLE 避免计算 1/d 时的精度丢失)
        IF(a > 0 AND b > 0 AND c > 0 AND d > 0,
            ROUND(EXP(LOG((CAST(a AS DOUBLE) * d) / (CAST(b AS DOUBLE) * c)) - 1.96 * SQRT(1.0/a + 1.0/b + 1.0/c + 1.0/d)), 2),
            NULL) AS ROR_025,
        IF(a > 0 AND b > 0 AND c > 0 AND d > 0,
            ROUND(EXP(LOG((CAST(a AS DOUBLE) * d) / (CAST(b AS DOUBLE) * c)) + 1.96 * SQRT(1.0/a + 1.0/b + 1.0/c + 1.0/d)), 2),
            NULL) AS ROR_975,
        -- 3. 修复 1690 报错：强制使用 DOUBLE 进行大数相乘
        ROUND(IF(
            (CAST((a+b) AS DOUBLE) * CAST((c+d) AS DOUBLE) * CAST((a+c) AS DOUBLE) * CAST((b+d) AS DOUBLE)) > 0,
            (CAST(@N_total AS DOUBLE) * POW(ABS(CAST(a AS DOUBLE)*d - CAST(b AS DOUBLE)*c), 2))
            / (CAST((a+b) AS DOUBLE) * CAST((c+d) AS DOUBLE) * CAST((a+c) AS DOUBLE) * CAST((b+d) AS DOUBLE)),
            0
        ), 2) AS chi_squared
    FROM (
        -- 第一层：定义基础四格表 (Base)
        SELECT 
            t.pt,
            mh.pt_name_cn AS pt_cn,
            mh.soc_name_cn AS soc,
            t.a AS cases,
            t.a,
            CAST((@N_drug - t.a) AS SIGNED) AS b,
            CAST((ac.a_plus_c - t.a) AS SIGNED) AS c,
            CAST((@N_total - ac.a_plus_c - (@N_drug - t.a)) AS SIGNED) AS d,
            -- 基础 ROR
            IF(ac.a_plus_c > t.a AND @N_drug > t.a,
                ROUND((CAST(t.a AS DOUBLE) * (@N_total - ac.a_plus_c - (@N_drug - t.a))) / (CAST(@N_drug - t.a AS DOUBLE) * (ac.a_plus_c - t.a)), 2),
                NULL) AS ROR,
            -- 基础 PRR
            IF(ac.a_plus_c > t.a,
                ROUND((CAST(t.a AS DOUBLE) / @N_drug) / (CAST(ac.a_plus_c - t.a AS DOUBLE) / (@N_total - @N_drug)), 2),
                NULL) AS PRR,
            -- IC 
            ROUND(LOG2((CAST(t.a AS DOUBLE) * @N_total) / (CAST(@N_drug AS DOUBLE) * ac.a_plus_c)), 2) AS IC,
            ROUND(LOG2((CAST(t.a AS DOUBLE) * @N_total) / (CAST(@N_drug AS DOUBLE) * ac.a_plus_c)) - 2.0 * SQRT(1.0/t.a + 1.0/(@N_drug - t.a) + 1.0/(ac.a_plus_c - t.a) + 1.0/(@N_total - ac.a_plus_c - (@N_drug - t.a))), 2) AS IC025
        FROM tmp_pt_a t
        INNER JOIN tmp_pt_ac ac ON t.pt = ac.pt
        LEFT JOIN (
            SELECT pt_name_en, MIN(pt_name_cn) AS pt_name_cn, MIN(soc_name_cn) AS soc_name_cn
            FROM meddra_soc GROUP BY pt_name_en
        ) mh ON t.pt = mh.pt_name_en
    ) base
) with_metrics
ORDER BY cases DESC;

INSERT INTO tmp_mining_log (step_info, row_count)
SELECT '步骤 4：生成最终信号结果表', COUNT(*) FROM res_drug_pt_signals;


-- =================================================================
-- 步骤 5：构建 TTO (Time-to-Onset) 专项分析表
-- 逻辑：通过 primaryid + drug_seq 严格关联 DRUG 与 THER
-- =================================================================
DROP TABLE IF EXISTS tmp_tto_base;
CREATE TABLE tmp_tto_base AS
SELECT 
    b.primaryid,
    -- 日期清洗与 DATEDIFF 计算
    DATEDIFF(
        STR_TO_DATE(d.event_dt, '%Y%m%d'), 
        STR_TO_DATE(th.start_dt, '%Y%m%d')
    ) AS tto_days
FROM res_drug_base b
JOIN demo_clean d ON b.primaryid = d.primaryid
-- 关联 res_drug_reac 获取该报告下的目标 PT
-- 注意：这里关联的是 drug 原始表以确保 drug_seq 存在
JOIN drug dr ON b.primaryid = dr.primaryid
JOIN ther th ON dr.primaryid = th.primaryid AND dr.drug_seq = th.dsg_drug_seq
WHERE d.event_dt REGEXP '^[0-9]{8}$'   -- 严格日期格式校验
  AND th.start_dt REGEXP '^[0-9]{8}$'
  AND th.start_dt IS NOT NULL
  AND d.event_dt IS NOT NULL
HAVING tto_days >= 0 AND tto_days <= 730; -- 过滤逻辑错误及超长离群值

-- =================================================================
-- 步骤 6：生成 TTO 时间段分布统计（用于趋势展示）
-- =================================================================

DROP TABLE IF EXISTS res_drug_tto_distribution;
CREATE TABLE res_drug_tto_distribution AS
SELECT 
    tto_group,
    case_count,
    -- 修复方案：使用窗口函数直接计算总数，或者在 SELECT 中不引用外部未分组列
    ROUND(case_count * 100.0 / SUM(case_count) OVER(), 2) AS percentage
FROM (
    SELECT 
        CASE 
            WHEN tto_days BETWEEN 0 AND 30   THEN '01: 0-30 days'
            WHEN tto_days BETWEEN 31 AND 60  THEN '02: 31-60 days'
            WHEN tto_days BETWEEN 61 AND 90  THEN '03: 61-90 days'
            WHEN tto_days BETWEEN 91 AND 180 THEN '04: 91-180 days'
            ELSE '05: More than 180 days'
        END AS tto_group,
        COUNT(*) AS case_count
    FROM tmp_tto_base
    GROUP BY tto_group
) sub
ORDER BY tto_group;
-- =================================================================
-- 结果展示
-- =================================================================

-- 查看各时间段占比
SELECT * FROM res_drug_tto_distribution;




SELECT step_info AS '执行步骤', row_count AS '影响行数', log_time AS '记录时间' 
FROM tmp_mining_log ORDER BY step_id;

SELECT 
    pt, pt_cn, soc, cases, 
    a, b, c, d,
    ROR, ROR_025, PRR, chi_squared, IC, IC025,
    is_ror_signal, is_prr_signal
FROM res_drug_pt_signals 
ORDER BY a DESC 
LIMIT 100;

SELECT 
    pt, pt_cn, soc, 
    a, b, c, d,
    ROR, ROR_025,ROR_975,ror_95ci_range, PRR, chi_squared,ebgm, IC, IC025,
    is_ror_signal, is_prr_signal
FROM res_drug_pt_signals where  is_ror_signal=1 and  is_prr_signal=1
ORDER BY ror DESC ;
