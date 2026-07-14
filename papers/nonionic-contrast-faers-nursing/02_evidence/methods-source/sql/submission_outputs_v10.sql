-- =====================================================================
-- Submission output SQL v10 for non-ionic iodinated contrast media FAERS study
-- Purpose:
--   1) Preserve pooled analysis.
--   2) Add agent-specific analyses for Ioversol, Iohexol, Iopamidol, Iodixanol.
--   3) Export EBGM and EB05 as EBGM05.
--   4) Provide both strict four-algorithm and core ROR/PRR signal flags.
--   5) Export complete PT, positive PT, SOC, TTO and reproducibility log tables.
--   6) Export true SOC-level disproportionality tables for all SOCs, not only
--      PT-derived SOC summaries.
--
-- This script is derived from the author-provided:
--   单药挖掘最终优化版.sql
--
-- It does not overwrite the original script.
-- It assumes the following source/cleaned tables already exist:
--   demo_clean, drug, drug_clean, reac, ther, meddra_soc
--
-- Optional cache:
--   cache_pt_stats_v2(ym CHAR(6), pt VARCHAR(255), case_count INT)
-- If the cache is empty, this script attempts to populate it from demo_clean + reac.
--
-- Weibull parameters are intentionally not estimated here.
-- Export res_v10_tto_base and fit Weibull scale/shape/CI in R or Python.
-- =====================================================================

SET SESSION group_concat_max_len = 100000;
SET SESSION tmp_table_size = 536870912;
SET SESSION max_heap_table_size = 536870912;
SET SESSION lock_wait_timeout = 10;
SET SESSION innodb_lock_wait_timeout = 10;

-- ---------------------------------------------------------------------
-- 0. Configuration
-- ---------------------------------------------------------------------

SET @TARGET_DRUG_LIST = '["Ioversol","Iohexol","Iopamidol","Iodixanol"]';
SET @START_DT = '20040101';
SET @END_DT   = '20251231';
SET @MIN_CASES = 3;

SET @ENABLE_FILTER = 1;
SET @EXCLUDE_PT_LIST  = '[]';
SET @EXCLUDE_SOC_LIST = '[]';

