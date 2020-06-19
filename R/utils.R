assert_is_single_h_desc <- function(x) {
  if (as.integer(R.Version()$major) < 4) {
    stopifnot(is_single_hdesc(x))
  } else {
    stopifnot(
      `x must be a single Hmisc::describe() object` =
        is_single_hdesc(x)
    )
  }
  invisible(TRUE)
}


assert_is_h_desc <- function(x) {
  if (as.integer(R.Version()$major) < 4) {
    stopifnot(is_hdesc(x))
  } else {
    stopifnot(
      `x must be an Hmisc::describe() object (or one of its elements)` =
        is_hdesc(x)
    )
  }
  invisible(TRUE)
}


is_val_freq_list <- function(x) {
  length(x) &&
    is.list(x) &&
    all(names(x) %in% c("value", "frequency"))
}


is_proper_matrix <- function(tab) {
  is.matrix(tab) && nrow(tab) >= 2 && ncol(tab) >= 2
}

empty_h_test <- function() {
  ui_warn("tab is not a proper matrix. No test is done")

  list(
    # values (mandatory)
    P = NA,
    stat = NA,
    df = NA,

    # names (mandatory)
    testname = "notestname",
    statname = "nostatname",
    namefun = "nonamefun",

    # special labels (optional)
    note = "tab is not a proper matrix. No test is done"
  )
}
