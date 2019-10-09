
<!-- README.md is generated from README.Rmd. Please edit that file -->

# acledr

<!-- badges: start -->

[![Travis build
status](https://travis-ci.com/andybega/acledr.svg?branch=master)](https://travis-ci.com/andybega/acledr)
[![Codecov test
coverage](https://codecov.io/gh/andybega/acledr/branch/master/graph/badge.svg)](https://codecov.io/gh/andybega/acledr?branch=master)
<!-- badges: end -->

The goal of acledr is to download and read ACLED event data with R.

ACLED provides two options for programmatic access: a API that allows
specific event queries, and several Excel data dump files for each of
region datasets, e.g. Africa. This package solely uses the data dump
files. Thus downloading the data means the entire dump files will be
downloaded. This might not be the most efficient method if you only need
data for a single country. In that case it’s maybe easier to point and
click the web API.

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

**acledr** downloads the ACLED continent data dump files to a local
directory. The download and read functions are setup by default to
consult the `acledr.data_dir` option for the location of that directory.
To make life easier, set that option in your `.Rprofile` file:

``` r
library("usethis")
usethis::edit_r_profile()
# add:
#
# # acledr data directory
# options(acledr.data_dir = "path/to/acled/data")
```

Then, to download and read all ACLED events into memory:

``` r
library("acledr")

download_acled()

events <- read_acled()
```

A sample of the event data is included in the package.

``` r
data("acled_sample")
str(acled_sample)
#> Classes 'tbl_df', 'tbl' and 'data.frame':    100 obs. of  30 variables:
#>  $ iso             : num  356 356 706 764 586 400 356 586 4 728 ...
#>  $ event_id_cnty   : chr  "IND56314" "IND45802" "SOM24963" "THA7029" ...
#>  $ event_id_no_cnty: num  56314 45802 24963 7029 25136 ...
#>  $ event_date      : Date, format: "2019-06-19" "2019-02-12" ...
#>  $ year            : num  2019 2019 2018 2010 2014 ...
#>  $ time_precision  : num  1 1 1 1 1 1 1 1 2 1 ...
#>  $ event_type      : chr  "Protests" "Protests" "Strategic developments" "Riots" ...
#>  $ sub_event_type  : chr  "Peaceful protest" "Peaceful protest" "Disrupted weapons use" "Violent demonstration" ...
#>  $ actor1          : chr  "Protesters (India)" "Protesters (India)" "Al Shabaab" "Rioters (Thailand)" ...
#>  $ assoc_actor_1   : chr  "DF: Dogra Front; Shiv Sena" "AJYCP: Asom Jatiyatabadi Yuva Chatra Parishad; Students (India)" NA "UDD: United Front for Democracy against Dictatorship" ...
#>  $ inter1          : num  6 6 2 5 6 5 6 1 2 1 ...
#>  $ actor2          : chr  NA NA NA "Military Forces of Thailand (2014-)" ...
#>  $ assoc_actor_2   : chr  NA NA NA NA ...
#>  $ inter2          : num  0 0 0 1 0 0 1 2 1 8 ...
#>  $ interaction     : num  60 60 20 15 60 50 16 12 12 18 ...
#>  $ region          : chr  "Southern Asia" "Southern Asia" "Eastern Africa" "South-Eastern Asia" ...
#>  $ country         : chr  "India" "India" "Somalia" "Thailand" ...
#>  $ admin1          : chr  "Jammu and Kashmir" "Assam" "Banadir" "Bangkok" ...
#>  $ admin2          : chr  "Jammu" "Sivasagar" "Daynile" "Bangkok" ...
#>  $ admin3          : logi  NA NA NA NA NA NA ...
#>  $ location        : chr  "Jammu" "Jhanji" "Mogadishu-Daynile" "Bangkok" ...
#>  $ latitude        : num  32.74 26.85 2.06 13.75 30.2 ...
#>  $ longitude       : num  74.9 94.5 45.3 100.5 71.5 ...
#>  $ geo_precision   : num  1 1 1 1 1 1 1 2 2 1 ...
#>  $ source          : chr  "Northlines" "Sentinel (India)" "Local Source" "US State Department" ...
#>  $ source_scale    : chr  "Subnational" "Subnational" "Other" "Other" ...
#>  $ notes           : chr  "On 19 Jun, DF and Shiv Sena activists staged a protest in Jammu city (J&K), against recent killings of security"| __truncated__ "On February 12, members of the Asom Jatiyatabadi Yuva Chatra Parishad (AJYCP) burnt the effigy of the Prime Min"| __truncated__ "Detonation: An IED prematurely detonates inside al Shabaab safe-house in Oodweyne, IVO Bangala Camp. Four kille"| __truncated__ "On 28 April 2010, 1 soldier was killed and 19 people were injured during a clash between UDD red shirts demonst"| __truncated__ ...
#>  $ fatalities      : num  0 0 4 1 0 0 0 20 9 0 ...
#>  $ timestamp       : num  1.56e+09 1.56e+09 1.57e+09 1.56e+09 1.57e+09 ...
#>  $ gwcode          : int  750 750 520 800 770 663 750 770 700 626 ...
```

### Country coverage start

An additional salient piece of information when trying to turn the raw
event data into time series or panel data for countries over time is the
country-specific coverage time range. E.g. there are not many ACLED
events for Romania, but nomially the coverage starts on 2018-01-01, and
thus if we want to turn a sparse set of events in Romania into a time
series, we should use 0 values back to 2018-01-01.

ACLED lists the country coverages in a [PDF document on their
website](https://www.acleddata.com/wp-content/uploads/dlm_uploads/2018/02/Country-and-Time-Period-coverage_updatedJune2019-1.pdf).
This is included in the package:

``` r
data("acled_coverage")
str(acled_coverage)
#> 'data.frame':    93 obs. of  3 variables:
#>  $ country: chr  "Afghanistan" "Albania" "Algeria" "Angola" ...
#>  $ gwcode : num  700 339 615 540 692 771 370 434 346 571 ...
#>  $ start  : Date, format: "2017-01-01" "2018-01-01" ...
```
