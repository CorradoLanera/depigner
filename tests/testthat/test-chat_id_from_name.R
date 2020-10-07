test_that("it stops if bot is not setup", {
  expect_usethis_error(chat_id_from_name(), "bot")
})

test_that("it stops on inexistent chats name", {
  skip_if(!getOption("depigner.dev.test_telegram_bot"))
  skip_if(Sys.getenv("R_telegram_bot_name") != "clr_telegram_bot")

  start_bot_for_chat("Depigner test")

  expect_usethis_error(
    chat_id_from_name("this chat will never exists"),
    "does not exist"
  )
})


test_that("correct know id", {
  skip_if(!getOption("depigner.dev.test_telegram_bot"))
  skip_if(Sys.getenv("R_telegram_bot_name") != "clr_telegram_bot")

  start_bot_for_chat("Depigner test")
  expect_equal(chat_id_from_name("Depigner test"), -297554410)

  options(depigner.bot = "")
  options(depigner.chat_id = "")
})
