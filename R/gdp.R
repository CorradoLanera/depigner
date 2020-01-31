#' GDP
#'
#' A wrapper to relax
#'
#' @param time [num] number of seconds needed to relax yourself
#'        (default = 4)
#' @param freq [num] rotating frequency (default = 0.05/s)
#'
#' @return invisible()
#' @export
#'
#' @examples
#' gdp()
gdp <- function(time = 4, freq = 0.05) {
  my_seq <- seq_len(time / freq)

  pb <- progress::progress_bar$new(
    format = "Please wait: :what :spin in corso...",
    total  = length(my_seq),
    clear  = TRUE,
    width  = 76
  )

  purrr::walk(my_seq, ~{
    pb$tick(tokens = list(what = "giramento di"))
    Sys.sleep(freq)
  })

  cat("\014")

  ui_done("Ahh... relaxed!")
  ui_todo("Now, feel free to continue working.")

  invisible("You are the power!")
}
