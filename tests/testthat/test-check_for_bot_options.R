test_that("return correct output", {
  expect_equal(suppressWarnings(check_for_bot_options()), FALSE)

  expect_equal(suppressWarnings(check_for_bot_options(bot = 1)), FALSE)

  expect_equal(
    suppressWarnings(check_for_bot_options(chat_id = 1)),
    FALSE
  )

  expect_equal(
    suppressWarnings(check_for_bot_options(bot = 1, chat_id = 1)),
    TRUE
  )
})


test_that("return a Warning if false", {
  expect_warning(expect_warning(check_for_bot_options()))
  expect_warning(check_for_bot_options(bot = 1))
  expect_warning(check_for_bot_options(chat_id = 1))
})
