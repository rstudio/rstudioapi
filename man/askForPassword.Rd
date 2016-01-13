\name{askForPassword}
\alias{askForPassword}

\title{
Ask the user for a password interactively
}
\description{
Ask the user for a password interactively.
}
\note{
The \code{askForPassword} function was added in version 0.99.853 of RStudio.
}

\usage{
askForPassword(prompt)
}
\arguments{
  \item{prompt}{Single element character vector containing the prompt to be displayed}
}

\details{
RStudio also sets the global \code{askpass} option to the \code{rstudioapi::askForPassword} function so that it can be invoked in a front-end independent manner.
}

\examples{
\dontrun{
rstudioapi::askForPassword("Please enter your password")
}
}
