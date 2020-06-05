#' Please install
#'
#' A polite helper for installing and update packages (quite exactly) taken
#' from a function used by Hadley Wickham at
#' `RStudio::conf 2018 - San Diego`.
#'
#' @param pkgs character vector of package(s) to install
#' @param install_fun function to use for installing package(s)
#' @param ... further options for install_fun
#'
#' @return invisible
please_install <- function(pkgs, install_fun = install.packages, ...) {
  if (!length(pkgs)) {
    return(invisible())
  }

  if (!interactive()) {
    ui_stop("Please run in interactive session")
  }

  q_pkg_title <- "Do you agree to install the following packges?"
  q_pkg_tale <- "(among the corresponding dependencies)"

  ko_pkg <- ui_nope(c(q_pkg_title, paste("* ", pkgs), q_pkg_tale))


  if (ko_pkg) {
    return(invisible())
  }
  install_fun(pkgs, ...)


  q_upd_title <- "Ok to check and update all your packages?"
  ko_upd <- ui_nope(q_upd_title)

  if (ko_upd) {
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
      envir = environment()
    )
    interested <- eval(parse(text = "ubesp_pkg"))
  }

  have <- rownames(installed.packages())
  needed <- setdiff(interested, have)

  please_install(needed, dependencies = dependencies)
  invisible(needed)
}
