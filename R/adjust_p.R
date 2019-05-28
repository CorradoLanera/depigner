#' Adjust P-values
#'
#' Adjust P-values of a \code{\link{tidy_summary}} object
#'
#' @param x a \code{\link{tidy_summary}} object.
#' @param method (chr, default = "BH") a valid method for
#'     \code{\link[stats]{p.adjust}}
#'
#' @return a \code{\link{tidy_summary}} object with the Ps adjusted
#' @export
#'
#' @examples
#'   library(Hmisc)
#'   my_summary <- summary(Species ~., data = iris, method = "reverse")
#'
#'   tidy_summary(my_summary) %>%
#'       adjust_p()
#'
adjust_p <- function(x, method) {
  UseMethod("adjust_p")
}












#' @rdname adjust_p
#' @export
adjust_p.tidy_summary <- function(x, method = "BH") {


  if (is.null(x$`P-value`)) {
    usethis::ui_oops(
      "The object {usethis::ui_code('x')} does not have a {usethis::ui_field('P-value')} column.
      Have you select {usethis::ui_code('test = TRUE')} in the {usethis::ui_code('summary')} call?"
    )
    usethis::ui_oops("{usethis::ui_code('x')} is returned without changes.")
    return(x)
  }

  adj_methods <- c(
    "holm", "hochberg", "hommel", "bonferroni", "BH", "BY", "fdr",
    "none"
  )
  if (!method %in% adj_methods) usethis::ui_stop(
    "method selected is {usethis::ui_value(method)}.
    It must be one of {usethis::ui_value(adj_methods)}.
    Please, provide a valid method."
  )


  # The first one is not empty because it is the header
  are_ps <- x$`P-value` %>%
    stringr::str_detect("^ +$", negate = TRUE) %>%
    `[<-`(1, FALSE)

  ps <- x$`P-value` %>%
    stringr::str_replace("<", "") %>%
    `[`(are_ps) %>%
    as.numeric()

  # (Can someone find an alternative method to conclude "<0.001"
  # maintaining consistency round(3) for the other values, and with the
  # further padding that comes after? If so, please purpose it! :-)
  ps_adj <- stats::p.adjust(ps, method = method) %>% round(3)
  ps_adj[ps_adj == 0.001] <- "<=0.001"

  # returned string-values must conserve the original lenght
  nchar_ps <- nchar(x$`P-value`[[1]])
  ps_adj <- stringr::str_pad(ps_adj, nchar_ps)

  x$`P-value`[are_ps] <- ps_adj

  usethis::ui_done("P adjusted with {method} method.")
  x
}
