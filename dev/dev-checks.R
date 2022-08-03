## Before pushes
usethis::use_tidy_description()
spelling::spell_check_package()
spelling::update_wordlist()

## Before pull requests
devtools::check_man()
devtools::test()
# devtools::test() # from RStudio button too: non interactive session!
covr::report()

lintr::lint_package()
goodpractice::gp(
  checks = setdiff(
    goodpractice::all_checks(),
    "covr")
)

devtools::check()
# devtools::check() executed in non interactive session by gp().


## Before CRAN
devtools::build_readme()
devtools::check(remote = TRUE, manual = TRUE)
devtools::check_win_devel()

rhub_check <- devtools::check_rhub(
  # see: https://community.rstudio.com/t/r-hub-builder-there-is-no-package-called-utf8/65694
  env_vars = c(
    R_COMPILE_AND_INSTALL_PACKAGES = "always"
  )
)
rhub_check

devtools::release()
