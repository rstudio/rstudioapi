#' Create a Position
#'
#' Creates a \code{position}, which can be used to indicate
#' e.g. the row + column location of the cursor in a document.
#'
#' The values \code{-Inf} and \code{Inf} can be used to indicate
#' the 'first' or 'last' row / column, depending on which document
#' the position is applied to.
#'
#' @param row The row (using 1-based indexing).
#' @param column The column (using 1-based indexing).
#'
#' @export
#' @family location
makePosition <- function(row, column) {
  structure(c(as.numeric(row), as.numeric(column)),
            class = "position")
}

#' @export
is.position <- function(x) {
  inherits(x, "position")
}

#' @export
as.position <- function(x) {
  if (is.position(x))
    return(x)

  if (length(x) != 2 || !is.numeric(x))
    stop("'x' should be a numeric vector of length 2", call. = FALSE)

  makePosition(row = x[[1]], column = x[[2]])
}

formatPosition <- function(pos, open = "[", close = ")") {
  formatted <- paste(format(pos), collapse = ", ")
  paste(open, formatted, close, sep = "")
}

#' @export
print.position <- function(x, ...) {
  cat("Position: ", formatPosition(x), "\n", sep = "")
}

#' Create a Range
#'
#' A \code{range} is a pair of \code{\link{position}} objects,
#' with each position indicating the \code{start} and \code{end}
#' of the range, respectively.
#'
#' @param start A \code\link{position}} indicating the
#'   start of the range.
#' @param end A \code\link{position} indicating the
#'   end of the range.
#'
#' @export
makeRange <- function(start, end) {
  structure(list(as.position(start), as.position(end)),
            class = "range")
}

formatRange <- function(x) {
  paste(formatPosition(x[[1]]), "--", formatPosition(x[[2]]))
}

#' @export
print.range <- function(x, ...) {
  cat("Range:",
      "\n- Start: ", formatPosition(x[[1]]),
      "\n- End: ", formatPosition(x[[2]]),
      sep = "")
}