DROP TABLE IF EXISTS tmp_v10_log;
CREATE TABLE tmp_v10_log (
    step_id INT AUTO_INCREMENT PRIMARY KEY,
    step_info VARCHAR(255),
    row_count BIGINT,
    log_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DROP TABLE IF EXISTS tmp_v10_target_drugs;
CREATE TABLE tmp_v10_target_drugs (
    drugname VARCHAR(255) PRIMARY KEY
) DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO tmp_v10_target_drugs
SELECT DISTINCT drugname
FROM JSON_TABLE(@TARGET_DRUG_LIST, "$[*]" COLUMNS(drugname VARCHAR(255) PATH "$")) AS jt;

DROP TABLE IF EXISTS tmp_v10_exclude_pt;
CREATE TABLE tmp_v10_exclude_pt (
    pt_name VARCHAR(255) PRIMARY KEY
) DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO tmp_v10_exclude_pt
SELECT DISTINCT pt_name
FROM JSON_TABLE(@EXCLUDE_PT_LIST, "$[*]" COLUMNS(pt_name VARCHAR(255) PATH "$")) AS jt;

DROP TABLE IF EXISTS tmp_v10_exclude_soc;
CREATE TABLE tmp_v10_exclude_soc (
    soc_name VARCHAR(255) PRIMARY KEY
) DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO tmp_v10_exclude_soc
SELECT DISTINCT soc_name
FROM JSON_TABLE(@EXCLUDE_SOC_LIST, "$[*]" COLUMNS(soc_name VARCHAR(255) PATH "$")) AS jt;

INSERT INTO tmp_v10_log (step_info, row_count)
SELECT 'Step 0: configuration initialized',
       (SELECT COUNT(*) FROM tmp_v10_target_drugs);

-- ---------------------------------------------------------------------
-- 1. Optional full-database PT cache
-- ---------------------------------------------------------------------
-- The original script depends on cache_pt_stats_v2.
-- This block creates the table if absent and populates it only when empty.

CREATE TABLE IF NOT EXISTS cache_pt_stats_v2 (
    ym CHAR(6) NOT NULL,
    pt VARCHAR(255) NOT NULL,
    case_count INT NOT NULL,
    PRIMARY KEY (ym, pt),
    INDEX idx_pt (pt)
) DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO cache_pt_stats_v2 (ym, pt, case_count)
SELECT LEFT(d.fda_dt, 6) AS ym,
       r.pt,
       COUNT(DISTINCT r.primaryid) AS case_count
FROM demo_clean d
JOIN reac r ON d.primaryid = r.primaryid
WHERE d.fda_dt BETWEEN @START_DT AND @END_DT
  AND r.pt IS NOT NULL
  AND r.pt != ''
  AND NOT EXISTS (SELECT 1 FROM cache_pt_stats_v2 LIMIT 1)
GROUP BY LEFT(d.fda_dt, 6), r.pt;

INSERT INTO tmp_v10_log (step_info, row_count)
SELECT 'Step 1: cache_pt_stats_v2 available rows',
       COUNT(*) FROM cache_pt_stats_v2;

-- ---------------------------------------------------------------------
-- 2. Target drug report base
-- ---------------------------------------------------------------------

DROP TABLE IF EXISTS res_v10_drug_base;
CREATE TABLE res_v10_drug_base AS
SELECT DISTINCT
       dr.primaryid,
       td.drugname,
       d.fda_dt
FROM drug dr
JOIN drug_clean dc ON dc.drugname = dr.drugname
JOIN demo_clean d ON dr.primaryid = d.primaryid
JOIN tmp_v10_target_drugs td ON dc.drugname_clean = td.drugname
WHERE dr.role_cod = 'PS'
  AND d.occp_cod IN ('MD', 'PH', 'OT', 'RN', 'HP')
  AND d.fda_dt BETWEEN @START_DT AND @END_DT;

CREATE INDEX idx_res_v10_drug_base_pid ON res_v10_drug_base(primaryid);
CREATE INDEX idx_res_v10_drug_base_drug ON res_v10_drug_base(drugname);

INSERT INTO tmp_v10_log (step_info, row_count)
SELECT 'Step 2: target primary-suspect drug reports',
       COUNT(*) FROM res_v10_drug_base;

-- Analysis groups:
--   POOLED = distinct report-level pooled four-agent exposure.
--   Individual drugname = agent-specific exposure.

DROP TABLE IF EXISTS res_v10_analysis_base;
CREATE TABLE res_v10_analysis_base AS
SELECT DISTINCT
       'POOLED' AS analysis_group,
       primaryid,
       fda_dt
FROM res_v10_drug_base
UNION ALL
SELECT DISTINCT
       drugname AS analysis_group,
       primaryid,
       fda_dt
FROM res_v10_drug_base;

CREATE INDEX idx_res_v10_analysis_base_group_pid ON res_v10_analysis_base(analysis_group, primaryid);

INSERT INTO tmp_v10_log (step_info, row_count)
SELECT 'Step 2b: pooled plus agent-specific analysis base rows',
       COUNT(*) FROM res_v10_analysis_base;

-- ---------------------------------------------------------------------
-- 3. Target reactions by analysis group
-- ---------------------------------------------------------------------

DROP TABLE IF EXISTS res_v10_drug_reac;
CREATE TABLE res_v10_drug_reac AS
SELECT DISTINCT
       b.analysis_group,
       b.primaryid,
       r.pt
FROM res_v10_analysis_base b
JOIN reac r ON b.primaryid = r.primaryid
LEFT JOIN tmp_v10_exclude_pt ex_pt ON r.pt = ex_pt.pt_name
LEFT JOIN meddra_soc mh ON r.pt = mh.pt_name_en
LEFT JOIN tmp_v10_exclude_soc ex_soc ON mh.soc_name_en = ex_soc.soc_name
WHERE r.pt IS NOT NULL
  AND r.pt != ''
  AND (@ENABLE_FILTER = 0 OR (ex_pt.pt_name IS NULL AND ex_soc.soc_name IS NULL));

CREATE INDEX idx_res_v10_drug_reac_group_pt ON res_v10_drug_reac(analysis_group, pt);
CREATE INDEX idx_res_v10_drug_reac_group_pid ON res_v10_drug_reac(analysis_group, primaryid);

INSERT INTO tmp_v10_log (step_info, row_count)
SELECT 'Step 3: target PT records after filters',
       COUNT(*) FROM res_v10_drug_reac;

-- ---------------------------------------------------------------------
-- 4. Four-cell counts
-- ---------------------------------------------------------------------

DROP TABLE IF EXISTS tmp_v10_n_total;
CREATE TABLE tmp_v10_n_total AS
SELECT COUNT(*) AS n_total
FROM (
    SELECT DISTINCT primaryid
    FROM demo_clean
    WHERE fda_dt BETWEEN @START_DT AND @END_DT
) x;

DROP TABLE IF EXISTS tmp_v10_n_drug;
CREATE TABLE tmp_v10_n_drug AS
SELECT analysis_group,
       COUNT(DISTINCT primaryid) AS n_drug
FROM res_v10_analysis_base
GROUP BY analysis_group;

DROP TABLE IF EXISTS tmp_v10_pt_a;
CREATE TABLE tmp_v10_pt_a AS
SELECT analysis_group,
       pt,
       COUNT(DISTINCT primaryid) AS a
FROM res_v10_drug_reac
GROUP BY analysis_group, pt
HAVING COUNT(DISTINCT primaryid) >= @MIN_CASES;

CREATE INDEX idx_tmp_v10_pt_a_group_pt ON tmp_v10_pt_a(analysis_group, pt);

DROP TABLE IF EXISTS tmp_v10_pt_ac;
CREATE TABLE tmp_v10_pt_ac AS
SELECT c.pt,
       SUM(c.case_count) AS a_plus_c
FROM cache_pt_stats_v2 c
WHERE c.ym BETWEEN LEFT(@START_DT, 6) AND LEFT(@END_DT, 6)
  AND c.pt IN (SELECT DISTINCT pt FROM tmp_v10_pt_a)
GROUP BY c.pt;

CREATE INDEX idx_tmp_v10_pt_ac_pt ON tmp_v10_pt_ac(pt);

INSERT INTO tmp_v10_log (step_info, row_count)
SELECT 'Step 4: PT rows with a >= minimum count',
       COUNT(*) FROM tmp_v10_pt_a;

-- ---------------------------------------------------------------------
-- 5. MedDRA PT/SOC lookup
-- ---------------------------------------------------------------------

DROP TABLE IF EXISTS tmp_v10_meddra_map;
CREATE TABLE tmp_v10_meddra_map AS
SELECT pt_name_en,
       MIN(pt_name_cn) AS pt_name_cn,
       MIN(soc_name_en) AS soc_name_en,
       MIN(soc_name_cn) AS soc_name_cn
FROM meddra_soc
GROUP BY pt_name_en;

CREATE INDEX idx_tmp_v10_meddra_map_pt ON tmp_v10_meddra_map(pt_name_en);

-- ---------------------------------------------------------------------
-- 6. PT signal table
-- ---------------------------------------------------------------------

DROP TABLE IF EXISTS res_v10_pt_signals_all;
CREATE TABLE res_v10_pt_signals_all AS
SELECT
    m.pt AS pt_standard_en,
    m.*,
    IF(a >= @MIN_CASES AND ROR_025 > 1, 1, 0) AS is_ror_signal,
    IF(a >= @MIN_CASES AND PRR >= 2 AND chi_squared >= 4, 1, 0) AS is_prr_signal,
    IF(a >= @MIN_CASES AND IC025 > 0, 1, 0) AS is_bcpnn_signal,
    IF(a >= @MIN_CASES AND EBGM05 >= 2, 1, 0) AS is_mgps_signal,
    IF(a >= @MIN_CASES AND ROR_025 > 1 AND PRR >= 2 AND chi_squared >= 4, 1, 0) AS is_core_ror_prr_signal,
    IF(a >= @MIN_CASES AND ROR_025 > 1 AND PRR >= 2 AND chi_squared >= 4 AND IC025 > 0 AND EBGM05 >= 2, 1, 0) AS is_strict_four_algorithm_signal,
    IF(ROR IS NOT NULL, CONCAT(FORMAT(ROR, 2), ' (', FORMAT(ROR_025, 2), ', ', FORMAT(ROR_975, 2), ')'), NULL) AS ror_95ci_range
FROM (
    SELECT
        base.analysis_group,
        base.pt,
        mm.pt_name_cn AS pt_cn,
        mm.soc_name_en AS soc_en,
        mm.soc_name_cn AS soc_cn,
        base.a AS cases,
        base.a,
        base.b,
        base.c,
        base.d,
        base.n_drug AS a_plus_b,
        base.a_plus_c,
        base.n_total AS a_plus_b_plus_c_plus_d,
        ROUND(IF(base.a_plus_c > base.a AND base.n_drug > base.a,
            (CAST(base.a AS DOUBLE) * base.d) / (CAST(base.b AS DOUBLE) * base.c),
            NULL), 2) AS ROR,
        ROUND(IF(base.a > 0 AND base.b > 0 AND base.c > 0 AND base.d > 0,
            EXP(LOG((CAST(base.a AS DOUBLE) * base.d) / (CAST(base.b AS DOUBLE) * base.c))
                - 1.96 * SQRT(1.0/base.a + 1.0/base.b + 1.0/base.c + 1.0/base.d)),
            NULL), 2) AS ROR_025,
        ROUND(IF(base.a > 0 AND base.b > 0 AND base.c > 0 AND base.d > 0,
            EXP(LOG((CAST(base.a AS DOUBLE) * base.d) / (CAST(base.b AS DOUBLE) * base.c))
                + 1.96 * SQRT(1.0/base.a + 1.0/base.b + 1.0/base.c + 1.0/base.d)),
            NULL), 2) AS ROR_975,
        ROUND(IF(base.a_plus_c > base.a,
            (CAST(base.a AS DOUBLE) / base.n_drug) / (CAST(base.c AS DOUBLE) / (base.n_total - base.n_drug)),
            NULL), 2) AS PRR,
        ROUND(IF(
            (CAST((base.a + base.b) AS DOUBLE) * CAST((base.c + base.d) AS DOUBLE) *
             CAST((base.a + base.c) AS DOUBLE) * CAST((base.b + base.d) AS DOUBLE)) > 0,
            (CAST(base.n_total AS DOUBLE) * POW(ABS(CAST(base.a AS DOUBLE) * base.d - CAST(base.b AS DOUBLE) * base.c), 2))
            / (CAST((base.a + base.b) AS DOUBLE) * CAST((base.c + base.d) AS DOUBLE) *
               CAST((base.a + base.c) AS DOUBLE) * CAST((base.b + base.d) AS DOUBLE)),
            0), 2) AS chi_squared,
        ROUND(LOG2((CAST(base.a AS DOUBLE) * base.n_total) / (CAST(base.n_drug AS DOUBLE) * base.a_plus_c)), 2) AS IC,
        ROUND(LOG2((CAST(base.a AS DOUBLE) * base.n_total) / (CAST(base.n_drug AS DOUBLE) * base.a_plus_c))
            - 2.0 * SQRT(1.0/base.a + 1.0/(base.n_drug - base.a) + 1.0/(base.a_plus_c - base.a) + 1.0/(base.n_total - base.a_plus_c - (base.n_drug - base.a))), 2) AS IC025,
        ROUND((CAST(base.n_drug AS DOUBLE) * base.a_plus_c) / base.n_total, 4) AS expected_E,
        ROUND((base.a + 0.5) / ((CAST(base.n_drug AS DOUBLE) * base.a_plus_c) / base.n_total + 0.5), 2) AS EBGM,
        ROUND(EXP(LOG((base.a + 0.5) / ((CAST(base.n_drug AS DOUBLE) * base.a_plus_c) / base.n_total + 0.5))
            - 1.645 * SQRT(1.0/base.a + 0.1)), 2) AS EBGM05
    FROM (
        SELECT
            a.analysis_group,
            a.pt,
            a.a,
            nd.n_drug,
            ac.a_plus_c,
            nt.n_total,
            CAST((nd.n_drug - a.a) AS SIGNED) AS b,
            CAST((ac.a_plus_c - a.a) AS SIGNED) AS c,
            CAST((nt.n_total - ac.a_plus_c - (nd.n_drug - a.a)) AS SIGNED) AS d
        FROM tmp_v10_pt_a a
        JOIN tmp_v10_n_drug nd ON a.analysis_group = nd.analysis_group
        JOIN tmp_v10_pt_ac ac ON a.pt = ac.pt
        CROSS JOIN tmp_v10_n_total nt
        WHERE (nd.n_drug - a.a) > 0
          AND (ac.a_plus_c - a.a) > 0
          AND (nt.n_total - ac.a_plus_c - (nd.n_drug - a.a)) > 0
    ) base
    LEFT JOIN tmp_v10_meddra_map mm ON base.pt = mm.pt_name_en
) m
ORDER BY analysis_group, cases DESC;

CREATE INDEX idx_res_v10_pt_signals_group_pt ON res_v10_pt_signals_all(analysis_group, pt);
CREATE INDEX idx_res_v10_pt_signals_group_strict ON res_v10_pt_signals_all(analysis_group, is_strict_four_algorithm_signal);

DROP TABLE IF EXISTS res_v10_pt_signals_core_ror_prr;
CREATE TABLE res_v10_pt_signals_core_ror_prr AS
SELECT *
FROM res_v10_pt_signals_all
WHERE is_core_ror_prr_signal = 1
ORDER BY analysis_group, ROR DESC;

DROP TABLE IF EXISTS res_v10_pt_signals_strict_four_algorithm;
CREATE TABLE res_v10_pt_signals_strict_four_algorithm AS
SELECT *
FROM res_v10_pt_signals_all
WHERE is_strict_four_algorithm_signal = 1
ORDER BY analysis_group, ROR DESC;

INSERT INTO tmp_v10_log (step_info, row_count)
SELECT 'Step 6: complete PT signal rows',
       COUNT(*) FROM res_v10_pt_signals_all;

INSERT INTO tmp_v10_log (step_info, row_count)
SELECT 'Step 6b: strict four-algorithm PT signal rows',
       COUNT(*) FROM res_v10_pt_signals_strict_four_algorithm;

-- ---------------------------------------------------------------------
-- 7. SOC summary outputs
-- ---------------------------------------------------------------------
-- Two SOC outputs are generated:
--   A) res_v10_soc_signals_all: true SOC-level disproportionality analysis.
--      This is the "complete SOC table" for manuscript/supplement use.
--   B) res_v10_soc_summary_all: PT-derived SOC summary, useful for checking
--      how many positive PTs fall under each SOC.

