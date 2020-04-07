#' ci2p
#'
#' \code{ci2p} compute the p-value related with a provided confidence
#' interval. It considers a simmetric distribution (by default standard
#' normal).
#'
#' Confidence level can be customize (by default 95%) and it is also
#' possible to apply a log trasformation in case of proportions.
#'
#' @param est estimated value
#' @param lower lower bound of the confidence level
#' @param upper upper bound of the confidence level
#' @param log_trasform (default `FALSE`) flag indicating if a log
#'                     trasformation as to apply to the data
#' @param conf (default `95\%`) confidence level
#' @param qdist (default `qnorm`) quantile function
#' @param pdist (default `pnorm`) distribution function
#'
#' @return a p-value
#' @export
#'
#' @examples
#'
#' ci2p(1.125, 0.634,	1.999, log_trasform = TRUE)
#' ci2p(1.257, 1.126,	1.403, log_trasform = TRUE)

ci2p <- function(
  est, lower, upper,
  log_trasform = FALSE,
  conf   = 0.95,
  qdist  = stats::qnorm,
  pdist  = stats::pnorm
) {
  if (upper < lower) {
    `*tmp*` <- lower
    lower   <- upper
    upper   <- `*tmp*`
    rm(`*tmp*`)
    ui_warn('upper < lower: they are considered reversed')
  }

  if (log_trasform) {
    est   <- log(est)
    lower <- log(lower)
    upper <- log(upper)
  }

  se <- (upper - lower) / (2 * qdist(conf))
  1 - pdist(est / se)
}
