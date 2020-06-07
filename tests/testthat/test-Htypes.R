test_that("single check works", {
  test_desc <- Hmisc::describe(mtcars)
  expect_false(is_single_Hdesc(test_desc))
  expect_true(is_single_Hdesc(test_desc[[1]]))
  expect_false(is_single_Hdesc(mtcars))
})


test_that("original check works", {
  test_desc <- Hmisc::describe(mtcars)
  expect_true(is_Hdesc(test_desc))
  expect_true(is_Hdesc(test_desc[[1]]))
  expect_false(is_Hdesc(mtcars))
})


test_that("cat check works", {
  test_desc <- Hmisc::describe(mtcars)
  expect_true(is_Hcat(test_desc[["vs"]]))
  expect_false(is_Hcat(test_desc[["mpg"]]))

  skip_if(as.integer(R.Version()$major) < 4)
  expect_error(is_Hcat(test_desc), "must be a single")
})


test_that("original check works", {
  test_desc <- Hmisc::describe(mtcars)
  expect_false(is_Hcon(test_desc[["vs"]]))
  expect_true(is_Hcon(test_desc[["mpg"]]))

  test_nunique <- Hmisc::describe(airquality)
  expect_false(is_Hcon(test_nunique[["Month"]]))
  expect_true(
    is_Hcon(test_nunique[["Month"]], n.unique = 4)
  )

  skip_if(as.integer(R.Version()$major) < 4)
  expect_error(is_Hcon(test_desc), "must be a single")
})


test_that("Htype works", {
  test_desc <- Hmisc::describe(mtcars)
  expect_equal(Htype(test_desc[["vs"]]), "cat")
  expect_equal(Htype(test_desc[["mpg"]]), "con")
  expect_equal(Htype(test_desc[["carb"]]), "none")
  expect_equal(
    Htype(test_desc[["carb"]], n.unique = 4),
    "con"
  )

  skip_if(as.integer(R.Version()$major) < 4)
  expect_error(Htype(test_desc), "must be a single")
})


test_that("Htypes works", {
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
  expect_equal(
    Htypes(test_desc)[order(names(Htypes(test_desc)))],
    expected[order(names(expected))]
  )

  ## one at time
  expect_equal(Htypes(test_desc[["mpg"]]), "con")
  expect_equal(Htypes(test_desc[["vs"]]), "cat")
  expect_equal(Htypes(test_desc[["cyl"]]), "none")

  ## input directly a data.frame
  expect_equal(
    Htypes(mtcars)[order(names(Htypes(test_desc)))],
    expected[order(names(expected))]
  )

  ## input a single vector
  # Note: `plot(describe(letters))` throws an error
  expect_equal(Htypes(letters), "none")
})
