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
  \item{file}{Optional; Path to the file to open)}
  \item{line}{Optional; integer specifying the line number on which to place the cursor}
  \item{column}{Optional; integer specifying the column number on which to place the cursor}
}

\details{
The \code{navigateToFile} opens a file in RStudio. If the file is already open, its tab or window is activated.

Once the file is open, the cursor is moved to the specified location. If the \code{file}
argument is empty (the default), then the file is the file currently in view if one exists.
If the \code{line} and \code{column} arguments are both equal to \code{-1L} (the default), then
the cursor position in the document that is opened will be preserved.

Note that if your intent is to navigate to a particular function within a file, you can also cause RStudio to navigate there by invoking \code{\link[utils]{View}} on the function, which has the advantage of falling back on deparsing if the file is not available.
}
