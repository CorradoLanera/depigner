roxygen_ns_append <- function(tag) {
  usethis:::block_append(
    glue::glue("{ui_value(tag)}"),
    glue::glue("#' {tag}"),
    path = proj_path(package_doc_path()),
    block_start = "## usethis namespace: start",
    block_end = "## usethis namespace: end",
    block_suffix = "NULL"
  )
}

roxygen_update <- function() {
  usethis::ui_todo("Run {ui_code('devtools::document()')} to update {ui_path('NAMESPACE')}")
  TRUE
}

check_uses_roxygen <- function(whos_asking) {
  force(whos_asking)

  if (uses_roxygen()) {
    return(invisible())
  }

  usethis::ui_stop(
    "
    Project {ui_value(project_name())} does not use roxygen2.
    {ui_code(whos_asking)} can not work without it.
    You might just need to run {ui_code('devtools::document()')} once, then try again.
    "
  )
}

uses_roxygen <- function(base_path = proj_get()) {
  desc::desc_has_fields("RoxygenNote", base_path)
}

