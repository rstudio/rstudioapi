

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

#' Send Code to the Console
#'
#' Send, and execute, within the RStudio console.
#'
#' @param code A character vector of code.
#' @param echo Whether to echo the code in the console before executing.
#' @param execute Execute the code sent to the console?
#' @param focs Focus the console?
#'
#' @note
#' The \code{sendToConsole} function was added in version 0.99.853 of RStudio.
#'
#' @export
sendToConsole <- function(code, echo = TRUE, execute = TRUE, focus = TRUE) {
  callFun("sendToConsole", code, echo, execute, focus)
}