-- 7A. True SOC-level disproportionality analysis

CREATE TABLE IF NOT EXISTS cache_soc_stats_v2 (
    ym CHAR(6) NOT NULL,
    soc_en VARCHAR(255) NOT NULL,
    case_count INT NOT NULL,
    PRIMARY KEY (ym, soc_en),
    INDEX idx_soc_en (soc_en)
) DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO cache_soc_stats_v2 (ym, soc_en, case_count)
SELECT LEFT(d.fda_dt, 6) AS ym,
       mh.soc_name_en AS soc_en,
       COUNT(DISTINCT r.primaryid) AS case_count
FROM demo_clean d
JOIN reac r ON d.primaryid = r.primaryid
JOIN meddra_soc mh ON r.pt = mh.pt_name_en
WHERE d.fda_dt BETWEEN @START_DT AND @END_DT
  AND r.pt IS NOT NULL
  AND r.pt != ''
  AND mh.soc_name_en IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM cache_soc_stats_v2 LIMIT 1)
GROUP BY LEFT(d.fda_dt, 6), mh.soc_name_en;

DROP TABLE IF EXISTS tmp_v10_soc_a;
CREATE TABLE tmp_v10_soc_a AS
SELECT
    rr.analysis_group,
    mh.soc_name_en AS soc_en,
    MIN(mh.soc_name_cn) AS soc_cn,
    COUNT(DISTINCT rr.primaryid) AS a
