

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

#' @export
askForPassword <- function(prompt) {
  callFun("askForPassword", prompt)
}

#' @export
getActiveProject <- function() {
  callFun("getActiveProject")
}


#' Send Code to the R Console
#'
#' Send code to the R console and optionally execute it.
#'
#' @param code Character vector containing code to be executed.
#' @param execute \code{TRUE} to execute the code immediately.
#'
#' @note The \code{sendToConsole} function was added in version 0.99.787 of RStudio.
#'
#' @examples
#' \dontrun{
#' rstudioapi::sendToConsole(".Platform", execute = TRUE)
#' }
#'
#' @export
sendToConsole <- function (code, execute = TRUE) {
  callFun("sendToConsole", code, TRUE, execute, TRUE)
}

#' Persistent Keys and Values
#'
#' Store persistent keys and values. Storage is per-project, if there is
#' no project currently active then a global store is used.
#'
#' @param name Key name
#' @param value Key value
#' @return The stored value as a character vector (\code{NULL} if no value
#'   of the specified name is available).
#'
#' @note The \code{setPersistentValue} and \code{getPersistentValue} functions
#'  were added in version 1.1.57 of RStudio.
#'
#' @name persistent-values
#' @export
setPersistentValue <- function(name, value) {
  callFun("setPersistentValue", name, value)
}

#' @rdname persistent-values
#' @export
getPersistentValue <- function(name) {
  callFun("getPersistentValue", name)
}





