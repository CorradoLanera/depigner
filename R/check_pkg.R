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
    return(invisible())
  }

  update.packages(ask = FALSE)

  invisible(pkgs)
}


#' Check basic installed packages
#'
#' @param interested [chr] packages' name
#' @param dependencies do you want to install the dependencies?
#'
#' @importFrom utils data install.packages installed.packages menu
#' @importFrom utils update.packages
#' @return invisible character vector with missing package
#' @export
check_pkg <- function(interested = NULL, dependencies = TRUE) {
  if (is.null(interested)) {
    data("ubesp_pkg",
        package = "depigner",
        envir   = environment()
    )
    interested <- eval(parse(text = "ubesp_pkg"))
  }

  have   <- rownames(installed.packages())
  needed <- setdiff(interested, have)

  please_install(needed, dependencies = dependencies)
  invisible(needed)
}
