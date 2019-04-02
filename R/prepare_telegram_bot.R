#' Set up a Telegram bot
#'
#' Produce a side effect to assign to the Global Environment two hidden
#' object for the bot and its chat_id
#'
#' @param bot_name (chr, NULL) This argument should be left NULL. If
#'     NULL, the function bring the bot name from the environmental
#'     variable "R_telegram_bot_name". You can pass your bot's name
#'     here as a character string too.
#'
#' @param chat_id (chr, NULL) This argument could be left NULL. If NULL,
#'     the funciton bring the first chat id from the ones used by the
#'     bot.
#'
#' @return invisibly a list with the bot name and the chat_id used.
#' @export
#'
#' @examples
#' \dontrun{
#'     library(depigner)
#'     prepare_telegram_bot()
#' }
prepare_telegram_bot <- function(bot_name = NULL, chat_id = NULL) {

  if (is.null(bot_name)) {
    if (Sys.getenv("R_telegram_bot_name") == "") {
      stop(paste(
        ".Renviron variable 'R_telegram_bot_name' is required if",
        "`bot_name` argument is provided directly from the user.\n",
        "Please, setup it or pass the name of your bot directly to",
        "`prepare_telegram_bot()`"
      ), call. = FALSE)
    }
    bot_name <- Sys.getenv("R_telegram_bot_name")
    message(
      "bot name taken from the .Renviron variable `R_telegram_bot_name`"
    )
  }

  bot <- telegram.bot::Bot(token = telegram.bot::bot_token(bot_name))

  if (is.null(chat_id)) {
    chat_id <- tryCatch(
      bot$get_updates()[[1]][["message"]][["chat_id"]],

      error = function(e) stop(
        "Chat ID of the bot seams not to exists.\n",
        "Heve you setup ultimated the bot setup?",
        call. = FALSE
      )
    )

    message(glue::glue(
      "Chat ID taken from the first {bot_name} chat"
    ))
  }


  assign(".depigner_bot",     value = bot,     pos = ".GlobalEnv")
  assign(".depigner_chat_id", value = chat_id, pos = ".GlobalEnv")

  warning(
    "This function assigned values to the following invisibles:\n",
    "`.depigner_bot`, and `.depigner_chat_id`.",
    call. = FALSE
  )

  invisible(list(bot_name = bot_name, chat_id = chat_id))
}
