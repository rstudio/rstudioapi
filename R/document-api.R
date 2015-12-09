#' Modify the Contents of a Document
#'
#' Use these functions to modify the contents of a document open in RStudio.
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
#'
#' \code{location} should be a (list of) \code{\link{document_position}} or
#' \code{\link{document_range}} object(s), or numeric vectors coercable to
#' such objects.
#'
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
#'     modifyRange(rng, "")
#' }
#'
#' \code{modifyRange} is a synonym for \code{insertText}, but makes its intent
#' clearer when working with ranges, as performing text insertion with a range
#' will replace the text previously existing in that range with new text. For
#' clarity, prefer using \code{insertText} when working with
#' \code{\link{document_position}}s, and \code{modifyRange} when working with
#' \code{\link{document_range}}s.
#'
#' @note
#' The \code{insertText}, \code{modifyRange} and \code{setDocumentContents}
#' functions were added with version 0.99.796 of RStudio.
#'
#' @rdname document-mutation
#' @export
insertText <- function(location, text, id = NULL) {
  callFun("insertText", location, text, id)
}

#' @name document-mutation
#' @rdname document-mutation
#' @export
modifyRange <- insertText

#' @name document-mutation
#' @rdname document-mutation
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
#' The \code{selection} field returned is a list of document selection objects.
#' A document selection is just a pairing of a document \code{range}, and the
#' \code{text} within that range.
#'
#' @note
#' The \code{getActiveDocumentContext} function was added with version 0.99.796
#' of RStudio.
#'
#' @return A \code{list} with elements:
#' \tabular{ll}{
#' \code{id} \tab The document ID.\cr
#' \code{path} \tab The path to the document on disk.\cr
#' \code{contents} \tab The contents of the document.\cr
#' \code{selection} \tab A \code{list} of selections. See \bold{Details} for more information.\cr
#' }
#'
#' @export
getActiveDocumentContext <- function() {
  context <- callFun("getActiveDocumentContext")
  context$selection <- as.document_selection(context$selection)
  structure(context, class = "document_context")
}
