# version 0.9.0

## Overview

This submission add some packages to the "common" sets provided, and
adds a pipe-able function to view/open data frames in Excel in the
middle of a pipe chain. Minor improvements provided to the
documentation.

## Test environments

### provided by

-   modification of `usethis::use_tidy_github_actions()` (including
  R devel, releas, and oldrel on Ubuntu 20.04, and 22.04; R release and
  oldrel on win latest; R release on mac os)
-   `devtools::check()`
-   `devtools::check(remote = TRUE, manual = TRUE)`
-   `devtools::check_win_devel()`
-   `devtools::check_rhub(env_vars = c(R_COMPILE_AND_INSTALL_PACKAGES = "always"))`

### Configurations

-   local:

    -   Ububtu 22.04 LTS, R 4.2.3
    -   Windows 11 pro insider preview, R 4.2.3

-   remote:

    # -   MacOS 11.6.8: R 4.2.1 [GitHub Action]
    # -   Ubuntu Linux 20.04.4 LTS: R 4.2.1, r-devel, GCC [GitHub Action]
    # -   Fedora Linux, R-devel, clang, gfortran [rhub]
    # -   Windows 10.0.20348: R 4.2.1 [GitHub Action]
    -   Windows Server 2022 x64: R-devel, 64 bit [win_devel]

    
## R CDM check results

0 errors ✓ | 0 warnings ✓ | 0 notes ✓

### Notes

