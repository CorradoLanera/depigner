test_that("single check works", {
  skip_on_cran()

  test_desc <- Hmisc::describe(mtcars)
  expect_false(is_single_hdesc(test_desc))
  expect_true(is_single_hdesc(test_desc[[1]]))
  expect_false(is_single_hdesc(mtcars))
})


test_that("original check works", {
  skip_on_cran()

  test_desc <- Hmisc::describe(mtcars)
  expect_true(is_hdesc(test_desc))
  expect_true(is_hdesc(test_desc[[1]]))
  expect_false(is_hdesc(mtcars))
})


test_that("cat check works", {
  skip_on_cran()

  test_desc <- Hmisc::describe(mtcars)
  expect_true(is_hcat(test_desc[["vs"]]))
  expect_false(is_hcat(test_desc[["mpg"]]))

  skip_if(as.integer(R.Version()$major) < 4)
  expect_error(is_hcat(test_desc), "must be a single")
})


test_that("original check works", {
  skip_on_cran()

  test_desc <- Hmisc::describe(mtcars)
  expect_false(is_hcon(test_desc[["vs"]]))
  expect_true(is_hcon(test_desc[["mpg"]]))

  test_nunique <- Hmisc::describe(airquality)
  expect_false(is_hcon(test_nunique[["Month"]]))
  expect_true(
    is_hcon(test_nunique[["Month"]], n.unique = 4)
  )

  skip_if(as.integer(R.Version()$major) < 4)
  expect_error(is_hcon(test_desc), "must be a single")
})


test_that("htype works", {
  skip_on_cran()

  test_desc <- Hmisc::describe(mtcars)
  expect_equal(htype(test_desc[["vs"]]), "cat")
  expect_equal(htype(test_desc[["mpg"]]), "con")
  expect_equal(htype(test_desc[["carb"]]), "none")
  expect_equal(
    htype(test_desc[["carb"]], n.unique = 4),
    "con"
  )

  skip_if(as.integer(R.Version()$major) < 4)
  expect_error(htype(test_desc), "must be a single")
})


test_that("htypes works", {
  skip_on_cran()

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
    htypes(test_desc)[order(names(htypes(test_desc)))],
    expected[order(names(expected))]
  )

  ## one at time
  expect_equal(htypes(test_desc[["mpg"]]), "con")
  expect_equal(htypes(test_desc[["vs"]]), "cat")
  expect_equal(htypes(test_desc[["cyl"]]), "none")

  ## input directly a data.frame
  expect_equal(
    htypes(mtcars)[order(names(htypes(test_desc)))],
    expected[order(names(expected))]
  )

  ## input a single vector
  # Note: `plot(describe(letters))` throws an error
  expect_equal(htypes(letters), "none")
})
