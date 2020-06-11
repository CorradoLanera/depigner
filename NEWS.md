# depigner 0.8.0

* Removed usethis interface for message startup to make it able to be
  suppressed
* added `imported_from()` function to get the list of imported packages
  by a package.
* changed interface to package installers and sets of packages.
  Introduced `pkg_*` sets, changed `check_pkg()` to `install_pkg_set()`,
  exported `please_install()`
* updated `README` including TOC and reordering the sections
* moved `fs` to Imports
* added dependencies from packages `lattice`, `survival`, `Formula`,
  which `Hmisc` depends on (require for checks).
* fix `{progress}` reference into `README`.
* isolate `use_ui` from unexported functions of `{usethis}` package.
* reformat `DESCRIPTION` purging some unused imports dependencies, and
  rewriting pkg title and description accordingly to the new
  corresponding entries in the `README`
* Fixed a typo in the call of the generic `tidy_summary()`, and refactor
  it `tidy_summary.summary.formula.reverse()` method.
 
# depigner 0.7.0

* Change compatibility requiring R3.6+ (because of package
  `{latticeExtra}`, required by `{Hmisc}`, which depends on it)
* Update gh-actions to tidy ones
* Update `README`

# depigner 0.6.1

* Switch to GH-action for CI
* Activate spellcheck
* Activate lint
* Activate gh-pages with pkgedown

# depigner 0.6.0

* update `README` including examples for all the exported functions
* Added `Htypes()`, `Htype()` and complementary functions and relative
  tests, to get/check when a variable is considered categorical or
  continuous by the `{Hmisc}` ecosystem.

# depigner 0.5.0

* Introduce `rlang::.data` to remove notes on CMD check for tidyeval 
  missing variables
* Update all the UIs to usethis' ones.
* Exported `ci2p()` (issue #6)
* Add `use_ui()` to add what is necessary to use the usethis' user
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
  functionalities as a wrappers to the main functions of the
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
* Added basic infrastructure to the package.
