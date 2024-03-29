% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/stubs.R
\name{sendToConsole}
\alias{sendToConsole}
\title{Send code to the R console}
\usage{
sendToConsole(code, execute = TRUE, echo = TRUE, focus = TRUE, animate = FALSE)
}
\arguments{
\item{code}{The \R code to be executed, as a character vector.}

\item{execute}{Boolean; should the code be executed after being submitted
to the console? If \code{FALSE}, \code{code} is submitted to the console but is
not executed.}

\item{echo}{Boolean; echo the code in the console as it is executed?}

\item{focus}{Boolean; focus the console after sending code?}

\item{animate}{Boolean; should the submitted code be animated, as if someone was typing it?}
}
\description{
Send code to the R console, and optionally execute it.
}
\note{
The \code{sendToConsole} function was added in version 0.99.787 of
RStudio.
}
\examples{

\dontrun{
rstudioapi::sendToConsole(".Platform", execute = FALSE, animate = TRUE)
}


}
