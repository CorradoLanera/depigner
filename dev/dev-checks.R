## Before pushes
usethis::use_tidy_description()
spelling::spell_check_package()
spelling::update_wordlist()

## Before pull requests
devtools::test()
# devtools::test() # from RStudio button too: non interactive session!
covr::report()

lintr::lint_package()
goodpractice::gp()

devtools::check()
# devtools::check() # from RStudio button too: non interactive session!


## Befor CRAN
devtools::build_readme()
devtools::check(remote = TRUE, manual = TRUE)
devtools::check_win_devel()
cran_prep <- rhub::check_for_cran()