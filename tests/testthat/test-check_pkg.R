context("test-install_pkg_set")

test_that("empty please_install()", {

  expect_null(please_install(character(0)))

  if (!interactive()) {
    expect_error(please_install("stats"),
      "Please run in interactive session", class = "usethis_error"
    )
  }
})
