#' Title
#'
#' @param chat_name a
#' @param bot_name a
#'
#' @return a
#' @export
#'
#' @examples
#' \dontrun{
#'     library(depigner)
#'     errors_to_telegram()
#' }
errors_to_telegram <- function(
    chat_name = NA,
    bot_name  = getOption("depigner.bot_name")

) {
    stopifnot(interactive())

    if (is.null(getOption("depigner.bot"))) {
      start_bot_for_chat(chat_name, bot_name)
    }

    warn <- !is.null(x = op <- getOption("error"))

    telegram_error <- function() {
      msg <- function() .Internal(geterrmessage())
      send_to_telegram(msg())
    }

    original_error_handler <- getOption("error")

    new_error_handler <- function() {
      eval(telegram_error, parent.frame(2))
      eval(original_error_handler, parent.frame(2))
    }

    options(error = new_error_handler)

    if (warn) usethis::ui_warn(
        "Error handler is changed\nfrom: {op}\n to: {getOption('error')}"
    )

}
