\name{existsRstudio}
\alias{existsRstudio}
\alias{getRstudio}
\title{Exists/get for Rstudio functions}
\usage{
existsRstudio(name, ...)

getRstudio(name, ...)
}
\arguments{
  \item{name}{name of object to look for}

  \item{...}{other arguments passed on to
  \code{\link{exists}} and \code{\link{get}}}
}
\description{
These are specialised versions of \code{\link{get}} and
\code{\link{exists}} that look in the rstudio package
namespace. If Rstudio is not running, \code{existsRstudio}
will return \code{FALSE}, and \code{getRstudio} will raise
an error.
}
\examples{
existsRstudio("viewer")
\donttest{existsRstudio("viewer")}
}

