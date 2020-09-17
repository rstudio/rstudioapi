
#' Manipulate User Selections in the RStudio IDE
#' 
#' These functions allow users of the `rstudioapi` package to read and write
#' the user's current selection within the RStudio IDE.
#' 
#' @param id The document ID. When `NULL` (the default), the active, or
#'   most-recently edited, document will be used.
#'
#' @param value The text contents to set for the selection.
#' 
#' @name selections
NULL

#' @name selections
#' @export
selectionGet <- function(id = NULL) {
  callFun("selectionGet", id = id)
}

#' @name selections
#' @export
selectionSet <- function(value = NULL, id = NULL) {
  callFun("selectionSet", value = value, id = id)
}