FROM res_v10_drug_reac rr
JOIN meddra_soc mh ON rr.pt = mh.pt_name_en
WHERE mh.soc_name_en IS NOT NULL
GROUP BY rr.analysis_group, mh.soc_name_en
HAVING COUNT(DISTINCT rr.primaryid) >= @MIN_CASES;

CREATE INDEX idx_tmp_v10_soc_a_group_soc ON tmp_v10_soc_a(analysis_group, soc_en);

DROP TABLE IF EXISTS tmp_v10_soc_ac;
CREATE TABLE tmp_v10_soc_ac AS
SELECT soc_en,
       SUM(case_count) AS a_plus_c
FROM cache_soc_stats_v2
WHERE ym BETWEEN LEFT(@START_DT, 6) AND LEFT(@END_DT, 6)
  AND soc_en IN (SELECT DISTINCT soc_en FROM tmp_v10_soc_a)
GROUP BY soc_en;

CREATE INDEX idx_tmp_v10_soc_ac_soc ON tmp_v10_soc_ac(soc_en);

DROP TABLE IF EXISTS res_v10_soc_signals_all;
CREATE TABLE res_v10_soc_signals_all AS
SELECT
    m.*,
    IF(a >= @MIN_CASES AND ROR_025 > 1, 1, 0) AS is_ror_signal,
    IF(a >= @MIN_CASES AND PRR >= 2 AND chi_squared >= 4, 1, 0) AS is_prr_signal,
    IF(a >= @MIN_CASES AND IC025 > 0, 1, 0) AS is_bcpnn_signal,
    IF(a >= @MIN_CASES AND EBGM05 >= 2, 1, 0) AS is_mgps_signal,
    IF(a >= @MIN_CASES AND ROR_025 > 1 AND PRR >= 2 AND chi_squared >= 4, 1, 0) AS is_core_ror_prr_signal,
    IF(a >= @MIN_CASES AND ROR_025 > 1 AND PRR >= 2 AND chi_squared >= 4 AND IC025 > 0 AND EBGM05 >= 2, 1, 0) AS is_strict_four_algorithm_signal,
    IF(ROR IS NOT NULL, CONCAT(FORMAT(ROR, 2), ' (', FORMAT(ROR_025, 2), ', ', FORMAT(ROR_975, 2), ')'), NULL) AS ror_95ci_range
