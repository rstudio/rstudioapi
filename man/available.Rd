\name{available}
\alias{available}
\alias{check}
\title{Check if RStudio is running?}
\usage{
available()

check()
}
\value{
\code{isRstudio} a boolean; \code{checkRstudio} an error
message if Rstudio is not running
}
\description{
Check if RStudio is running?
}
\examples{
rstudioapi::available()
\donttest{rstudioapi::check()}
}

