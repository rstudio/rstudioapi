\name{sourceMarkers}
\alias{sourceMarkers}
\title{
Display Source Markers
}
\description{
Display user navigable source markers in a pane within RStudio
}
\note{
The \code{sourceMarkers} function was added in version 0.99.225 of RStudio.
}
\usage{
sourceMarkers(name, markers, basePath = NULL,
              autoSelect = c("none", "first", "error")) 
}

\arguments{
  \item{name}{Name of marker set (will replace any markers of the same name previously shown)}
  \item{markers}{List or data frame containing source markers (see below for details on how to specify markers)}
  \item{basePath}{Optional. If all source files are within a base path then specifying that path here will result in file names being displayed as relative paths. Note that in this case markers still need to specify source file names as full paths.}
  \item{autoSelect}{Optional. Automatically select and drive focus to either the first marker or the first marker that is an error.}
}

\details{

The \code{markers} argument can contains either a list of marker lists or a data frame with the appropriate marker columns. The fields in a marker are as follows (all are required):

\tabular{ll}{
   \code{type} \tab Marker type ("error", "warning", "info", "style", or "usage")\cr
   \code{file} \tab Path to source file\cr
   \code{line} \tab Line number witin source file \cr
   \code{column} \tab Column number within line\cr
   \code{message} \tab Short descriptive message\cr
}

Note that if the \code{message} field is of class "html" (i.e. \code{inherits(message, "html") == TRUE}) then it's contents will be treated as HTML.

}