FROM (
    SELECT
        base.analysis_group,
        base.soc_en,
        base.soc_cn,
        base.a AS cases,
        base.a,
        base.b,
        base.c,
        base.d,
        base.n_drug AS a_plus_b,
        base.a_plus_c,
        base.n_total AS a_plus_b_plus_c_plus_d,
        ROUND(IF(base.a_plus_c > base.a AND base.n_drug > base.a,
            (CAST(base.a AS DOUBLE) * base.d) / (CAST(base.b AS DOUBLE) * base.c),
            NULL), 2) AS ROR,
        ROUND(IF(base.a > 0 AND base.b > 0 AND base.c > 0 AND base.d > 0,
            EXP(LOG((CAST(base.a AS DOUBLE) * base.d) / (CAST(base.b AS DOUBLE) * base.c))
                - 1.96 * SQRT(1.0/base.a + 1.0/base.b + 1.0/base.c + 1.0/base.d)),
            NULL), 2) AS ROR_025,
        ROUND(IF(base.a > 0 AND base.b > 0 AND base.c > 0 AND base.d > 0,
            EXP(LOG((CAST(base.a AS DOUBLE) * base.d) / (CAST(base.b AS DOUBLE) * base.c))
                + 1.96 * SQRT(1.0/base.a + 1.0/base.b + 1.0/base.c + 1.0/base.d)),
            NULL), 2) AS ROR_975,
        ROUND(IF(base.a_plus_c > base.a,
            (CAST(base.a AS DOUBLE) / base.n_drug) / (CAST(base.c AS DOUBLE) / (base.n_total - base.n_drug)),
            NULL), 2) AS PRR,
        ROUND(IF(
            (CAST((base.a + base.b) AS DOUBLE) * CAST((base.c + base.d) AS DOUBLE) *
             CAST((base.a + base.c) AS DOUBLE) * CAST((base.b + base.d) AS DOUBLE)) > 0,
            (CAST(base.n_total AS DOUBLE) * POW(ABS(CAST(base.a AS DOUBLE) * base.d - CAST(base.b AS DOUBLE) * base.c), 2))
            / (CAST((base.a + base.b) AS DOUBLE) * CAST((base.c + base.d) AS DOUBLE) *
               CAST((base.a + base.c) AS DOUBLE) * CAST((base.b + base.d) AS DOUBLE)),
            0), 2) AS chi_squared,
        ROUND(LOG2((CAST(base.a AS DOUBLE) * base.n_total) / (CAST(base.n_drug AS DOUBLE) * base.a_plus_c)), 2) AS IC,
        ROUND(LOG2((CAST(base.a AS DOUBLE) * base.n_total) / (CAST(base.n_drug AS DOUBLE) * base.a_plus_c))
            - 2.0 * SQRT(1.0/base.a + 1.0/(base.n_drug - base.a) + 1.0/(base.a_plus_c - base.a) + 1.0/(base.n_total - base.a_plus_c - (base.n_drug - base.a))), 2) AS IC025,
        ROUND((CAST(base.n_drug AS DOUBLE) * base.a_plus_c) / base.n_total, 4) AS expected_E,
        ROUND((base.a + 0.5) / ((CAST(base.n_drug AS DOUBLE) * base.a_plus_c) / base.n_total + 0.5), 2) AS EBGM,
        ROUND(EXP(LOG((base.a + 0.5) / ((CAST(base.n_drug AS DOUBLE) * base.a_plus_c) / base.n_total + 0.5))
            - 1.645 * SQRT(1.0/base.a + 0.1)), 2) AS EBGM05
    FROM (
        SELECT
            sa.analysis_group,
            sa.soc_en,
            sa.soc_cn,
            sa.a,
            nd.n_drug,
            sac.a_plus_c,
            nt.n_total,
            CAST((nd.n_drug - sa.a) AS SIGNED) AS b,
            CAST((sac.a_plus_c - sa.a) AS SIGNED) AS c,
            CAST((nt.n_total - sac.a_plus_c - (nd.n_drug - sa.a)) AS SIGNED) AS d
        FROM tmp_v10_soc_a sa
        JOIN tmp_v10_n_drug nd ON sa.analysis_group = nd.analysis_group
        JOIN tmp_v10_soc_ac sac ON sa.soc_en = sac.soc_en
        CROSS JOIN tmp_v10_n_total nt
        WHERE (nd.n_drug - sa.a) > 0
          AND (sac.a_plus_c - sa.a) > 0
          AND (nt.n_total - sac.a_plus_c - (nd.n_drug - sa.a)) > 0
    ) base
) m
ORDER BY analysis_group, cases DESC;

