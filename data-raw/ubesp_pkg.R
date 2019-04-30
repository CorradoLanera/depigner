ubesp_pkg <- c(
  "beepr", "blogdown", "bookdown", "caret", "caTools", "clisymbols",
  "clipr",  "covr", "crayon", "digest", "docopt", "DT", "foreach",
  "fortunes", "fs", "future", "glmnet", "here", "installr", "knitr",
  "lobstr", "Matrix", "pander", "parallel", "polynom", "profvis",
  "pryr", "RCurl", "rmarkdown", "rms", "roxygen2", "rvest", "shiny",
  "shinyjs", "slam", "snow", "SparseM", "spelling", "stats",
  "SuperLearner", "survival", "svDialogs", "testthat", "tidyverse",
  "tm", "usethis", "wavethresh", "xml2", "yaml"
)
devtools::use_data(ubesp_pkg, overwrite = TRUE)
