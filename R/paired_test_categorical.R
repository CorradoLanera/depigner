#' Paired test for categorical variables
#'
#' Statistical tests for paired categorical variable.
#'
#' @details If the test is requested for two paired groups, the
#' \code{\link[stats]{mcnemar.test}} is used.
#'
#' If the test is requested for more than two paired groups, the test
#' based on Cochran-Mantel-Haenzen for repeated measures is used
#' (powered by \code{\link[stats]{mantelhaen.test}})
#'
#' @note This function could be used as `catTest` option in the
#' \code{\link[Hmisc]{summary.formula}} with method `reverse`.
#'
#'
#' @param tab a frequency table (an integer matrix)
#'
#' @return A list with components
#'         `P` (the computed P-value),
#'         `stat` (the test statistic, either t or F),
#'         `df` (degrees of freedom),
#'         `testname` (test name),
#'         `statname` (statistic name),
#'         `namefun` ("paired_tstat", "rep_aov"),
#'         `latexstat` (LaTeX representation of statname),
#'         `plotmathstat` (for R - the plotmath representation of
#'             `statname`, as a character string),
#'         `note` (contains a character string note about the test).
#' @export
#'
#' @examples
#' library(Hmisc)
#'
#' data(Arthritis)
#'
#' ## two groups
#' summary(Treatment ~ Sex,
#'     data    = Arthritis,
#'     method  = "reverse",
#'     test    = TRUE,
#'     catTest = paired_test_categorical
#' )
#'
#' ## more than two groups
#' summary(Improved ~ Sex,
#'     data    = Arthritis,
#'     method  = "reverse",
#'     test    = TRUE,
#'     catTest = paired_test_categorical
#' )
#'
paired_test_categorical <- function(tab) {


# input check -----------------------------------------------------

  if (!is.matrix(tab) || nrow(tab) < 2 || ncol(tab) < 2) {
    return(list(
      # values (mandatory)
      P    = NA,
      stat = NA,
      df   = NA,

      # names (mandatory)
      testname = "notestname",
      statname = "nostatname",
      namefun  = "nonamefun",

      # special labels (optional)
      note = "tab is not a proper matrix. No test is done"
    ))
  }


  rowcounts <- tab %*% rep(1, ncol(tab))
  tab <- tab[rowcounts > 0, ]
  if (!is.matrix(tab) || nrow(tab) < 2) {
    return(list(
      # values (mandatory)
      P    = NA,
      stat = NA,
      df   = NA,

      # names (mandatory)
      testname = "notestname",
      statname = "nostatname",
      namefun  = "nonamefun",

      # special labels (optional)
      note = "tab is not a proper matrix. No test is done"
    ))
  }


# due = McNemar ---------------------------------------------------

  if (nrow(tab) == 2 && ncol(tab) == 2) {
    mn_test <- mcnemar.test(tab)

    return(list(
      # values (mandatory)
      P    = mn_test$p.value,
      stat = mn_test$statistic,
      df   = mn_test$parameter,

      # names (mandatory)
      testname = "McNemar",
      statname = "Chi-square",
      namefun  = "mn_chisq",

      # special labels (optional)
      latexstat    = "\\mn-chi^{2}_{df}",
      plotmathstat = "mn-chi[df]^2"
    ))
  }


#  molti = glm ---------------------------------

  if (nrow(tab) > 2 || ncol(tab) > 2) {
    dimnames(tab) <- setNames(
      dimnames(tab),
      c("var_levels", "grouping_var")
    )

    group_id <- setNames(seq_along(colnames(tab)), colnames(tab))
    lev_id   <- setNames(seq_along(rownames(tab)), rownames(tab))

    tab_df <- dplyr::as_tibble(tab) %>%
      dplyr::mutate(
        lev_id   = lev_id[var_levels],
        group_id = group_id[grouping_var]
      ) %>%
      dplyr::group_by(grouping_var) %>%
      dplyr::mutate(prop = n/sum(n)) %>%
      dplyr::ungroup()

    st <- summary(glm(prop ~ var_levels*group_id,
      data   = tab_df,
      family = "quasibinomial"
    ))

    return(list(
      # values (mandatory)
      P    = setNames(st$coefficients["group_id", "Pr(>|t|)"], "P"),
      stat = setNames(st$coefficients["group_id", "t value"], "t"),
      df   = setNames(st$df.residual, "df"),

      # names (mandatory)
      testname = "t test for group in a GLM",
      statname = "t",
      namefun  = "glm_t_test",

      # special labels (optional)
      latexstat    = "\\t_{df}",
      plotmathstat = "t[df]^2",
      note = paste(
        "Overdispersed quasi-binomial GLM is fitted using both",
        "the ranked groups and the categorical covariate of interest.",
        "The test reported is the t test of the groups' coefficient."
      )
    ))
  }
}
