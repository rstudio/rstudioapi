% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/document-methods.R
\name{primary_selection}
\alias{primary_selection}
\title{Extract the Primary Selection}
\usage{
primary_selection(x, ...)
}
\arguments{
\item{x}{A document context, or a selection.}

\item{...}{Optional arguments (currently ignored).}
}
\description{
By default, functions returning a document context will return a list of
selections, including both the 'primary' selection and also 'other'
selections (e.g. to handle the case where a user might have multiple cursors
active). Use \code{primary_selection()} to extract the primary selection.
}
