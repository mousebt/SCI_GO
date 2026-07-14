# Fit Weibull parameters for FAERS time-to-onset analysis
#
# Input:
#   CSV exported from MySQL table `res_v10_tto_weibull_input`
#   Required columns:
#     analysis_group
#     tto_days_for_weibull
#
# Recommended MySQL export table:
#   SELECT analysis_group, primaryid, tto_days, tto_days_for_weibull, event_dt, start_dt
#   FROM res_v10_tto_weibull_input;
#
# Convention:
#   Same-day events (tto_days = 0) are coded as 0.5 day for Weibull fitting
#   because the FAERS dates are day-level rather than exact timestamps.
#   Verify this convention before final submission.
#
# Usage:
#   Rscript fit_weibull_tto.R res_v10_tto_weibull_input.csv res_v10_tto_weibull_parameters.csv

args <- commandArgs(trailingOnly = TRUE)
if (length(args) < 2) {
  stop("Usage: Rscript fit_weibull_tto.R input.csv output.csv", call. = FALSE)
}

input_file <- args[[1]]
output_file <- args[[2]]

dat <- read.csv(input_file, stringsAsFactors = FALSE, check.names = FALSE)

required <- c("analysis_group", "tto_days_for_weibull")
missing_cols <- setdiff(required, names(dat))
if (length(missing_cols) > 0) {
  stop(paste("Missing required columns:", paste(missing_cols, collapse = ", ")), call. = FALSE)
}

dat <- dat[is.finite(dat$tto_days_for_weibull) & dat$tto_days_for_weibull > 0, ]

fit_one_group <- function(x) {
  x <- x[is.finite(x) & x > 0]
  n <- length(x)
  if (n < 3) {
    return(data.frame(
      n = n,
      weibull_shape = NA_real_,
      weibull_shape_lcl95 = NA_real_,
      weibull_shape_ucl95 = NA_real_,
      weibull_scale = NA_real_,
      weibull_scale_lcl95 = NA_real_,
      weibull_scale_ucl95 = NA_real_,
      median_tto_days_model = NA_real_,
      q25_tto_days_model = NA_real_,
      q75_tto_days_model = NA_real_,
      convergence = NA_integer_
    ))
  }

  nll <- function(par) {
    log_shape <- par[1]
    log_scale <- par[2]
    shape <- exp(log_shape)
    scale <- exp(log_scale)
    -sum(dweibull(x, shape = shape, scale = scale, log = TRUE))
  }

  start_shape <- 1
  start_scale <- median(x)
  opt <- optim(
    par = c(log(start_shape), log(start_scale)),
    fn = nll,
    method = "BFGS",
    hessian = TRUE,
    control = list(maxit = 10000)
  )

  log_shape <- opt$par[1]
  log_scale <- opt$par[2]
  shape <- exp(log_shape)
  scale <- exp(log_scale)

  se_log_shape <- NA_real_
  se_log_scale <- NA_real_
  if (all(is.finite(opt$hessian))) {
    inv_h <- tryCatch(solve(opt$hessian), error = function(e) NULL)
    if (!is.null(inv_h)) {
      se_log_shape <- sqrt(inv_h[1, 1])
      se_log_scale <- sqrt(inv_h[2, 2])
    }
  }

  shape_lcl <- exp(log_shape - 1.96 * se_log_shape)
  shape_ucl <- exp(log_shape + 1.96 * se_log_shape)
  scale_lcl <- exp(log_scale - 1.96 * se_log_scale)
  scale_ucl <- exp(log_scale + 1.96 * se_log_scale)

  data.frame(
    n = n,
    weibull_shape = shape,
    weibull_shape_lcl95 = shape_lcl,
    weibull_shape_ucl95 = shape_ucl,
    weibull_scale = scale,
    weibull_scale_lcl95 = scale_lcl,
    weibull_scale_ucl95 = scale_ucl,
    median_tto_days_model = qweibull(0.50, shape = shape, scale = scale),
    q25_tto_days_model = qweibull(0.25, shape = shape, scale = scale),
    q75_tto_days_model = qweibull(0.75, shape = shape, scale = scale),
    convergence = opt$convergence
  )
}

groups <- sort(unique(dat$analysis_group))
out <- do.call(rbind, lapply(groups, function(g) {
  ans <- fit_one_group(dat$tto_days_for_weibull[dat$analysis_group == g])
  data.frame(analysis_group = g, ans, row.names = NULL)
}))

numeric_cols <- setdiff(names(out), c("analysis_group", "convergence"))
out[numeric_cols] <- lapply(out[numeric_cols], function(z) {
  ifelse(is.na(z), NA, round(z, 6))
})

write.csv(out, output_file, row.names = FALSE, fileEncoding = "UTF-8")

