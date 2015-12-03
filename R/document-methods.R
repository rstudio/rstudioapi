#' Create a Document Position
#'
#' Creates a \code{document_position}, which can be used to indicate e.g. the
#' row + column location of the cursor in a document.
#'
#' @param x An object coercable to \code{document_position}.
#' @param row The row (using 1-based indexing).
#' @param column The column (using 1-based indexing).
#'
#' @name document_position
#'
#' @export
#' @family location
document_position <- function(row, column) {
  structure(c(row = as.numeric(row), column = as.numeric(column)),
            class = "document_position")
}

#' @rdname document_position
#' @export
is.document_position <- function(x) {
  inherits(x, "document_position")
}

#' @name document_position
#' @export
as.document_position <- function(x) {
  UseMethod("as.document_position")
}

#' @export
as.document_position.document_position <- function(x) {
  x
}

#' @export
as.document_position.default <- function(x) {

  if (length(x) != 2 || !is.numeric(x))
    stop("'x' should be a numeric vector of length 2", call. = FALSE)

  document_position(row = x[[1]], column = x[[2]])
}

#' @export
format.document_position <- function(x, ...) {
  paste("[", paste(x, collapse = ", "), "]", sep = "")
}

#' @export
print.document_position <- function(x, ...) {
  cat("Document Position: ", format(x), "\n", sep = "")
}

#' Create a Range
#'
#' A \code{document_range} is a pair of \code{\link{document_position}} objects,
#' with each position indicating the \code{start} and \code{end} of the range,
#' respectively.
#'
#' @param x An object coercable to \code{document_range}.
#' @param start A \code{\link{document_position}} indicating the start of the
#'   range.
#' @param end A \code{\link{document_position}} indicating the end of the range.
#'
#' @return An \R \code{list} with class \code{document_range} and fields:
#'
#' \tabular{ll}{
#' \code{start:}\tab The start position.\cr
#' \code{end:}\tab The end position.\cr
#' }
#'
#' @name document_range
#'
#' @export
document_range <- function(start, end = NULL) {

  # Allow users to write e.g. 'document_range(c(1, 2, 3, 4))';
  # ie, ignore using the 'end' argument
  if (is.null(end)) {

    if (length(start) != 4 || !is.numeric(start))
      stop("invalid range specification", call. = FALSE)

    end <- start[3:4]
    start <- start[1:2]
  }

  structure(list(start = as.document_position(start),
                 end   = as.document_position(end)),
            class = "document_range")
}

#' @name document_range
#' @export
is.document_range <- function(x) {
  inherits(x, "document_range")
}

#' @name document_range
#' @export
as.document_range <- function(x) {
  UseMethod("as.document_range")
}

#' @export
as.document_range.document_range <- function(x) {
  x
}

#' @export
as.document_range.default <- function(x) {
  document_range(x)
}

#' @export
format.document_range <- function(x, ...) {
  startPos <- as.document_position(x$start)
  endPos   <- as.document_position(x$end)
  paste(format(startPos, ...), "--", format(endPos, ...))
}

#' @export
print.document_range <- function(x, ...) {
  cat("Document Range:",
      "\n- Start: ", format(x$start),
      "\n- End: ", format(x$end),
      "\n", sep = "")
}

as.document_selection <- function(x) {

  invalidMsg <- "'x' should be a list of {range, text} pairs"

  if (!is.list(x))
    stop(invalidMsg, call. = FALSE)

  result <- lapply(x, function(el) {

    named <- all(c("range", "text") %in% names(el))
    if (!named)
      stop(invalidMsg, call. = FALSE)

    list(
      range = as.document_range(el$range),
      text  = el$text
    )

  })

  structure(result, class = "document_selection")

}

formatSelection <- function(x) {
  vapply(x, FUN.VALUE = character(1), function(el) {
    rng <- format(el$range)
    txt <- formatText(el$text)
    paste(rng, ": '", txt, "'", sep = "")
  })
}

#' @export
print.document_selection <- function(x, ...) {

  cat("Document Selection:", sep = "")
  formatted <- formatSelection(x)
  lapply(formatted, function(el) {
    cat("\n- ", el, sep = "")
  })
  cat("\n", sep = "")
}

#' @export
print.document_context <- function(x, ...) {
  cat("Document Context: ",
      "\n- id:        '", x$id, "'",
      "\n- path:      '", x$path, "'",
      "\n- contents:  <", length(x$contents), " rows>",
      "\n", sep = "")
  print(x$selection)
}
