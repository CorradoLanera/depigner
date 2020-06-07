context("use_ui")

test_that("use_ui() requires a package", {
  scoped_temporary_project()
  expect_error(use_ui(),
    "designed to work with packages", class = "usethis_error"
  )
})
