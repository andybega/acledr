
<!-- README.md is generated from README.Rmd. Please edit that file -->

# acledr

<!-- badges: start -->

<!-- badges: end -->

The goal of acledr is to download and read ACLED event data with R.

## Installation

Install from GitHub with:

``` r
library(remotes)
install_github("andybega/acledr")
```

<!--
You can install the released version of acledr from [CRAN](https://CRAN.R-project.org) with:

``` r
install.packages("acledr")
```
-->

## Example

This is a basic example which shows you how to solve a common problem:

``` r
library(acledr)

download_acled()

events <- read_acled()
```
