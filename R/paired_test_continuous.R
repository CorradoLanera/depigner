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
#'        groups. Observation can be provided by subject (e.g.
#'        c(a1, a2, a3, a4, b1, b2, b3, b4, c1, c2, c3, c4) or by group
#'        (e.g. c(a1, b1, c1, a2, b2, c2, a3, b3, c3, a4, b4, c4)).
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
#' ## two groups
#' summary(Species ~.,
#'     data    = iris[iris$Species != "setosa",],
#'     method  = "reverse",
#'     test    = TRUE,
#'     conTest = paired_test_continuous
#' )
#'
#' ## more than two groups
#' summary(Species ~.,
#'     data    = iris,
#'     method  = "reverse",
#'     test    = TRUE,
#'     conTest = paired_test_continuous
#' )
#'
#' ## without Hmisc
#' obs <- iris$Sepal.Length
#' many_groups <- iris$Species
#' paired_test_continuous(many_groups, obs)
#'
#' no_setosa <- iris$Species != "setosa"
#' obs_two    <- iris$Sepal.Length[no_setosa]
#' two_groups <- droplevels(iris$Species[no_setosa])
#' paired_test_continuous(two_groups, obs_two)
paired_test_continuous <- function(group, x) {


# Imput adjustment and checks -------------------------------------

    if (length(group) != length(x)) {
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

    group_names <- levels(group)
    group_n     <- length(group_names)
    n_subjects  <- length(x) / group_n
    subj_ids    <- rep(seq_len(n_subjects), group_n)

    if (n_subjects != as.integer(n_subjects)) {
        warning(paste(
            "The number of observations is not a multiple of",
            "the number of groups. Something wrong could be happen",
            "for in the computation of the number of subjects.\n",
            "Please, do not trust continuous variable tests."
        ))
    }


# Two groups ------------------------------------------------------

    if (group_n == 2) {
        test_out <- stats::t.test(
            x[group == group_names[[1]]],
            x[group == group_names[[2]]],
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
        stats::aov(x ~ group + Error(subj_ids/group))
    )[["Error: Within"]][[1]]

    list(
        # values (mandatory)
        P    = stats::setNames(test_out[1, "Pr(>F)"], "P"),
        stat = stats::setNames(test_out[1, "F value"], "F"),
        df   = stats::setNames(test_out[1, "Df"], "df"),

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
