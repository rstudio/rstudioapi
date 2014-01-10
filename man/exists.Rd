\name{exists}
\alias{exists}
\alias{get}
\title{Exists/get for Rstudio functions}
\usage{
exists(name, ...)

get(name, ...)
}
\arguments{
  \item{name}{name of object to look for}

  \item{...}{other arguments passed on to
  \code{\link[base]{exists}} and \code{\link[base]{get}}}
}
\description{
These are specialised versions of \code{\link[base]{get}}
and \code{\link[base]{exists}} that look in the rstudio
package namespace. If Rstudio is not running, \code{exists}
will return \code{FALSE}, and \code{getRstudio} will raise
an error.
}
\examples{
rstudioapi::exists("viewer")
\dontrun{rstudioapi::exists("viewer")}
}

