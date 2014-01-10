\name{call}
\alias{call}
\title{Call an Rstudio API function}
\usage{
call(fname, ...)
}
\arguments{
  \item{fname}{name of the Rstudio function to call.  See
  \code{help(package = "Rstudio")}. For a complete list of
  functions in the current API.}

  \item{...}{Other arguments passed on to the function}
}
\description{
This function will return an error if Rstudio is not
running, or the function is not available. If you want to
fall back to different behavour, use \code{\link{exists}}.
}
\examples{
if (rstudioapi::available()) {
  rstudioapi::call("versionInfo")
}
}

