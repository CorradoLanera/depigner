.onAttach <- function(libname, pkgname) {
  packageStartupMessage(
    ui_line("Welcome to depigner: we are here to un-stress you!")
  )
}


.onLoad <- function(libname, pkgname) {

  op <- options()

  op.depigner <- list(
    depigner.dev.test_telegram_bot = FALSE,

    depigner.bot_name = NULL,
    depigner.chat_id  = NULL
  )

  toset <- !(names(op.depigner) %in% names(op))

  if (any(toset)) options(op.depigner[toset])

  invisible(TRUE)
}
