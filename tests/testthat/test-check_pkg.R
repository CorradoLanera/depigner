context("test-check_pkg")

test_that("empty please_install()", {
  expect_null(please_install(character(0)))
})
