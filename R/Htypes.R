#' Checks for describe objects
#'
#' These two function are useful to test if an object is of class
#' [Hmisc][Hmisc::describe].
#'
#' @details In `Hmisc` both "single" `describe` objects and lists
#' of them are of class `describe`. In particular, even if
#' `Hmisc::describe()` results in a single variable description, it is
#'  directly the "single" `describe` object and not a list of them with
#'  only a single `describe` object included!
#'
#' `is_Hdesc()` test for general inheritance.
#'
#' @param x an object to test if it is of class `describe`.
#'
#' @return (lgl) is `x` (a single element or a general) `describe`
#'   object?
#'
#' @export
#'
#' @seealso [describe][Hmisc::describe]
#' @seealso [is_Hcat], [is_Hcon], [Htype], [Htypes]
#'
#' @examples
#' \dontrun{
#'   library(Hmisc)
#'   desc <- describe(mtcars)
#'
#'   is_Hdesc(desc) # TRUE
#'   is_Hdesc(desc[[1]]) # TRUE
#' }
is_Hdesc <- function(x) {
  class(x) == "describe"
}

#' @rdname is_Hdesc
#' @details `is_single_Hdesc()` test for single instance of a
#'   `describe` object.
#'
#' @export
#' @examples
#' \dontrun{
#'   is_single_Hdesc(desc) # FALSE
#'   is_single_Hdesc(desc[[1]]) # TRUE
#' }
is_single_Hdesc <- function(x) {
  (class(x) == "describe") && (class(x[[1L]]) != "describe")
}






#' Type's checks accordingly to [Hmisc] package
#'
#' These functions decide and report if a single variable represented by
#' a single instance of an `Hmisc`'s [describe][Hmisc::describe] object
#' will considered a categorical variable or a continuous one.
#'
#' @details  A "single" object of `Hmisc`'s [describe][Hmisc::describe]
#'   class represents a variable. When you plot and object of class
#'   [describe][Hmisc::describe] the plot function decide if it is a
#'   continuous variable or a categorical one to plot it in the
#'   correspond plot. It is also possible that the variable is not
#'   considered in none of that categories, in which case it will not be
#'   plotted at all.
#'
#'   These functions have been produced/deduced from reading the
#'   source code of `Hmisc`'s [plot][Hmisc::describe]. In particular,
#'   from the definition of the (two distinct) functions `f` defined
#'   within it (one for categorical variables and the other for
#'   continuous variables). Both lead to a possible execution of
#'   `warning("no categorical variable found")` or `warning("no
#'   continuous variable found")`. I tried to keep the same
#'   names/code/logic that I found there.
#'
#' @param x an instance of the class [describe][Hmisc::describe], in the
#'   cases of "singular" functions (ie `is_*()` or `Htype()`) it must
#'   be a single-variable [describe][Hmisc::describe] object.
#' @param n.unique (int, 10) the minimum number of distinct values a
#'   numeric variable must have before plot.describe uses it in a
#'   continuous variable plot.
#'
#' @return (chr) `Htype` returns one of "cat" (if `x` will be considered
#'   categorical), "con" (if `x` will be considered continuous), "none"
#'   (if `x` will be not considered categorical nor continuous, and
#'   hence it will be not plotted), or "both" (with a warning, if the
#'   variable will be considered both categorical and continuous. This
#'   would possibly never happen).
#'
#' @seealso [describe][Hmisc::describe],
#' @seealso [is_Hdesc], [is_single_Hdesc]
#' @seealso Gist with test and usage examples: https://bit.ly/Htype-gist
#'
#' @export
#' @examples
#' \dontrun{
#'   library(Hmisc)
#'   desc <- describe(mtcars)
#'
#'   Htype(desc[["vs"]]) # "cat"
#'   Htype(desc[["mpg"]]) # "con"
#'   Htype(desc[["cyl"]]) # "none"
#' }
Htype <- function(x, n.unique = 10) {
  is_con <- is_Hcon(x, n.unique = n.unique)
  is_cat <- is_Hcat(x)

  htype <- c("cat", "con")[c(is_cat, is_con)]

  if (length(htype) == 0) {
    return("none")
  }
  if (length(htype) == 1) {
    return(htype)
  }
  if (length(htype) == 2) {
    return({
      warning(
        "Strange behaviour: both cat and con! (this would never happen)"
      )
      "both"
    })
  }
}


#' @describeIn Htype Report types for multi-variables objects
#' @return (chr) character vector of the types identified by [Htype] for
#'   every variable represented in (each element of) `x`.
#' @export
Htypes <- function(x, n.unique = 10) {
  UseMethod("Htypes", x)
}

#' @rdname Htype
#' @method Htypes describe
#' @export
#' @examples
#' \dontrun{
#'   Htypes(desc) # c(
#'   #   mpg = "con", cyl = "none", disp = "con",
#'   #   hp = "con", drat = "con", wt = "con", qsec = "con",
#'   #   vs = "cat", am = "cat", gear = "none",
#'   #   carb = "none"
#'   # )
#' }
Htypes.describe <- function(x, n.unique = 10) {
  assert_is_h_desc(x)

  if (is_single_Hdesc(x)) {
    return(Htype(x, n.unique = n.unique))
  }
  vapply(x, Htype, FUN.VALUE = character(1))
}

#' @rdname Htype
#' @method Htypes default
#' @export
#' @examples
#' \dontrun{
#'   Htypes(mtcars) # Htypes(desc)
#'   Htypes(letters) # "none"
#' }
Htypes.default <- function(x, n.unique = 10) {
  Htypes(Hmisc::describe(x))
}

#' @describeIn Htype Check if a single-instance of a
#'   [describe][Hmisc::describe] object is categorical.
#' @return (lgl) `is_Hcat` returns TRUE if x will be considered
#'   categorical.
#'
#' @export
#' @examples
#' \dontrun{
#'   is_Hcat(desc[["vs"]]) # TRUE
#'   is_Hcat(desc[["mpg"]]) # FALSE
#' }
is_Hcat <- function(x) {
  assert_is_single_h_desc(x)

  s <- x$counts
  v <- x$values

  ok_counts <- ("Sum" %in% names(s)) && (as.numeric(s["Sum"]) > 0)
  ok_values <- is_val_freq_list(v) &&
    length(v$frequency) &&
    is.character(v$value) &&
    (length(v$value) <= 20)

  ok_counts || ok_values
}


#' @describeIn Htype Check if a single-instance of a
#'   [describe][Hmisc::describe] object is continuous.
#'
#' @return (lgl) `is_Hcon` returns TRUE if x will be considered
#'   continuous.
#' @export
#'
#' @examples
#' \dontrun{
#'   is_Hcon(desc[["vs"]]) # FALSE
#'   is_Hcon(desc[["mpg"]]) # TRUE
#' }
is_Hcon <- function(x, n.unique = 10) {
  assert_is_single_h_desc(x)

  s <- x$counts
  v <- x$values

  is_val_freq_list(v) &&
    ("distinct" %in% names(s)) &&
    (as.numeric(s["distinct"]) >= n.unique) &&
    (is.numeric(v$value) || Hmisc::testDateTime(v$value, "either"))
}