- There is one PREPERROR reported for Ubuntu Linux 20.04.1 LTS, R-release, GCC: with no explanation at all. Following the report ([HTML](https://builder.r-hub.io/status/depigner_0.9.0.tar.gz-02cc772fd32b4cf8996d9a99ad95ec46)) there aren't errors and the reported status is green: "passed". As noted in [R-hub issue #448](https://github.com/r-hub/rhub/issues/448), this could be due to a bug/crash r-hub reporting system (caused by a truncation of internal logs) and can likely be ignored.

- There is one NOTE that is only found on Windows Server 2022, R-devel 64-bit: A possible invalid url on the README.md (https://www.treccani.it/vocabolario/pigna/). I have checked the url and it is valid and active (20220930). (https://builder.r-hub.io/status/depigner_0.9.0.tar.gz-b614502f1b2b4a8d85d62cc9cec9c327#L2492)

- There is a NOTE that is only found in Fedora Linux, R-devel, clang, gfortran: 
  "Skipping checking HTML validation: no command 'tidy' found"
  "Skipping checking math rendering: package 'V8' unavailable".
  I do not have any "tidy" command on my documentation at all, and any equation neither; so, I suppose is only a system configuration lack that does not depend on my package.



# version 0.9.0

## Overview

This submission add some packages to the "common" sets provided, and
adds a pipe-able function to view/open data frames in Excel in the
middle of a pipe chain. Minor improvements provided to the
documentation.

## Test environments

### provided by

-   `usethis::use_tidy_github_actions()` (including Ubuntu 16.04,
      18.04, and 20.04)
-   `devtools::check()`
-   `devtools::check(remote = TRUE, manual = TRUE)`
-   `devtools::check_win_devel()`
-   `devtools::check_rhub(env_vars = c(R_COMPILE_AND_INSTALL_PACKAGES = "always"))`

### Configurations

-   local:

    -   Debian Bulseye (Linux 5.9.0), R 4.2.1
    -   Windows 11 workstation, R 4.2.1

-   remote:

    -   MacOS 11.6.8: R 4.2.1 [GitHub Action]
    -   Ubuntu Linux 20.04.4 LTS: R 4.2.1, r-devel, GCC [GitHub Action]
    -   Fedora Linux, R-devel, clang, gfortran [rhub]
    -   Windows 10.0.20348: R 4.2.1 [GitHub Action]
    -   Windows Server 2022: R-devel, 64 bit [rhub]

    
## R CDM check results

0 errors ✓ | 0 warnings ✓ | 0 notes ✓

### Notes

- There is one PREPERROR reported for Ubuntu Linux 20.04.1 LTS, R-release, GCC: with no explanation at all. Following the report ([HTML](https://builder.r-hub.io/status/depigner_0.9.0.tar.gz-02cc772fd32b4cf8996d9a99ad95ec46)) there aren't errors and the reported status is green: "passed". As noted in [R-hub issue #448](https://github.com/r-hub/rhub/issues/448), this could be due to a bug/crash r-hub reporting system (caused by a truncation of internal logs) and can likely be ignored.

- There is one NOTE that is only found on Windows Server 2022, R-devel 64-bit: A possible invalid url on the README.md (https://www.treccani.it/vocabolario/pigna/). I have checked the url and it is valid and active (20220930). (https://builder.r-hub.io/status/depigner_0.9.0.tar.gz-b614502f1b2b4a8d85d62cc9cec9c327#L2492)

- There is a NOTE that is only found in Fedora Linux, R-devel, clang, gfortran: 
  "Skipping checking HTML validation: no command 'tidy' found"
  "Skipping checking math rendering: package 'V8' unavailable".
  I do not have any "tidy" command on my documentation at all, and any equation neither; so, I suppose is only a system configuration lack that does not depend on my package.

```
* Found the following (possibly) invalid URLs:
URL: https://www.treccani.it/vocabolario/pigna/
From: README.md
Status: Error
Message: libcurl error code 35:
schannel: next InitializeSecurityContext failed: SEC_E_ILLEGAL_MESSAGE (0x80090326) - This error usually occurs when a fatal SSL/TLS alert is received (e.g. handshake failed). More detail may be available in the Windows System event log.
```

- There is one NOTE that is only found on Windows (Server 2022, R-devel 64-bit): 

```
* checking for detritus in the temp directory ... NOTE
Found the following files/directories:
  'lastMiKTeXException'
```
As noted in [R-hub issue #503](https://github.com/r-hub/rhub/issues/503), this could be due to a bug/crash in MiKTeX and can likely be ignored.








# version 0.8.4 (including required correction)

## Notes

This submission basically resolve some user-reported error, and
implement a wide refactoring of the code (converting `$` in `[[`
and implicit integers to explicit ones, and set default stricter
linters provided by `{lintr}`), and test suite (`{testthat}` 3ed).
Next, it improves some documentation (README, and examples), and error
messages.

## Test environments

### provided by

-   `usethis::use_tidy_github_actions()` (including Ubuntu 16.04,
      18.04, and 20.04)
-   `devtools::check()`
-   `devtools::check(remote = TRUE, manual = TRUE)`
-   `devtools::check_win_devel()`
-   `devtools::check_rhub(env_vars = c(R_COMPILE_AND_INSTALL_PACKAGES = "always"))

### Configurations

-   local:

    -   Debian Bulseye (Linux 5.9.0), R 4.0.3
    -   Windows 10 workstation, R 4.0.3

-   remote:

    -   MacOS 10.15.6: R 4.0.3 [GitHub Action]
    -   Ubuntu Linux 20.04 LTS: R 4.0.3, r-devel, GCC [GitHub Action]
    -   Fedora Linux, R-devel, clang, gfortran [rhub]
    -   Windows 10.0.17763: R 4.0.3 [GitHub Action]
    -   Windows Server 2008 R2 SP1: R-devel, 32/64 bit [rhub]

## R CDM check results

0 errors ✓ | 0 warnings ✓ | 0 notes ✓








# version 0.8.3 (including required correction)

## Notes

Other than other changes and improvements reported in the NEWS.md, this submission resolve the following issue:

    mail 2020-09-24 from Kurt Hornik <Kurt.Hornik@R-project.org>
    Dear maintainer,

    Please see the problems shown on
    <https://cran.r-project.org/web/checks/check_results_depigner.html>.

The reported problems were all solved updating an auxiliary function used only for the tests.

## Test environments

### provided by

-   usethis::use_tidy_github_actions() (including Ubuntu 16.04,
      18.04, and 20.04)
-   devtools::check()
-   devtools::check(remote = TRUE, manual = TRUE)
-   devtools::check_win_devel()
-   rhub::check_for_cran()

### Configurations

-   local:

    -   Ubuntu 20.04 LTS (Linux 5.4.0-48-generic), R 4.0.2
    -   Windows 10 workstation, R 4.0.2

-   remote:

    -   MacOS 10.15.6: R 4.0.2, R-devel
    -   Ubuntu Linux 16.04 LTS: R 4.0.2, R-oldrel, GCC
    -   Ubuntu Linux 18.04 LTS, 20.04 LTS: R 4.0.2, GCC
    -   Fedora Linux, R-devel, clang, gfortran
    -   Windows 10.0.17763: R 4.0.2
    -   Windows Server 2008 R2 SP1: R-devel, 32/64 bit

## R CDM check results

0 errors ✓ | 0 warnings ✓ | 0 notes ✓








# version 0.8.1

## Resubmission

### Second

-   Changed `installed.packages()` using `find.package()` to speed up the evaluation. In the `README`'s example, `installed.packages()` is still used because that example have to know all the names of the installed packages.

-   Changed `\dontrun{}` with `\donttest{}` in the examples which can "run" but should not be tested. Telegram's related examples and the `use_ui()` one still use `\dontrun{}` because they require special environments (Telegram configuration and package-like project) to be executed without errors.

> Note: on `rhub::check_for_cran()` an additional failure happen because of missing `{data.table}` (that is imported by `{Hmisc}` which is `library()`ed into some examples). On the other hand `{depigner}` never used `{data.table}`, hence I did not put it on Suggests neighter (note also that I tried to do so and the error persists anyway claiming that `{data.table}` has been required but not available). Anyway, I suppose it is an issue with the rhub environment: I get no error using [`devtools::check_win_devel()`](https://win-builder.r-project.org/7M0tU8X02QGt), nor locally (Debian 10 + Win 10), nor on [GitHub Actions](https://github.com/CorradoLanera/depigner/actions/runs/147626935) on win (release), ubuntu (oldrle + release), macOS (release).

### First

This is a resubmission. In this version I have not change anything:

The error:

    Found the following (possibly) invalid URLs:
      URL: https://elisasovrano.it
        From: README.md
        Status: Error
        Message: libcurl error code 6:
             Could not resolve host: elisasovrano.it

It was caused by the fact that <https://elisasovrano.it> had not yet been activated. It is now, and the link is working properly.

## Test environments

### provided by

-   usethis::use_tidy_github_actions()
-   devtools::check()
-   devtools::check(remote = TRUE, manual = TRUE)
-   devtools::check_win_devel()
-   rhub::check_for_cran()

### Configurations

-   local:

    -   Debian 10 (Linux 4.19.0), R 4.0.1
    -   Windows 10 pro, R 4.0.1

-   remote:

    -   MacOS 10.15.5: R 4.0.1, R-devel
    -   Ubuntu Linux 16.04 LTS: R 4.0.1, R-oldrel, GCC
    -   Fedora Linux, R-devel, clang, gfortran
    -   Windows 10.0.17763: R 4.0.1
    -   Windows Server 2008 R2 SP1: R-devel, 32/64 bit

## R CDM check results

0 errors ✓ | 0 warnings ✓ | 2 notes x

-   Possibly mis-spelled words in DESCRIPTION: Pigna (9:14) Pignas (2:49) pìn'n'a (9:22)

*Pigna* is the Italian word that gives the name to the package. *Pignas* would be the English-like plural for Pigna. *pìn'n'a* is the phonetic writing to know how to correctly pronunciate Pigna (given that it is not an English word).

-   This is a new release.

### Allert: isolate r-hub error

Error for lack of system dependencies on r-hub only for * Ubuntu Linux 16.04 LTS: R 4.0.1, GCC

With the same configuration called from a GitHub Action defined like in <https://github.com/r-lib/actions/blob/master/examples/check-full.yaml>, it succeded (<https://github.com/CorradoLanera/depigner/pull/14>).
