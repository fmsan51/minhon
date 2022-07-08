
<!-- README.md is generated from README.Rmd. Please edit that file -->

# minhon

<!-- badges: start -->

[![CRAN
status](https://www.r-pkg.org/badges/version/minhon)](https://CRAN.R-project.org/package=minhon)
<!-- badges: end -->

R package to translate text(s) with
[TexTra](https://mt-auto-minhon-mlt.ucri.jgn-x.jp/) WebAPI.

## Installation

You can install the development version of minhon like so:

``` r
devtools::install_github("fmsan51/minhon")
```

## Example

``` r
library(minhon)

# Use your API key, API secret and User ID
api_key <- "API_KEY"
api_secret <- "API_SECRET"
user_id <- "USER_ID"

token <- get_token(api_key, api_secret)

# English to Japanese
translate(
 "The quick brown fox jumps over the lazy dog",
 
 # Change this line to translate to/from other languages
 "https://mt-auto-minhon-mlt.ucri.jgn-x.jp/api/mt/generalNT_en_ja/",
 
 user_id,
 token
 )
```

You can store your API key, API secret and User ID as follows:

``` r
options(
  minhon.api_key = "API_KEY",
  minhon.api_secret = "API_SECRET",
  minhon.user_id = "USER_ID"
)

translate(
 "The quick brown fox jumps over the lazy dog",
 "https://mt-auto-minhon-mlt.ucri.jgn-x.jp/api/mt/generalNT_en_ja/"
 )
```
