# depigner 0.3.2

# depigner 0.3.1


* Update `ubesp_pckg` (#4)
* Update `ubesp_pckg` (#5)

# depigner 0.3.0

* Introduce dependency from R >= 3.5 because of the package **mvtnorm**
  which is in the tree of **rms** and **Hmisc** and depends on the
  version of R 3.5.
* Moved **survival**, **rms** and **Hmisc** from Imports to Suggests
* Added `start_bot_for_chat()` function, `send_to_telegram()` generics
  with methods for string and ggplot plots, and not exported
  funcitonalities as a wrapers to the main funcitons of the
  **telegram.bot** package.
* Added tests to paired tests functions' tests
* remove dependencies from **vcd** package

# depigner 0.2.0

* added `paired_test_categorical()` function to implement paired test
  for categorical variable accordingly to the number of groups, in a 
  suitable way to be used in the **Hmisc** `summary()` with
  `method = "reverse"`.
* added `paired_test_continuous()` function to implement paired test
  for continuous variable accordingly to the number of groups, in a 
  suitable way to be used in the **Hmisc** `summary()` with
  `method = "reverse"`.

# depigner 0.1.0

* some variable names updated
* bug fixed in `summary_interact()`
* add some tests
* Added support for `tibble`s.
* Added `tidy_summary()` generics function and method for **Hmisc**
  `summary()` with `method = "reverse"`.

# depigner 0.0.2

* Fixed `summary_interact()` function.
* Added `gdp()` function.
* Added basic infrastrcture to the package.
