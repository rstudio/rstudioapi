\name{version}
\alias{version}
\title{Return the current version of the RStudio api.}
\usage{
version()
}
\value{
A \code{\link{numeric_version}} which you can compare to a
string and get correct results.
}
\description{
Return the current version of the RStudio api.
}
\examples{
\donttest{
if (rstudio::version() < "0.98.100") {
  message("Your version of Rstudio is quite old")
}
}
}

