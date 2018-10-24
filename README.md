depigner: package of utilities for *pignas*.
================

<!-- README.md is generated from README.Rmd. Please edit that file -->

[![lifecycle](https://img.shields.io/badge/lifecycle-maturing-blue.svg)](https://www.tidyverse.org/lifecycle/#maturing)
[![CRAN
status](https://www.r-pkg.org/badges/version/depigner)](https://cran.r-project.org/package=depigner)
[![Travis build
status](https://travis-ci.org/CorradoLanera/depigner.svg?branch=master)](https://travis-ci.org/CorradoLanera/depigner)
[![Coverage
status](https://codecov.io/gh/CorradoLanera/depigner/branch/master/graph/badge.svg)](https://codecov.io/github/CorradoLanera/depigner?branch=master)

## Overview

This package collect usefull function frequently used at the Unit of
Biostatistics, Epidemiology and Public Health of the Department of
Cardiac, Thoracic and Vascular sciences at the university of Padova.

## Install

You can install the development version from
[GitHub](https://github.com/) with the following procedure:

``` r
# install.packages("devtools")
devtools::install_github("CorradoLanera/depigner")
```

## Provided function

  - **`summary_interact()`**: produce a data frame of OR (with the
    corresponding CI95%) for the interactions between different
    combination of a continuous variable (for which it is possible to
    define the reference and the target values) and (every or a
    selection of levels of) a categorical one in a logistic model
    provided by `lrm()` (from the `rms` package (Harrell, Jr.
2018)).

|          | Low | High | Diff. | Odds Ratio | Lower\_0.95 | Upper\_0.95 |
| :------: | :-: | :--: | :---: | :--------: | :---------: | :---------: |
| age - A  | 43  |  58  |  15   |   1.002    |    0.557    |    1.802    |
| age - B  | 43  |  58  |  15   |   1.817    |    0.74     |    4.463    |
| age - AB | 43  |  58  |  15   |   0.635    |    0.186    |    2.169    |
| age - O  | 43  |  58  |  15   |   0.645    |    0.352    |    1.182    |

## Provided data

None at the moment.

## Feature request

If you need some more features, please open an issue on
[github](https://github.com/CorradoLanera/depigner/issues).

## Bug reports

If you encounter a bug, please file a
[reprex](https://github.com/tidyverse/reprex) (minimal reproducible
example) on [github](https://github.com/CorradoLanera/depigner/issues).

## Code of Conduct

Please note that the ‘depigner’ project is released with a [Contributor
Code of Conduct](.github/CODE_OF_CONDUCT.md). By contributing to this
project, you agree to abide by its
terms.

<!--=========================================================================-->

## Reference

<div id="refs" class="references">

<div id="ref-R-rms">

Harrell, Jr., Frank E. 2018. *Rms: Regression Modeling Strategies*.
<https://CRAN.R-project.org/package=rms>.

</div>

</div>
