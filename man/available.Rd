\name{available}
\alias{available}
\alias{check}
\title{Check if RStudio is running.}
\usage{
available(version_needed = NULL)

check(version_needed = NULL)
}
\arguments{
  \item{version_needed}{An optional version specification.
  If supplied, ensures that Rstudio is at least that
  version.}
}
\value{
\code{available} a boolean; \code{check} an error message
if Rstudio is not running
}
\description{
Check if RStudio is running.
}
\examples{
rstudioapi::available()
\dontrun{rstudioapi::check()}
}

