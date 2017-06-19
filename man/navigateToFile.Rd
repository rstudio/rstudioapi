\name{navigateToFile}
\alias{navigateToFile}
\title{
Navigate to File
}
\description{
Open a file in RStudio, optionally at a specified location.
}
\note{
The \code{navigateToFile} function was added in version 0.99.719 of RStudio.
}
\usage{
navigateToFile(file, line = -1L, column = -1L)
}

\arguments{
  \item{file}{Path to the file to open)}
  \item{line}{Optional; integer specifying the line number on which to place the cursor}
  \item{column}{Optional; integer specifying the column number on which to place the cursor}
}

\details{
The \code{navigateToFile} opens a file in RStudio. If the file is already open, its tab or window is activated.

Once the file is open, the cursor is moved to the specified location.

Note that if your intent is to navigate to a particular function within a file, you can also cause RStudio to navigate there by invoking \code{\link[utils]{View}} on the function, which has the advantage of falling back on deparsing if the file is not available.
}