CREATE INDEX idx_res_v10_soc_signals_group_soc ON res_v10_soc_signals_all(analysis_group, soc_en);

DROP TABLE IF EXISTS res_v10_soc_signals_strict_positive;
CREATE TABLE res_v10_soc_signals_strict_positive AS
SELECT *
FROM res_v10_soc_signals_all
WHERE is_strict_four_algorithm_signal = 1
ORDER BY analysis_group, ROR DESC;

INSERT INTO tmp_v10_log (step_info, row_count)
SELECT 'Step 7A: complete SOC-level signal rows',
       COUNT(*) FROM res_v10_soc_signals_all;

INSERT INTO tmp_v10_log (step_info, row_count)
SELECT 'Step 7A2: strict four-algorithm SOC signal rows',
       COUNT(*) FROM res_v10_soc_signals_strict_positive;

-- 7B. PT-derived SOC summary

DROP TABLE IF EXISTS res_v10_soc_summary_all;
CREATE TABLE res_v10_soc_summary_all AS
SELECT
    analysis_group,
    soc_en,
    soc_cn,
    COUNT(DISTINCT pt) AS pt_count,
    SUM(cases) AS summed_pt_case_count,
    SUM(is_ror_signal) AS ror_positive_pt_count,
    SUM(is_prr_signal) AS prr_positive_pt_count,
    SUM(is_bcpnn_signal) AS bcpnn_positive_pt_count,
    SUM(is_mgps_signal) AS mgps_positive_pt_count,
    SUM(is_core_ror_prr_signal) AS core_ror_prr_positive_pt_count,
    SUM(is_strict_four_algorithm_signal) AS strict_four_algorithm_positive_pt_count,
    MAX(ROR) AS max_ROR,
    MAX(PRR) AS max_PRR,
    MAX(IC) AS max_IC,
    MAX(EBGM) AS max_EBGM
