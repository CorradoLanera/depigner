#' Paired test for continuous variables
#'
#' Statistical tests for paired continuous variable.
#'
#' @details If the test is requested for two paired groups, the
#' \code{\link[stats]{t.test}} is used.
#'
#' If the test is requested for more than two groups, the test based on
#' ANOVA for repeated measures is used (powered by
#' \code{\link[stats]{aov}})
#'
#' @note This function could be used as `conTest` option in the
#' \code{\link[Hmisc]{summary.formula}} with method `reverse`.
#'
#'
#' @param group (fct) vector of groups
#' @param x (num) vector of observations. Note: lenght of `x` is
#'        considered equal to the number of subjects by the number of
#'        groups. Observation must be provided by subject
#'        (e.g. c(a1, b1, c1, a2, b2, c2, a3, b3, c3, a4, b4, c4), where
#'        the letters, a, b, c, and d represents the groups and the
#'        numbers represents the patien's ids). Note only patient with
#'        observation in all the levels considered will be used.
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
#'   library(Hmisc)
#'
#'   ## two groups
#'   summary(Species ~.,
#'       data    = iris[iris$Species != "setosa",],
#'       method  = "reverse",
#'       test    = TRUE,
#'       conTest = paired_test_continuous
#'   )
#'
#'   ## more than two groups
#'   summary(Species ~.,
#'       data    = iris,
#'       method  = "reverse",
#'       test    = TRUE,
#'       conTest = paired_test_continuous
#'   )
#'
#' ## without Hmisc
#' two_obs <- iris$Sepal.Length[iris$Species != "setosa"]
#' two_groups <- iris$Species[iris$Species != "setosa"]
#' paired_test_continuous(two_groups, two_obs)
#'
#' obs <- iris$Sepal.Length
#' many_groups <- iris$Species
#' paired_test_continuous(many_groups, obs)
paired_test_continuous <- function(group, x) {
  # Imput adjustment and checks -------------------------------------
  len_g <- length(group)
  len_x <- length(x)
  n_lev <- length(levels(group))


  if (len_g != len_x) {
    stop(paste(
      "The lenght of the variable group has to be the same of",
      "the lenght of the variable x. They aren't equal."
    ))
  }

  if (!is.factor(group)) {
    message(
      "Grouping variable converted to factor to compute test."
    )
    # explicit set levels to avoid reordering
    group <- factor(group, levels = unique(group))
  }


  # main constants --------------------------------------------------

  # x     <- sf.db$Circonferenza.braccio..cm.
  # group <- sf.db$Visita
  original_levels <- levels(group)


  # Recreate ids (if possible) --------------------------------------

  rle_g <- rle(as.integer(group))$lengths

  ids <- vector("integer", len_g)
  id  <- 0L

  if (length(rle_g) == length(original_levels)) {
    # this means that observation are sorted by group
    if (diff(range(rle_g)) >= .Machine$double.eps ^ 0.5) {
      warning(paste(
        "Data passed by groups and incomplete:\n",
        "    not same umber of observation among the groups.\n",
        "P returned is the standard F statistics.\n",
        "(9 is added to this P to identify the cases).\n\n"
      ))
      res <- Hmisc::conTestkw(group, x)
      res$P <- res$P + 9
      return(res)
    }
    # observation sorted by groups with the same length
    ids <- rep(seq_len(rle_g[[1]]), length(rle_g))
  }

  if (length(rle_g) != length(original_levels)) {
    # this means observation are sorted by ids
    for (i in seq_along(group)) {

      actual_lev <- which(original_levels == group[[i]])

      is_new_id <- (i == 1) ||
        (group[[i - 1]] %in% original_levels[actual_lev:n_lev])

      id <- id + is_new_id
      ids[[i]] <- id
    }
  }


  # main data frame creation ----------------------------------------

  data_db <- dplyr::tibble(ids, x, group) %>%
    dplyr::distinct() %>%
    tidyr::spread("group", "x") %>%
    janitor::remove_empty("cols") %>%
    ggplot2::remove_missing() %>%
    tidyr::gather("group", "x", -ids) %>%
    dplyr::mutate(group = factor(group,
                                 levels = original_levels[original_levels %in% unique(group)]
    )) %>%
    dplyr::arrange(ids, group)


  group_names <- levels(data_db$group)
  group_n     <- length(group_names)
  n_subjects  <- length(unique(data_db$ids))


  # Less Than Two groups --------------------------------------------

  if (group_n < 2 || n_subjects <= group_n) {

    # `return()` exits from the function here!
    return(list(
      # values (mandatory)
      P    = setNames(1, "P"),
      stat = setNames(Inf, "XXX"),
      df   = setNames(0, "df"),

      # names (mandatory)
      testname = "notestname",
      statname = "nostatname",
      namefun  = "nonamefun",

      # special labels (optional)
      note = "Only one group with data, no paired test is done."
    ))
  }


  # Two groups ------------------------------------------------------

  if (group_n == 2) {
    data_two <- data_db %>%
      tidyr::spread("group", "x")


    test_out <- t.test(data_two[[2]], data_two[[3]],
                       paired    = TRUE,
                       var.equal = TRUE
    )


    # `return()` exits from the function here!
    return(list(
      # values (mandatory)
      P    = c(P = test_out[["p.value"]]),
      stat = test_out[["statistic"]],
      df   = test_out[["parameter"]],

      # names (mandatory)
      testname = "Paired t-test",
      statname = "t",
      namefun  = "paired_tstat",

      # special labels (optional)
      latexstat    = "t_{df}",
      plotmathstat = "t[df]",
      note = "Two groups: t-test for paired values is done."
    ))
  }


  # More than two groups --------------------------------------------

  test_out <- summary(
    aov(x ~ group + Error(ids/group), data = data_db)
  )[["Error: Within"]][[1]]

  list(
    # values (mandatory)
    P    = setNames(test_out[1, "Pr(>F)"], "P"),
    stat = setNames(test_out[1, "F value"], "F"),
    df   = setNames(test_out[1, "Df"], "df"),

    # names (mandatory)
    testname = "Repeated-measure AOV",
    statname = "F",
    namefun  = "rep_aov",

    # special labels (optional)
    latexstat    = "F_{df}",
    plotmathstat = "F[df]",
    note = {
      "More than two groups: ANOVA for repeated measure is used."
    }
  )
}
