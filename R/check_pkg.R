#' Please install
#'
#' A polite helper for installing and update packages (quite exactly) taken
#' from a function used by Hadley Wickham at
#' `RStudio::conf 2018 - San Diego`.
#'
#' @param pkgs charachter vector of package(s) to install
#' @param install_fun fuction to use for installing package(s)
#' @param ... further options for install_fun
#'
#' @return invisible
please_install <- function(pkgs, install_fun = install.packages, ...) {
  if (length(pkgs) == 0) {
    return(invisible())
  }
  if (!interactive()) {
    stop("Please run in interactive session", call. = FALSE)
  }

  title_pkg <- paste0(
    "Ok to install these packges (among the corresponding dependencies)?\n",
    paste("* ", pkgs, collapse = "\n")
  )
  ok_pkg <- menu(c("Yes", "No"), title = title_pkg) == 1

  if (!ok_pkg) {
    return(invisible())
  }

  install_fun(pkgs, ...)

  title_upd <- "Ok to check and update all your packages?"
  ok_upd <- menu(c("Yes", "No"), title = title_upd) == 1

  if (!ok_upd) {
    return(invisible(pkgs))
  }

  update.packages(ask = FALSE)

  invisible(pkgs)
}

interested <- c(
  'testthat', 'rms', 'tidyverse', 'caret', 'janitor', 'glue', 'tm',
  'RTextTools', 'Matrix', 'SuperLearner', 'assertive', 'usethis',
  'parallel', 'snow', 'foreach', 'knitr', 'rmarkdown', 'pander', 'here',
  'installr', 'fortunes', 'beepr', 'RCurl', 'DT', 'covr', 'devtools',
  'rlang', 'roxygen2', 'stats', 'survival', 'yaml', 'docopt'
)

#' Check basic installed packages
#'
#' @return invisible character vector with missing package
#' @export
check_pkg <- function() {
  have   <- rownames(installed.packages())
  needed <- setdiff(interested, have)

  please_install(needed, dependencies = TRUE)
  invisible(needed)
}
