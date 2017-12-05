#' summary_interact
#'
#' @param model    A model from \code{\link[rms]{lrm}}
#' @param ref      A continuous variable for which we are interested in the
#'   estimation of the OR for the various level of interaction with a discrete
#'   variable interacting with it
#' @param discrete The discrete interacting variable
#' @param ref_min  Denominator continuous level for the Odds Ratio
#'   (i.e., the reference level), if NULL (the default)
#' @param ref_max  Numerator continuous level for the Odds Ratio
#'   (i.e., the target level)
#' @param level A character vector of levels to show. Default (NULL) means to
#' show all the possible levels for the discrete variable
#' @param digits number of significant digits to print. Default is 3
#'
#' Note: the \code{\link[rms]{datadist}} has to be defined for the data used in
#'  the model
#'
#' @importFrom rlang !!
#' @importFrom magrittr %>%
#'
#' @return A data frame
#' @seealso \code{\link[rms]{lrm}}, \code{\link[rms]{datadist}}
#'
#' @export
#'
#' @examples
#' library(rms)
#'   options(datadist = 'dd')
#'
#' data('transplant')
#'
#' transplant <- transplant[transplant[['event']] != 'censored', , drop = FALSE]
#' dd <- datadist(transplant)
#'
#' lrm_mod <- lrm(event ~ rcs(age, 3)*(sex + abo) + rcs(year, 3),
#'   data = transplant
#' )
#'
#' lrm_mod
#' summary(lrm_mod)
#' summary_interact(lrm_mod, age, sex)
#' summary_interact(lrm_mod, age, sex, ref_min = 60, ref_max = 80)
#' summary_interact(lrm_mod, age, sex, ref_min = 60, ref_max = 80, digits = 5L)
#'
#' summary_interact(lrm_mod, age, abo)
#' summary_interact(lrm_mod, age, abo, level = c('A', 'AB'))
summary_interact <- function(model, ref, discrete,
  ref_min  = NULL, ref_max = NULL,
  level    = NULL,
  digits   = 3L
) {

  if (!inherits(model, 'lrm')) stop('model has to inherits to lrm class')
  if (is.null(getOption('datadist'))) stop('datadist non defined')

  discrete      <- rlang::enquo(discrete)
  discrete_name <- rlang::quo_name(discrete)
  # print(level)

  ref <- rlang::enquo(ref)
  ref_name <- rlang::quo_name(ref)
  # print(ref_name)

  dd <- getOption('datadist') %>% as.name %>% eval
  if (!ref_name %in% names(dd[['limits']])) stop('ref isn\'t in datadist')
  if (!discrete_name %in% names(dd[['limits']])) stop('discrete isn\'t in datadist')


  if (is.null(ref_min))  { ref_min  <- dd[['limits']][[ref_name]][[1]]}
  if (is.null(ref_max))  { ref_max  <- dd[['limits']][[ref_name]][[3]]}
  if (is.null(level)) { level <- dd[['values']][[discrete_name]]}

  suppressWarnings(
    purrr::map_df(.x = level, ~ {
      interact <- .x
      eval(parse(text = glue::glue(
        'summary(model, {discrete_name} = interact, {ref_name} = c(ref_min, ref_max))'
      ))) %>%
        broom::tidy() %>%
        dplyr::mutate(.rownames = lag(.rownames)) %>%
        dplyr::filter(Type == 2) %>%
        dplyr::select(-Type, - S.E.) %>%
        dplyr::filter(.rownames == rlang::quo_name(ref)) %>%
        dplyr::mutate(
          Low       = ifelse(is.na(Diff.), NA, Low),
          High      = ifelse(is.na(Diff.), NA, High),
          Diff.     = ifelse(!is.na(Diff.), Diff.,
                             stringr::str_extract(.rownames, ' - .*$') %>%
                               stringr::str_replace(' - ', '')),
          .rownames = stringr::str_replace(.rownames, ' -+.*$', '')
        ) %>%
        dplyr::mutate(.rownames = glue::glue('{.rownames} - {interact}')) %>%
        dplyr::mutate_if(is.double, round, digits = digits) %>%
        dplyr::rename(
          `&nbsp;`     = .rownames,
          `Odds Ratio` = Effect
        )
    })
  )
}
