#' tidy_summary
#'
#' Converts a \code{summary()} object produced by \code{Hmisc} or
#' by \code{rms} packages to a tidy data frame ready to be
#' \code{\link[pander]{pander}}ed (e.g. printed on a word document after
#' \code{\link[knitr]{knit}} the source.
#'
#' @param x an object used to select a method, output of some summary
#'          by \code{Hmisc}.
#' @param ... further arguments passed to or from other methods
#'
#' @return a [tibble][tibble::tibble-package]
#' @export
tidy_summary <- function(x, ...) {
  UseMethod("tidy_summary")
}




#' @describeIn tidy_summary Tidies a summary reverse output from the
#'             \code{\link[Hmisc]{summary.formula}} called with
#'             \code{method = "reverse"}.
#'
#' @inheritParams tidy_summary
#' @importFrom magrittr %>%
#'
#' @note to see the options you can pass to \code{...} for a custom
#' print, see the print section in \code{\link[Hmisc]{summary.formula}}.
#'
#' @export
#' @examples
#'   library(Hmisc)
#'   my_summary <- summary(Species ~., data = iris, method = "reverse")
#'   tidy_summary(my_summary)
tidy_summary.summary.formula.reverse <- function(x, ...) {
  invisible(utils::capture.output(
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



#' @describeIn tidy_summary Convert the output of the
#'             \code{\link[rms]{summary.rms}} into a data frame,
#'             reporting only the Hazard Ratio with the .95 CI and the
#'             incremental step (for continuous variables) reference
#'             (for categorical variables) for which the Hazard is
#'             refered to (i.e. without \eqn{\beta}s, Low, High, S.E.
#'             and Type).
#'
#' @inheritParams tidy_summary
#' @param diff_digits number of significant digits to use (default 2)
#'        for the step-difference between continuous variable HR
#'        computation.
#'
#' @importFrom magrittr %>%
#'
#' @export
#'
#' @examples
#'   library(rms)
#'   options(dd = "datadist")
#'   n <- 1000
#'   set.seed(731)
#'   age <- 50 + 12*rnorm(n)
#'   sex <- factor(sample(c('Male','Female'), n,
#'       rep  = TRUE,
#'       prob = c(.6, .4)
#'   ))
#'   cens <- 15*runif(n)
#'   h <- .02*exp(.04*(age - 50) + .8*(sex == 'Female'))
#'   dt <- -log(runif(n))/h
#'   e <- ifelse(dt <= cens, 1, 0)
#'   dt <- pmin(dt, cens)
#'
#'   dd <- datadist(age, sex)
#'
#'   S <- survival::Surv(dt,e)
#'   f <- rms::cph(S ~ age + sex)
#'
#'
#'   my_summary <- summary(f)
#'   tidy_summary(my_summary)
tidy_summary.summary.rms <- function(x, diff_digits = 2, ...){

  as.data.frame(x) %>%
    tibble::as_tibble(rownames = ".rownames") %>%
    dplyr::mutate(.rownames = dplyr::lag(.rownames)) %>%
    dplyr::filter(Type == 2) %>%
    .[!names(.) %in% c("Low", "High", "S.E.", "Type")] %>%
  dplyr::mutate(
    Diff.     = round(Diff., digits = diff_digits),
    Diff.     = ifelse(!is.na(Diff.), Diff.,
                  stringr::str_extract(.rownames, '\\.\\.\\..*$') %>%
                  stringr::str_replace('\\.\\.\\.', '') %>%
                  stringr::str_replace('\\.', ':')
                ),
    .rownames = stringr::str_replace(.rownames, '\\.\\.\\..*$', '')
  ) %>%
  dplyr::rename(
    `&nbsp;`       = .rownames,
    `HR` = Effect,
    `Lower 95% CI`   = `Lower 0.95`,
    `Upper 95% CI`   = `Upper 0.95`
  )
}
