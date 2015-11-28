


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
#' Use this to change the contents of an open document.
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
#'   from \code{\link{getActiveDocumentContext()}} to ensure
#'   that the operation is applied on the intended document.
#'
#' @export
#' @family Source Document Methods
replaceRanges <- function(ranges, text, id = "") {
  callFun("replaceRanges", ranges, text, id)
}

#' Replace Selection within a Document
#'
#' Change the selection in a document.
#'
#' @param text A character vector, indicating what
#'   text should be inserted. This will be coerced
#'   into a length one character vector as with
#'   \code{paste(text, collapse = "\\n")}.
#'
#' @param id The document id. When \code{NULL} or blank,
#'   the mutation will apply to the currently open, or last
#'   focused, RStudio document. Use the \code{id} returned
#'   from \code{\link{getActiveDocumentContext()}} to ensure
#'   that the operation is applied on the intended document.
#'
#' @export
#' @family Source Document Methods
replaceSelection <- function(text, id = "") {
  callFun("replaceSelection", text, id)
}

#' Get the Active Document Context
#'
#' Returns information about the currently active
#' RStudio document.
#'
#' @return A \code{list} with elements:
#' \tabular{ll}{
#' \code{id:}\tab The document ID.\cr
#' \code{path:}\tab The path to the document on disk.\cr
#' \code{contents:}\tab The contents of the document.\cr
#' \code{selection:}\tab The contents of the current selection.\cr
#' \code{range:}\tab The coordinates of the current selection, as a four-element integer vector.
#' }
#'
#' @export
#' @family Source Document Methods
getActiveDocumentContext <- function() {
  callFun("getActiveDocumentContext")
}
