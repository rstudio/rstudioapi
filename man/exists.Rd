\name{exists}
\alias{exists}
\alias{find}
\title{Exists/get for Rstudio functions}
\usage{
exists(name, version_needed = NULL, ...)

find(name, version_needed = NULL, ...)
}
\arguments{
  \item{name}{name of object to look for}

  \item{...}{other arguments passed on to
  \code{\link[base]{exists}} and \code{\link[base]{get}}}

  \item{version_needed}{An optional version specification.
  If supplied, ensures that Rstudio is at least that
  version. This is useful if function behaviour has changed
  over time.}
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

