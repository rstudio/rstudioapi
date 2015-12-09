# rstudioapi

[![Build Status](https://travis-ci.org/rstudio/rstudioapi.png?branch=master)](https://travis-ci.org/rstudio/rstudioapi)

The `rstudioapi` package is designed to make it easy to conditionally access the
[RStudio](http://www.rstudio.com/) API from CRAN packages, avoiding any
potential problems with `R CMD check`. This package contains a handful of useful
wrapper functions to access the API. To see the functions that are currently
available in the API, run `help(package = "rstudio")`

# Example uses

```R
# rstudioapi is designed to never be attached to your search path.
# Always prefix function calls with rstudioapi::

# Returns T/F
rstudioapi::isAvailable()
# Returns error if not available
rstudioapi::verifyAvailable()

# Optional argument allows you to specify version requirement
rstudioapi::isAvailable("0.99")
rstudioapi::verifyAvailable("0.99")

# Call an rstudio function
rstudioapi::callFun("viewer", "http://localhost:8080")

# This will raise an error if rstudio is not running, or the function
# is not found. To run a different function if it's not available,
# use exists
if (rstudioapi::hasFun("viewer")) {
  rstudioapi::callFun("viewer", "http://localhost:8080")
} else {
  browseURL("http://localhost:8080")
}

# You can use find to get the function. Throws an error if the function
# does not exist.
rstudioapi::findFun("viewer")

# You can also check version in exists and find
rstudioapi::findFun("viewer", 0.99)
rstudioapi::hasFun("viewer", 0.99)
```

# Installation

* Install the development version with
`devtools::install_github("rstudio/rstudioapi")`.