FROM res_v10_pt_signals_all
GROUP BY analysis_group, soc_en, soc_cn
ORDER BY analysis_group, strict_four_algorithm_positive_pt_count DESC, summed_pt_case_count DESC;

DROP TABLE IF EXISTS res_v10_soc_summary_strict_positive;
CREATE TABLE res_v10_soc_summary_strict_positive AS
SELECT *
FROM res_v10_soc_summary_all
WHERE strict_four_algorithm_positive_pt_count > 0
ORDER BY analysis_group, strict_four_algorithm_positive_pt_count DESC, summed_pt_case_count DESC;

INSERT INTO tmp_v10_log (step_info, row_count)
SELECT 'Step 7: SOC summary rows',
       COUNT(*) FROM res_v10_soc_summary_all;

-- ---------------------------------------------------------------------
-- 8. TTO base and summary outputs
-- ---------------------------------------------------------------------

DROP TABLE IF EXISTS res_v10_tto_base;
CREATE TABLE res_v10_tto_base AS
SELECT DISTINCT
    b.analysis_group,
    b.primaryid,
    DATEDIFF(STR_TO_DATE(d.event_dt, '%Y%m%d'), STR_TO_DATE(th.start_dt, '%Y%m%d')) AS tto_days,
    d.event_dt,
    th.start_dt
FROM res_v10_analysis_base b
JOIN demo_clean d ON b.primaryid = d.primaryid
JOIN drug dr ON b.primaryid = dr.primaryid
JOIN drug_clean dc ON dc.drugname = dr.drugname
JOIN tmp_v10_target_drugs td ON dc.drugname_clean = td.drugname
JOIN ther th ON dr.primaryid = th.primaryid
            AND dr.drug_seq = th.dsg_drug_seq
WHERE d.event_dt REGEXP '^[0-9]{8}$'
  AND th.start_dt REGEXP '^[0-9]{8}$'
  AND th.start_dt IS NOT NULL
  AND d.event_dt IS NOT NULL
HAVING tto_days >= 0 AND tto_days <= 730;

CREATE INDEX idx_res_v10_tto_base_group_days ON res_v10_tto_base(analysis_group, tto_days);

DROP TABLE IF EXISTS res_v10_tto_distribution;
CREATE TABLE res_v10_tto_distribution AS
SELECT
    analysis_group,
    tto_group,
    case_count,
    ROUND(case_count * 100.0 / SUM(case_count) OVER(PARTITION BY analysis_group), 2) AS percentage
FROM (
    SELECT
        analysis_group,
        CASE
            WHEN tto_days = 0 THEN '00: same day'
            WHEN tto_days = 1 THEN '01: 1 day / within 24-48h depending on date granularity'
            WHEN tto_days BETWEEN 0 AND 1 THEN '02: <=1 day'
            WHEN tto_days BETWEEN 0 AND 30 THEN '03: 0-30 days'
            WHEN tto_days BETWEEN 31 AND 60 THEN '04: 31-60 days'
            WHEN tto_days BETWEEN 61 AND 90 THEN '05: 61-90 days'
            WHEN tto_days BETWEEN 91 AND 180 THEN '06: 91-180 days'
            ELSE '07: More than 180 days'
        END AS tto_group,
        COUNT(DISTINCT primaryid) AS case_count
    FROM res_v10_tto_base
    GROUP BY analysis_group, tto_group
) x
ORDER BY analysis_group, tto_group;

DROP TABLE IF EXISTS tmp_v10_tto_ordered;
CREATE TABLE tmp_v10_tto_ordered AS
SELECT
    analysis_group,
    primaryid,
    tto_days,
    ROW_NUMBER() OVER(PARTITION BY analysis_group ORDER BY tto_days, primaryid) AS rn,
    COUNT(*) OVER(PARTITION BY analysis_group) AS n
FROM res_v10_tto_base;

DROP TABLE IF EXISTS res_v10_tto_summary;
CREATE TABLE res_v10_tto_summary AS
SELECT
    o.analysis_group,
    MAX(o.n) AS evaluable_tto_reports,
    SUM(CASE WHEN o.tto_days = 0 THEN 1 ELSE 0 END) AS same_day_reports,
    ROUND(SUM(CASE WHEN o.tto_days = 0 THEN 1 ELSE 0 END) * 100.0 / MAX(o.n), 2) AS same_day_percentage,
    SUM(CASE WHEN o.tto_days <= 1 THEN 1 ELSE 0 END) AS within_1_day_reports,
    ROUND(SUM(CASE WHEN o.tto_days <= 1 THEN 1 ELSE 0 END) * 100.0 / MAX(o.n), 2) AS within_1_day_percentage,
    SUM(CASE WHEN o.tto_days <= 30 THEN 1 ELSE 0 END) AS within_30_days_reports,
    ROUND(SUM(CASE WHEN o.tto_days <= 30 THEN 1 ELSE 0 END) * 100.0 / MAX(o.n), 2) AS within_30_days_percentage,
    AVG(CASE WHEN o.rn IN (FLOOR((o.n + 1) / 2), FLOOR((o.n + 2) / 2)) THEN o.tto_days END) AS median_tto_days,
    MIN(CASE WHEN o.rn >= CEIL(0.25 * o.n) THEN o.tto_days END) AS q1_tto_days_nearest_rank,
    MIN(CASE WHEN o.rn >= CEIL(0.75 * o.n) THEN o.tto_days END) AS q3_tto_days_nearest_rank,
    MIN(o.tto_days) AS min_tto_days,
    MAX(o.tto_days) AS max_tto_days
