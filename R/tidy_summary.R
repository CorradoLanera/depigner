#' tidy_summary
#'
#' Converts a \code{summary()} object produced by \code{Hmisc} or
#' by \code{rms} packages to a tidy data frame ready to be
#' \code{\link[pander]{pander}}ed (e.g. printed on a word document after
#' \code{\link[knitr]{knit}} the source.
#'
#' @param x an object used to select a method, output of some summary
#'          by \code{\link{Hmisc}}.
#' @param ... further arguments passed to or from other methods
#'
#' @return a [tibble][tibble::tibble-package]
#' @export
tidy_summary <- function(x, ...) {
  UseMethod("tidy_summary")
}




#' @inheritParams tidy_summary
#' @importFrom magrittr %>%
#' @describeIn tidy_summary tidy a summary reverse output from the
#'             \code{\link[Hmisc]{summary.formula}} called with
#'             \code{method = "reverse"}.
#'
#' @note to see the options you can pass to \code{...} for a custom
#' print, see the print section in \code{\link[Hmisc]{summary.formula}}.
#'
#' @export
#' @examples
#' library(Hmisc)
#' my_summary <- summary(Species ~., data = iris, method = "reverse")
#' tidy_summary(my_summary)
tidy_summary.summary.formula.reverse <- function(x, ...) {
  invisible(capture.output(
    printed <- print(x, ...)
  ))

  colnames(printed) <- printed[1, ]

  dplyr::as_data_frame(printed) %>%
    dplyr::mutate(
      `&nbsp;` = row.names(printed) %>%
        stringr::str_replace_all(' ', '&nbsp;')
    ) %>%
    dplyr::select(`&nbsp;`, dplyr::everything()) %>%
    dplyr::filter(dplyr::row_number() !=1)

}



#' summary_cox
#'
#' Convert the output of the \code{\link[rms]{summary.rms}} into a data
#' frame, reporting only the Hazard Ratio with the .95 CI and the incremental
#' step (for continuous variables) reference (for categorical variables) for
#' which the Hazard is refered to (i.e. without $\beta$s, Low, High, S.E. and
#' Type).
#'
#' @param cox_model A `code{cph}` object as produced by \code{\link[rms]{cph}}.
#'
#' @return a [tibble][tibble::tibble-package]
#'
#' @note This is a non-exported function, use this at your own risk.
#' Probably it will change in the near future.
#'
summary_cox <- function(cox_model) {#, plev = 0.05, hip = TRUE, digits = 3) {
  broom::tidy(summary(cox_model)) %>%
  dplyr::mutate(.rownames = lag(.rownames)) %>%
  dplyr::filter(Type == 2) %>%
  dplyr::select(-Low, - High, - S.E., -Type) %>%
  dplyr::mutate(
    Diff.     = ifelse(!is.na(Diff.), Diff.,
                  stringr::str_extract(.rownames, ' - .*$') %>%
                  stringr::str_replace(' - ', '')),
    .rownames = stringr::str_replace(.rownames, ' -+.*$', '')
  ) %>%
  dplyr::rename(
    `&nbsp;`     = .rownames,
    `Hazard Ratio` = Effect
  )
}
