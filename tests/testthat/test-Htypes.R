testthat::test_that("original check works", {
  test_desc <- Hmisc::describe(mtcars)
  testthat::expect_false(is_single_Hdesc(test_desc))
  testthat::expect_true(is_single_Hdesc(test_desc[[1]]))
  testthat::expect_false(is_single_Hdesc(mtcars))
})


testthat::test_that("original check works", {
  test_desc <- Hmisc::describe(mtcars)
  testthat::expect_true(is_Hdesc(test_desc))
  testthat::expect_true(is_Hdesc(test_desc[[1]]))
  testthat::expect_false(is_Hdesc(mtcars))
})


testthat::test_that("original check works", {
  test_desc <- Hmisc::describe(mtcars)
  testthat::expect_true(is_Hcat(test_desc[["vs"]]))
  testthat::expect_false(is_Hcat(test_desc[["mpg"]]))
  testthat::expect_error(is_Hcat(test_desc), "must be a single")
})


testthat::test_that("original check works", {
  test_desc <- Hmisc::describe(mtcars)
  testthat::expect_false(is_Hcon(test_desc[["vs"]]))
  testthat::expect_true(is_Hcon(test_desc[["mpg"]]))
  testthat::expect_error(is_Hcat(test_desc), "must be a single")

  test_nunique <- Hmisc::describe(airquality)
  testthat::expect_false(is_Hcon(test_nunique[["Month"]]))
  testthat::expect_true(
    is_Hcon(test_nunique[["Month"]], n.unique = 4)
  )
})


testthat::test_that("Htypes works", {
  test_desc <- Hmisc::describe(mtcars)
  testthat::expect_equal(Htype(test_desc[["vs"]]), "cat")
  testthat::expect_equal(Htype(test_desc[["mpg"]]), "con")
  testthat::expect_equal(Htype(test_desc[["carb"]]), "none")
  testthat::expect_equal(
    Htype(test_desc[["carb"]], n.unique = 4),
    "con"
  )

  testthat::expect_error(Htype(test_desc), "must be a single")
})


testthat::test_that("Htypes works", {
  test_desc <- Hmisc::describe(mtcars)

  # Note: the following expectation was deduced from the output of
  #       `plot(test_desc)`.
  expected <- c(
    mpg = "con", disp = "con", hp = "con",
    drat = "con", wt = "con", qsec = "con",
    vs = "cat", am = "cat",
    cyl = "none", gear = "none", carb = "none"
  )

  ## all together
  # Note: `expect_setequal()` because the order would be probabily
  #       different.
  testthat::expect_equal(
    Htypes(test_desc)[order(names(Htypes(test_desc)))],
    expected[order(names(expected))]
  )

  ## one at time
  testthat::expect_equal(Htypes(test_desc[["mpg"]]), "con")
  testthat::expect_equal(Htypes(test_desc[["vs"]]), "cat")
  testthat::expect_equal(Htypes(test_desc[["cyl"]]), "none")

  ## input directly a data.frame
  testthat::expect_equal(
    Htypes(mtcars)[order(names(Htypes(test_desc)))],
    expected[order(names(expected))]
  )

  ## input a single vector
  # Note: `plot(describe(letters))` throws an error
  testthat::expect_equal(Htypes(letters), "none")
})


