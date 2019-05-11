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

    start_bot_for_chat(chat_name, bot_name)

    if (!is.null(x = op <- getOption("error"))) {
      usethis::ui_warn(
        "Error handler is changed\nfrom: {op}\n to: depigner::send_to_telegram(geterrmessage())"
      )
    }

    telegram_error <- function() {
      msg <- function() .Internal(geterrmessage())
      send_to_telegram(msg())
    }

    options(error = telegram_error)
}
