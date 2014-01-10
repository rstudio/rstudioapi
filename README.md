# rstudioapi

[![Build Status](https://travis-ci.org/rstudio/rstudioapi.png?branch=master)](https://travis-ci.org/rstudio/rstudioapi)

The rstudioapi package is designed to make it easy to conditionally access the Rstudio API from CRAN packages, avoiding any potential problems with `R CMD check`. This package contains a handful of useful wrapper functions to access the API. To see the functions that are currently available in the API, run `help(package = "rstudio")`

# Example uses

```R
# rstudioapi is designed to never be attached to your search path.
# Always prefix function calls with rstudioapi::

# Returns T/F
rstudioapi::available()
# Returns error if not available
rstudioapi::check()

# Optional argument allows you to specify version requirement
rstudioapi::available("0.99")
rstudioapi::check("0.99")

# Call an rstudio function
rstudioapi::call("viewer", "http://localhost:8080")

# This will raise an error if rstudio is not running, or the function
# is not found. To run a different function if it's not available,
# use exists
if (rstudioapi::exists("viewer")) {
  rstudioapi::call("viewer", "http://localhost:8080")
} else {
  browseURL("http://localhost:8080")
}
```

# Installation

* Install the development version with `devtool::install_github("rstudio/rstudioapi")
`