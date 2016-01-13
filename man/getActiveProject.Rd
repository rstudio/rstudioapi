\name{getActiveProject}
\alias{getActiveProject}
\title{
Path to Active RStudio Project
}
\description{
Returns the path to the currently active RStudio project.
}
\note{
The \code{getActiveProject} function was added in version 0.99.854 of RStudio.
}
\usage{
getActiveProject()
}

\value{
Returns a single element character vector with the path of the currently active RStudio project. Returns \code{NULL} if no project is active.
}

\examples{
\dontrun{
rstudioapi::getActiveProject()
}
}

