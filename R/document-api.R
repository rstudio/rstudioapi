#' Interact with Documents open in RStudio
#'
#' Use these functions to interact with documents open in RStudio.
#'
#' @param location An object specifying the positions, or ranges, wherein text
#'   should be inserted. See \bold{Details} for more information.
#'
#' @param text A character vector, indicating what text should be inserted at
#'   each aforementioned range. This should either be length one (in which case,
#'   this text is applied to each range specified); otherwise, it should be the
#'   same length as the \code{ranges} list.
#'
#' @param id The document id. When \code{NULL} or blank, the requested operation
#'   will apply to the currently open, or last focused, RStudio document.
#'
#' @param position The cursor position, typically created through
#'   \code{\link{document_position}()}.
#'
#' @param ranges A list of one or more ranges, typically created
#'   through \code{\link{document_range}()}.
#'
#' @param type The type of document to be created.
#'
#' @param execute Should the code be executed after the document
#'   is created?
#'   
#' @param allowConsole Allow the pseudo-id `#console` to be returned, if the \R
#'   console is currently focused? Set this to `FALSE` if you'd always like to
#'   target the currently-active or last-active editor in the Source pane.
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
#' The \code{setCursorPosition} and \code{setSelectionRanges} functions were
#' added with version 0.99.1111 of RStudio.
#'
#' The \code{documentSave} and \code{documentSaveAll} functions were added
#' with version 1.1.287 of RStudio.
#' 
#' The \code{documentId} and \code{documentPath} functions were added with
#' version 1.4.843 of RStudio.
#'
#' @name rstudio-documents
NULL

#' @name rstudio-documents
#' @export
insertText <- function(location = NULL,
                       text = NULL,
                       id = NULL)
{
  # unfortunate gymnastics needed for older versions of RStudio
  if (getVersion() < "1.4")
  {
    if (is.null(location) && is.null(text))
    {
      callFun("insertText",
              id = id)
    }
    else if (is.null(location))
    {
      callFun("insertText",
              text = text,
              id = id)
    }
    else if (is.null(text))
    {
      callFun("insertText",
              location = location,
              id = id)
    }
    else
    {
      callFun("insertText",
              location = location,
              text = text,
              id = id)
    }
  }
  else
  {
    callFun("insertText",
            location = location,
            text = text,
            id = id)
  }
}

#' @name rstudio-documents
#' @export
modifyRange <- insertText

#' @name rstudio-documents
#' @export
setDocumentContents <- function(text, id = NULL) {

  location <- document_range(
    document_position(1, 1),
    document_position(Inf, 1)
  )

  insertText(location, text, id)
}

#' @name rstudio-documents
#' @export
setCursorPosition <- function(position, id = NULL) {
  callFun("setSelectionRanges", position, id)
}

#' @name rstudio-documents
#' @export
setSelectionRanges <- function(ranges, id = NULL) {
  callFun("setSelectionRanges", ranges, id)
}

#' @name rstudio-documents
#' @export
documentId <- function(allowConsole = TRUE) {
  callFun("documentId", allowConsole = allowConsole)
}

#' @name rstudio-documents
#' @export
documentPath <- function(id = NULL) {
  path <- callFun("documentPath", id = id)
  Encoding(path) <- "UTF-8"
  path
}

#' @name rstudio-documents
#' @export
documentSave <- function(id = NULL) {
  callFun("documentSave", id)
}

#' @name rstudio-documents
#' @export
documentSaveAll <- function() {
  callFun("documentSaveAll")
}

#' Retrieve Information about an RStudio Editor
#'
#' Returns information about an RStudio editor.
#'
#' The \code{selection} field returned is a list of document selection objects.
#' A document selection is just a pairing of a document \code{range}, and the
#' \code{text} within that range.
#'
#' @note
#' The \code{getActiveDocumentContext} function was added with version 0.99.796
#' of RStudio, while the \code{getSourceEditorContext} and the \code{getConsoleEditorContext}
#' functions were added with version 0.99.1111.
#'
#' @return A \code{list} with elements:
#' \tabular{ll}{
#' \code{id} \tab The document ID.\cr
#' \code{path} \tab The path to the document on disk.\cr
#' \code{contents} \tab The contents of the document.\cr
#' \code{selection} \tab A \code{list} of selections. See \bold{Details} for more information.\cr
#' }
#' 
#' @param id The ID of a particular document, as retrieved by `documentId()`
#'   or similar. Supported in RStudio 2022.06.0 or newer.
#'
#' @rdname rstudio-editors
#' @name rstudio-editors
#' @export
getActiveDocumentContext <- function() {
  getDocumentContext("getActiveDocumentContext")
}

#' @name rstudio-editors
#' @export
getSourceEditorContext <- function(id = NULL) {
  getDocumentContext("getSourceEditorContext", id)
}

#' @name rstudio-editors
#' @export
getConsoleEditorContext <- function() {
  getDocumentContext("getConsoleEditorContext")
}

#' @note The \code{documentNew} function was introduced in RStudio 1.2.640.
#'
#' @name rstudio-documents
#' @export
documentNew <- function(
  text,
  type = c("r", "rmarkdown", "sql"),
  position = document_position(0, 0),
  execute = FALSE)
{
  type <- match.arg(type)
  callFun("documentNew", type, text, position[1], position[2], execute)
}

#' @param path The path to the document.
#' @param line The line in the document to navigate to.
#' @param col The column in the document to navigate to.
#' @param moveCursor Boolean; move the cursor to the requested location after
#'   opening the document?
#'
#' @note The \code{documentOpen} function was introduced in RStudio 1.4.1106.
#'
#' @name rstudio-documents
#' @export
documentOpen <- function(
    path,
    line = -1L,
    col = -1L,
    moveCursor = TRUE)
{
  path <- normalizePath(path, winslash = "/", mustWork = TRUE)
  callFun("documentOpen", path, line, col, moveCursor)
}

#' @param save Whether to commit unsaved changes to the document before closing it.
#'
#' @note The \code{documentClose} function was introduced in RStudio 1.2.1255
#'
#' @details
#'
#' \code{documentClose} accepts an ID of an open document rather than a path.
#' You can retrieve the ID of the active document using the \code{documentId()}
#' function.
#'
#' Closing is always done non-interactively; that is, no prompts are given to
#' the user. If the user has made changes to the document but not saved them,
#' then the \code{save} parameter governs the behavior: when \code{TRUE},
#' unsaved changes are committed, and when \code{FALSE} they are discarded.
#'
#' @name rstudio-documents
#' @export
documentClose <- function(id = NULL, save = TRUE) {
  callFun("documentClose", id, save)
}
