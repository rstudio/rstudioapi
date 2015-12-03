#' Insert Text into a Document.
#'
#' Use this to change the contents of a document open in RStudio.
#'
#' @param location An object specifying the positions, or ranges, wherein
#'   text should be inserted. See \bold{Details} for more information.
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
#' @details
#' To operate on the current selection in a document, call \code{insertText()}
#' with only a text argument, e.g.
#'
#' \preformatted{
#'     insertText("# Hello\\n")
#'     insertText(text = "# Hello\\n")
#' }
#'
#' Otherwise, specify a (list of) positions or ranges, as in:
#'
#' \preformatted{
#'     # insert text at the start of the document
#'     insertText(c(1, 1), "# Hello\\n")
#'
#'     # insert text at the end of the document
#'     insertText(Inf, "# Hello\\n")
#'
#'     # comment out the first 5 rows
#'     pos <- Map(c, 1:5, 1)
#'     insertText(pos, "# ")
#'
#'     # uncomment the first 5 rows, undoing the previous action
#'     rng <- Map(c, Map(c, 1:5, 1), Map(c, 1:5, 3))
#'     insertText(rng, "")
#'
#' }
#'
#' @note
#' The \code{insertText} function was added with version 0.99.796 of RStudio.
#'
#' @export
#' @family Source Document Methods
insertText <- function(location, text, id = NULL) {
  callFun("insertText", location, text, id)
}

#' Set the Contents of a Document
#'
#' Set the contents of a document, deleting any other text existing in the
#' document previously.
#'
#' @param text The text to insert into the document.
#'
#' @param id The document id. When \code{NULL} or blank,
#'   the mutation will apply to the currently open, or last
#'   focused, RStudio document. Use the \code{id} returned
#'   from \code{\link{getActiveDocumentContext}()} to ensure
#'   that the operation is applied on the intended document.
#' @export
setDocumentContents <- function(text, id = NULL) {

  location <- document_range(
    document_position(1, 1),
    document_position(Inf, 1)
  )

  insertText(location, text, id)
}

#' Get the Active Document Context
#'
#' Returns information about the currently active
#' RStudio document.
#'
#' The \code{selection} field returns is a list of document selection objects.
#' A document selection is just a pairing of a document \code{range}, and the
#' \code{text} within that range.
#'
#' @note
#' The \code{getActiveDocumentContext} function was added with version 0.99.796
#' of RStudio.
#'
#' @return A \code{data.frame} with elements:
#' \tabular{ll}{
#' \code{id:}\tab The document ID.\cr
#' \code{path:}\tab The path to the document on disk.\cr
#' \code{contents:}\tab The contents of the document.\cr
#' \code{selection:}\tab A \code{list} of selections. See details for more information.\cr
#' }
#'
#' @export
#' @family Source Document Methods
getActiveDocumentContext <- function() {
  context <- callFun("getActiveDocumentContext")
  context$selection <- as.document_selection(context$selection)
  structure(context, class = "document_context")
}
