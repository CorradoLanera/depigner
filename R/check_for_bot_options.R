#' Check if a bot is set up
#'
#' \code{\link{check_for_bot_options}} check if a telegram bot and
#' corresponding chat, exist.
#'
#' @param bot a bot
#' @param chat_id  a chat id
#' @return invisible lgl indicating if check pass (TRUE) or not (FALSE)
check_for_bot_options <- function(chat_id, bot) {
  stop_to_warning_function <- function(what) {
    warning(glue::glue(
      "`{what}` is missing.
      Pass it directly to `send_message_to_telegram()` or
      set it up automatically by `start_bot_for_chat()`."
    ), call. = FALSE)

    return(invisible(FALSE))
  }

  is_bot_ok <- tryCatch(
    {
      force(bot)
      TRUE
    },
    error = function(e) stop_to_warning_function("bot")
  )

  is_chat_id_ok <- tryCatch(
    {
      force(chat_id)
      TRUE
    },
    error = function(e) stop_to_warning_function("chat id")
  )

  invisible(is_bot_ok & is_chat_id_ok)

}
