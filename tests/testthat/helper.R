## attempt to activate a project, which is nice during development
tryCatch(usethis::proj_set("."), error = function(e) NULL)

## If session temp directory appears to be, or be within, a project, there
## will be large scale, spurious test failures.
## The IDE sometimes leaves .Rproj files behind in session temp directory or
## one of its parents.
## Delete such files manually.
session_temp_proj <- proj_find(path_temp())

if (!is.null(session_temp_proj)) {
  rproj_files <- fs::dir_ls(session_temp_proj, glob = "*.Rproj")
  ui_line(c(
    "Rproj file(s) found at or above session temp dir:",
    paste0("* ", rproj_files),
    "Expect this to cause spurious test failures."
  ))
}

## putting `pattern` in the package or project name is part of our strategy for
## suspending the nested project check during testing
pattern <- "aaa"

scoped_temporary_project <- function(dir = fs::file_temp(pattern = pattern),
                                     env = parent.frame(),
                                     rstudio = FALSE) {
  scoped_temporary_thing(dir, env, rstudio, "project")
}

scoped_temporary_thing <- function(dir = fs::file_temp(pattern = pattern),
                                   env = parent.frame(),
                                   rstudio = FALSE,
                                   thing = c("package", "project")) {
  thing <- match.arg(thing)
  if (fs::dir_exists(dir)) {
    ui_stop("Target {ui_code('dir')} {ui_path(dir)} already exists.")
  }

  old_project <- usethis:::proj_get_()
  ## Can't schedule a deferred project reset if calling this from the R
  ## console, which is useful when developing tests
  if (identical(env, globalenv())) {
    ui_done("Switching to a temporary project!")
    if (!is.null(old_project)) {
      command <- paste0('usethis::proj_set(\"', old_project, '\")')
      ui_todo(
        "Restore current project with: {ui_code(command)}"
      )
    }
  } else {
    withr::defer({
        withr::with_options(
          list(usethis.quiet = TRUE),
          usethis::proj_set(old_project, force = TRUE)
        )
        old <- setwd(old_project)
        on.exit(setwd(old), add = TRUE)
        fs::dir_delete(dir)
      },
      envir = env
    )
  }

  withr::local_options(list(usethis.quiet = TRUE))
  switch(
    thing,
    package = usethis::create_package(dir,
      rstudio = rstudio, open = FALSE,
      check_name = FALSE
    ),
    project = usethis::create_project(dir, rstudio = rstudio, open = FALSE)
  )
  usethis::proj_set(dir)
  old <- setwd(dir)
  on.exit(setwd(old), add = TRUE)
  invisible(dir)
}

expect_usethis_error <- function(...) {
  expect_error(..., class = "usethis_error")
}
