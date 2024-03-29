% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/stubs.R
\name{sourceMarkers}
\alias{sourceMarkers}
\title{Display source markers}
\usage{
sourceMarkers(
  name,
  markers,
  basePath = NULL,
  autoSelect = c("none", "first", "error")
)
}
\arguments{
\item{name}{The name of marker set. If there is a market set with this name
already being shown, those markers will be replaced.}

\item{markers}{An \R list, or data.frame, of source markers. See \strong{details}
for more details on the expected format.}

\item{basePath}{Optional. If all source files are within a base path, then
specifying that path here will result in file names being displayed as
relative paths. Note that in this case markers still need to specify source
file names as full paths.}

\item{autoSelect}{Auto-select a marker after displaying the marker set?}
}
\description{
Display user navigable source markers in a pane within RStudio.
}
\details{
The \code{markers} argument can contains either a list of marker lists or a
data frame with the appropriate marker columns. The fields in a marker are
as follows (all are required):

\tabular{ll}{
\code{type} \tab The marker type ("error", "warning", "info", "style", or "usage"). \cr
\code{file} \tab The path to the associated source file. \cr
\code{line} \tab The line number for the associated marker. \cr
\code{column} \tab The column number for the associated marker. \cr
\code{message} \tab A message associated with the marker at this location. \cr
}

Note the marker \code{message} can contain ANSI SGR codes for formatting.
The \code{cli} package can format text for style and color.
}
\note{
The \code{sourceMarkers} function was added in version 0.99.225 of
RStudio.
}
