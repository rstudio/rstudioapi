# rstudioapi

[![Build Status](https://travis-ci.org/rstudio/rstudioapi.png?branch=master)](https://travis-ci.org/rstudio/rstudioapi)

The rstudioapi package is designed to make it easy to conditionally access the Rstudio API from CRAN packages, avoiding any potential problems with `R CMD check`.
The most important function is `rstudioapi::call(fname, ...)` which calls the specified API function with the supplied arguments.  It will throw an error if Rstudio isn't running, or the function isn't available. If you want to use a different function outside of Rstudio, use `rstudioapi::available()` to check if Rstudio is running, and `rstudioapi::exists()` to determine if it has the function you need.

This package contains a handful of useful wrapper functions to access the API. To see the functions that are currently available in the API, run `help(package = "rstudio")`