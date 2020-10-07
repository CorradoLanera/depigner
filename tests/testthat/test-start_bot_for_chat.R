test_that("stops on wrong chat name", {
  skip_if(!getOption("depigner.dev.test_telegram_bot"))
  skip_if(Sys.getenv("R_telegram_bot_name") != "clr_telegram_bot")

  start_bot_for_chat("Depigner test")

  expect_error(
    start_bot_for_chat("this chat will never exists"),
    "do not have a chat named"
  )

  options(depigner.bot = "")
  options(depigner.chat_id = "")
})


test_that("stops on wrong bot name", {
  skip_if(!getOption("depigner.dev.test_telegram_bot"))
  skip_if(Sys.getenv("R_telegram_bot_name") != "clr_telegram_bot")

  expect_error(
    start_bot_for_chat(bot_name = "this bot will never exists"),
    "Invalid token"
  )

  options(depigner.bot = "")
  options(depigner.chat_id = "")
})


test_that("setup options", {
  skip_if(!getOption("depigner.dev.test_telegram_bot"))
  skip_if(Sys.getenv("R_telegram_bot_name") != "clr_telegram_bot")

  start_bot_for_chat("Depigner test")

  expect_s3_class(getOption("depigner.bot"), "Bot")
  expect_equal(getOption("depigner.chat_id"), -414181402)

  options(depigner.bot = "")
  options(depigner.chat_id = "")
})