FROM tmp_v10_tto_ordered o
GROUP BY o.analysis_group
ORDER BY o.analysis_group;

DROP TABLE IF EXISTS res_v10_tto_weibull_input;
CREATE TABLE res_v10_tto_weibull_input AS
SELECT
    analysis_group,
    primaryid,
    tto_days,
    CASE
        WHEN tto_days = 0 THEN 0.5
        ELSE CAST(tto_days AS DOUBLE)
    END AS tto_days_for_weibull,
    event_dt,
    start_dt,
    'Day-level FAERS dates: same-day events coded as 0.5 day for Weibull fitting; verify this convention before final submission.' AS weibull_time_convention
FROM res_v10_tto_base
WHERE tto_days IS NOT NULL
  AND tto_days >= 0;

INSERT INTO tmp_v10_log (step_info, row_count)
SELECT 'Step 8: evaluable TTO report rows',
       COUNT(*) FROM res_v10_tto_base;

-- ---------------------------------------------------------------------
-- 9. Final export SELECT statements
-- ---------------------------------------------------------------------
-- Run these SELECT statements to export CSV/XLSX tables for manuscript and supplement.

SELECT * FROM tmp_v10_log ORDER BY step_id;

SELECT
    analysis_group, pt_standard_en, pt, pt_cn, soc_en, soc_cn,
    cases, a, b, c, d,
    a_plus_b, a_plus_c, a_plus_b_plus_c_plus_d,
    ROR, ROR_025, ROR_975, ror_95ci_range,
    PRR, chi_squared,
    IC, IC025,
    expected_E, EBGM, EBGM05,
    is_ror_signal, is_prr_signal, is_bcpnn_signal, is_mgps_signal,
    is_core_ror_prr_signal, is_strict_four_algorithm_signal
FROM res_v10_pt_signals_all
ORDER BY analysis_group, cases DESC, ROR DESC;

SELECT
    analysis_group, pt_standard_en, pt, pt_cn, soc_en, soc_cn,
    cases, a, b, c, d,
    ROR, ROR_025, ROR_975, ror_95ci_range,
    PRR, chi_squared,
    IC, IC025,
    expected_E, EBGM, EBGM05,
    is_ror_signal, is_prr_signal, is_bcpnn_signal, is_mgps_signal,
    is_core_ror_prr_signal, is_strict_four_algorithm_signal
FROM res_v10_pt_signals_strict_four_algorithm
ORDER BY analysis_group, ROR DESC;

SELECT * FROM res_v10_soc_summary_all;

SELECT * FROM res_v10_soc_summary_strict_positive;

SELECT
    analysis_group, soc_en, soc_cn,
    cases, a, b, c, d,
    a_plus_b, a_plus_c, a_plus_b_plus_c_plus_d,
    ROR, ROR_025, ROR_975, ror_95ci_range,
    PRR, chi_squared,
    IC, IC025,
    expected_E, EBGM, EBGM05,
    is_ror_signal, is_prr_signal, is_bcpnn_signal, is_mgps_signal,
    is_core_ror_prr_signal, is_strict_four_algorithm_signal
FROM res_v10_soc_signals_all
ORDER BY analysis_group, cases DESC, ROR DESC;

SELECT
    analysis_group, soc_en, soc_cn,
    cases, a, b, c, d,
    ROR, ROR_025, ROR_975, ror_95ci_range,
    PRR, chi_squared,
    IC, IC025,
    expected_E, EBGM, EBGM05,
    is_ror_signal, is_prr_signal, is_bcpnn_signal, is_mgps_signal,
    is_core_ror_prr_signal, is_strict_four_algorithm_signal
FROM res_v10_soc_signals_strict_positive
ORDER BY analysis_group, ROR DESC;

SELECT * FROM res_v10_tto_summary;

SELECT * FROM res_v10_tto_distribution;

SELECT analysis_group, primaryid, tto_days, event_dt, start_dt
FROM res_v10_tto_base
ORDER BY analysis_group, tto_days, primaryid;

SELECT analysis_group, primaryid, tto_days, tto_days_for_weibull, event_dt, start_dt, weibull_time_convention
FROM res_v10_tto_weibull_input
ORDER BY analysis_group, tto_days_for_weibull, primaryid;
