


#' @export
versionInfo <- function() {
  callFun("versionInfo")
}

#' @export
previewRd <- function(rdFile) {
  callFun("previewRd", rdFile)
}

#' @export
viewer <- function(url, height = NULL) {
  callFun("viewer", url, height = height)
}

#' @export
sourceMarkers <- function(name, markers, basePath = NULL,
                          autoSelect = c("none", "first", "error")) {
  callFun("sourceMarkers", name, markers, basePath, autoSelect)
}

#' @export
navigateToFile <- function(file, line = 1L, column = 1L) {
  callFun("navigateToFile", file, as.integer(line), as.integer(column))
}

#' Replace Text within a Document
#'
#' Use this to change the contents of a document open in RStudio.
#'
#' @param ranges A list of ranges. Each range is a four-element
#'   integer vector, defining a document range with coordinates:
#'
#'   \code{startRow, startColumn, endRow, endColumn}
#'
#' @param text A character vector, indicating what text should be
#'   inserted at each aforementioned range. This should either
#'   be length one (in which case, this text is applied to each
#'   range specified); otherwise, it should be the same length
#'   as the \code{ranges} list.
#'
#' @param id The document id. When \code{NULL} or blank,
#'   the mutation will apply to the currently open, or last
#'   focused, RStudio document. Use the \code{id} returned
#'   from \code{\link{getActiveDocumentContext}()} to ensure
#'   that the operation is applied on the intended document.
#'
#' @export
#' @family Source Document Methods
replaceRanges <- function(ranges, text, id = NULL) {
  id <- id %||% ""
  callFun("replaceRanges", ranges, text, id)
}

#' Replace Selection within a Document
#'
#' Replaces the contents of the currently active selection
#' in the document with id \code{id} with \code{text}.
#'
#' @param text A character vector, indicating what
#'   text should be inserted. This will be coerced
#'   into a length one character vector as with
#'   \code{paste(text, collapse = "\\n")}.
#'
#' @param id The document id. When \code{NULL} or blank,
#'   the mutation will apply to the currently open, or last
#'   focused, RStudio document. Use the \code{id} returned
#'   from \code{\link{getActiveDocumentContext}()} to ensure
#'   that the operation is applied on the intended document.
#'
#' @export
#' @family Source Document Methods
replaceSelection <- function(text, id = NULL) {
  id <- id %||% ""
  callFun("replaceSelection", text, id)
}

#' Get the Active Document Context
#'
#' Returns information about the currently active
#' RStudio document.
#'
#' @return A \code{data.frame} with elements:
#' \tabular{ll}{
#' \code{id:}\tab The document ID.\cr
#' \code{path:}\tab The path to the document on disk.\cr
#' \code{contents:}\tab The contents of the document.\cr
#' \code{selections:}\tab The \code{\link{selection}}s in the document. When the document has multiple selections active, the first selection listed is the primary, or main, selection.\cr
#' }
#'
#' @export
#' @family Source Document Methods
getActiveDocumentContext <- function() {
  callFun("getActiveDocumentContext")
}
