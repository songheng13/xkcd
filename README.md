
<!-- README.md is generated from README.Rmd. Please edit that file -->

# xkcd

<!-- badges: start -->
<!-- badges: end -->

The `xkcd` package provides an R interface to retrieve data about
[xkcd_comic](https://xkcd.com) from the xkcd JSON API. Most importantly,
you can view these comics in the RStudio plot window

## Installation

You can install the development version of xkcd from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("songheng13/xkcd")
```

## Usage

Given an xkcd comic number, the `xkcd()` function retrieves a JSON
object with metadata about the comic

``` r
library(xkcd)


first_comic <- xkcd(1)
plot(first_comic)
```

<img src="man/figures/README-example-1.png" width="100%" />
