context("use_ui")

test_that("use_ui() requires a package", {
  scoped_temporary_project()
  expect_error(use_ui(), "not an R package", class = "usethis_error")
})
