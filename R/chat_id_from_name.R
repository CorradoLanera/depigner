chat_id_from_name <- function(.title = NA) {

  if (is.null(getOption("depigner.bot"))) stop(
    "Bot not set up. Please run `prepare_telegram_bot` first"
  )

  bot_updates <- getOption("depigner.bot")$get_updates()
  bot_message <- purrr::map(bot_updates, "message")
  bot_chats   <- purrr::map_df(bot_message, ~ dplyr::tibble(
      id    = .x[["chat"]][["id"]],
      title = ifelse(is.null(.x[["chat"]][["title"]]),
        NA_character_,
        .x[["chat"]][["title"]]
      )
  ))


  if (is.na(.title)) {
    return(dplyr::filter(bot_chats, is.na(.title))[["id"]])
  }

  res <- dplyr::filter(bot_chats, title == .title)[["id"]] %>%
      unique()

  if (length(res) == 0) stop(glue::glue(
    "The chat name {.title} provided does not exist in the chat for ",
    "which your bot has access."
  ))

  res
}