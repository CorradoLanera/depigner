test_that("assert_is_single_h_desc works", {
  skip_on_cran()
  test_desc <- Hmisc::describe(mtcars)

  expect_error(
    assert_is_single_h_desc(test_desc),
    "must be a single|is not TRUE"
  )
  expect_true(assert_is_h_desc(test_desc))

  expect_true(assert_is_single_h_desc(test_desc[[1]]))
  expect_true(assert_is_h_desc(test_desc[[1]]))
})


test_that("is_val_freq_list works", {
  expect_false(is_val_freq_list(integer()))
  expect_false(is_val_freq_list(integer(1)))
  expect_false(is_val_freq_list(list(a = 1, b = 2)))

  expect_true(
    is_val_freq_list(list(value = 1, frequency = 2))
  )
})


test_that("is_proper_matrix works", {
  expect_false(is_proper_matrix(1))
  expect_false(is_proper_matrix(matrix(c(1, 2))))
  expect_false(is_proper_matrix(matrix(c(1, 2), nrow = 1)))

  expect_true(is_proper_matrix(matrix(1:4, nrow = 2)))
})


test_that("empty_h_test works", {
  expect_warning(
    {out <- empty_h_test()},
    "not a proper matrix"
  )
  expect_is(out, "list")
  expect_equal(out[["P"]], NA)
})

test_that("fake_h_group_test works", {
  expect_warning(
    {out <- fake_h_group_test()},
    "Only one group"
  )
  expect_is(out, "list")
  expect_equal(out[["P"]], c(P = 1))
})
