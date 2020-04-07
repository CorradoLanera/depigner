# depigner 0.5.1

# depigner 0.5.0

* Introduce `rlang::.data` to remove notes on CMD check for tidyeval 
  missing variables
* Update all the UIs to usethis' ones.
* Exported `ci2p()` (issue #6)
* Add `use_ui()` to add what is nessary to use the usethis' user
  interfaces in a package.

# depigner 0.4.1

* Add `tick()` as a wrapper to update a progress bar
* Add `pb_len()` as a wrapper to `progress::progress_bar()` for a quick
  and ready to use progress bar with default options

# depigner 0.4.0

* Minor (warnings) fixes to the tests
* Add `adjust_p()` function to adjust the P-values from a
  `tidy_summary` summary using methods provided by `p.adjust()`.
* Add `errors_to_telegram()` function to automatically parrot all the
  error messages to a chat from a Telegram bot

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
