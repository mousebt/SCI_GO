#!/usr/bin/env python
"""
Fit Weibull parameters for FAERS time-to-onset analysis.

Input:
    CSV exported from MySQL table `res_v10_tto_weibull_input`

Required columns:
    analysis_group
    tto_days_for_weibull

Recommended MySQL export:
    SELECT analysis_group, primaryid, tto_days, tto_days_for_weibull, event_dt, start_dt
    FROM res_v10_tto_weibull_input;

Convention:
    Same-day events (tto_days = 0) are coded as 0.5 day for Weibull fitting
    because FAERS dates are day-level rather than exact timestamps.
    Verify this convention before final submission.

Usage:
    python fit_weibull_tto.py res_v10_tto_weibull_input.csv res_v10_tto_weibull_parameters.csv

Dependencies:
    numpy, pandas, scipy
"""

from __future__ import annotations

import argparse
from pathlib import Path

import numpy as np
import pandas as pd
from scipy.optimize import minimize
from scipy.stats import norm, weibull_min


def _safe_float(value: float) -> float | None:
    if value is None:
        return None
    if not np.isfinite(value):
        return None
    return float(value)


def fit_one_group(values: np.ndarray) -> dict[str, float | int | None]:
    values = np.asarray(values, dtype=float)
    values = values[np.isfinite(values) & (values > 0)]
    n = int(values.size)

    if n < 3:
        return {
            "n": n,
            "weibull_shape": None,
            "weibull_shape_lcl95": None,
            "weibull_shape_ucl95": None,
            "weibull_scale": None,
            "weibull_scale_lcl95": None,
            "weibull_scale_ucl95": None,
            "median_tto_days_model": None,
            "q25_tto_days_model": None,
            "q75_tto_days_model": None,
            "convergence": 1,
            "optimizer_message": "fewer than 3 positive observations",
        }

    def nll(params: np.ndarray) -> float:
        log_shape, log_scale = params
        shape = np.exp(log_shape)
        scale = np.exp(log_scale)
        return float(-np.sum(weibull_min.logpdf(values, c=shape, scale=scale)))

    start = np.array([np.log(1.0), np.log(np.median(values))], dtype=float)
    opt = minimize(nll, start, method="BFGS", options={"maxiter": 10000})

    log_shape, log_scale = opt.x
    shape = float(np.exp(log_shape))
    scale = float(np.exp(log_scale))

    se_log_shape = np.nan
    se_log_scale = np.nan
    hess_inv = getattr(opt, "hess_inv", None)
    if hess_inv is not None:
        hess_inv_array = np.asarray(hess_inv, dtype=float)
        if hess_inv_array.shape == (2, 2):
            if np.isfinite(hess_inv_array[0, 0]) and hess_inv_array[0, 0] >= 0:
                se_log_shape = float(np.sqrt(hess_inv_array[0, 0]))
            if np.isfinite(hess_inv_array[1, 1]) and hess_inv_array[1, 1] >= 0:
                se_log_scale = float(np.sqrt(hess_inv_array[1, 1]))

    z = float(norm.ppf(0.975))

    shape_lcl = np.exp(log_shape - z * se_log_shape) if np.isfinite(se_log_shape) else np.nan
    shape_ucl = np.exp(log_shape + z * se_log_shape) if np.isfinite(se_log_shape) else np.nan
    scale_lcl = np.exp(log_scale - z * se_log_scale) if np.isfinite(se_log_scale) else np.nan
    scale_ucl = np.exp(log_scale + z * se_log_scale) if np.isfinite(se_log_scale) else np.nan

    return {
        "n": n,
        "weibull_shape": _safe_float(shape),
        "weibull_shape_lcl95": _safe_float(shape_lcl),
        "weibull_shape_ucl95": _safe_float(shape_ucl),
        "weibull_scale": _safe_float(scale),
        "weibull_scale_lcl95": _safe_float(scale_lcl),
        "weibull_scale_ucl95": _safe_float(scale_ucl),
        "median_tto_days_model": _safe_float(weibull_min.ppf(0.50, c=shape, scale=scale)),
        "q25_tto_days_model": _safe_float(weibull_min.ppf(0.25, c=shape, scale=scale)),
        "q75_tto_days_model": _safe_float(weibull_min.ppf(0.75, c=shape, scale=scale)),
        "convergence": int(not opt.success),
        "optimizer_message": str(opt.message),
    }


def main() -> None:
    parser = argparse.ArgumentParser(
        description="Fit Weibull shape/scale and 95% confidence intervals for FAERS TTO data."
    )
    parser.add_argument("input_csv", type=Path)
    parser.add_argument("output_csv", type=Path)
    args = parser.parse_args()

    data = pd.read_csv(args.input_csv)
    required = {"analysis_group", "tto_days_for_weibull"}
    missing = sorted(required.difference(data.columns))
    if missing:
        raise SystemExit(f"Missing required columns: {', '.join(missing)}")

    rows: list[dict[str, object]] = []
    for group, group_df in data.groupby("analysis_group", sort=True):
        result = fit_one_group(group_df["tto_days_for_weibull"].to_numpy())
        result["analysis_group"] = group
        rows.append(result)

    out = pd.DataFrame(rows)
    ordered_cols = [
        "analysis_group",
        "n",
        "weibull_shape",
        "weibull_shape_lcl95",
        "weibull_shape_ucl95",
        "weibull_scale",
        "weibull_scale_lcl95",
        "weibull_scale_ucl95",
        "median_tto_days_model",
        "q25_tto_days_model",
        "q75_tto_days_model",
        "convergence",
        "optimizer_message",
    ]
    out = out[ordered_cols]

    numeric_cols = [
        c
        for c in out.columns
        if c not in {"analysis_group", "optimizer_message"}
    ]
    for col in numeric_cols:
        out[col] = pd.to_numeric(out[col], errors="coerce")
    out[numeric_cols] = out[numeric_cols].round(6)

    args.output_csv.parent.mkdir(parents=True, exist_ok=True)
    out.to_csv(args.output_csv, index=False, encoding="utf-8-sig")


if __name__ == "__main__":
    main()

