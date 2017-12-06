depigner: package of utilities for *pignas*.
================

<!-- README.md is generated from README.Rmd. Please edit that file -->
Overview
--------

This package collect usefull function frequently used at the Unit of Biostatistics, Epidemiology and Public Health of the Department of Cardiac, Thoracic and Vascular sciences at the university of Padova.

Install and usage
-----------------

To install the development version (the only one for the moment) from GitHub:

``` r
# install.packages("devtools")
devtools::install_github("CorradoLanera/depigner")
```

Once the package is installed, simply load it

``` r
library(depigner)
```

Provided function
-----------------

-   **`summary_interact()`**: produce a data frame of OR (with the corresponding CI95%) for the interactions between different combination of a continuous variable (for which it is possible to define the reference and the target values) and (every or a selection of levels of) a categorical one in a logistic model provided by `lrm()` (from the `rms` package (Harrell, Jr. 2017)).

<table style="width:99%;">
<colgroup>
<col width="15%" />
<col width="8%" />
<col width="9%" />
<col width="11%" />
<col width="18%" />
<col width="18%" />
<col width="18%" />
</colgroup>
<thead>
<tr class="header">
<th align="center"> </th>
<th align="center">Low</th>
<th align="center">High</th>
<th align="center">Diff.</th>
<th align="center">Odds Ratio</th>
<th align="center">Lower.0.95</th>
<th align="center">Upper.0.95</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td align="center">age - A</td>
<td align="center">43</td>
<td align="center">58</td>
<td align="center">15</td>
<td align="center">1.002</td>
<td align="center">0.557</td>
<td align="center">1.802</td>
</tr>
<tr class="even">
<td align="center">age - B</td>
<td align="center">43</td>
<td align="center">58</td>
<td align="center">15</td>
<td align="center">1.817</td>
<td align="center">0.74</td>
<td align="center">4.463</td>
</tr>
<tr class="odd">
<td align="center">age - AB</td>
<td align="center">43</td>
<td align="center">58</td>
<td align="center">15</td>
<td align="center">0.635</td>
<td align="center">0.186</td>
<td align="center">2.169</td>
</tr>
<tr class="even">
<td align="center">age - O</td>
<td align="center">43</td>
<td align="center">58</td>
<td align="center">15</td>
<td align="center">0.645</td>
<td align="center">0.352</td>
<td align="center">1.182</td>
</tr>
</tbody>
</table>

Provided data
-------------

None at the moment.

Feature request
---------------

If you need some more features, please open an issue on [github](https://github.com/CorradoLanera/depigner/issues).

Bug reports
-----------

If you encounter a bug, please file a [reprex](https://github.com/tidyverse/reprex) (minimal reproducible example) on [github](https://github.com/CorradoLanera/depigner/issues).

<!--=========================================================================-->
Reference
---------

Harrell, Jr., Frank E. 2017. *Rms: Regression Modeling Strategies*. <https://CRAN.R-project.org/package=rms>.
