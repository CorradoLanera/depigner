test_that("adjust_p return the correct class", {
  skip_on_cran()

  adj <- Hmisc:::summary.formula(Species ~ .,
    data = iris,
    method = "reverse",
    test = TRUE
  ) %>%
    tidy_summary(prtest = "P") %>%
    adjust_p()

  expect_is(adj, "tidy_summary")
})

test_that("warning and return if test is not set", {
  skip_on_cran()

  expect_warning(
    no_test_adj <- Hmisc:::summary.formula(Species ~ .,
      data = iris,
      method = "reverse"
    ) %>%
      tidy_summary() %>%
      adjust_p()
  )

  expect_is(no_test_adj, "tidy_summary")
})
