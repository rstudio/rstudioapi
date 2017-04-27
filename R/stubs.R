

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

#' Save Active RStudio Plot as an Image
#'
#' Save the currnently active RStudio as an image file.
#'
#' @param file Target filename
#' @param format Image format ("png", "jpeg", "bmp", "tiff", "emf", "svg", or "eps")
#' @param height Image height in pixels
#' @param width Image width in pixels
#'
#' @note The \code{savePlotAsImage} function was introduced in RStudio 1.1.57
#'
#' @export
savePlotAsImage <- function(file,
                            format = c("png", "jpeg", "bmp", "tiff", "emf", "svg", "eps"),
                            width,
                            height) {
  format <- match.arg(format)
  callFun("savePlotAsImage", file, format, width, height)
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

#' Check if Console Supports ANSI Color Escapes
#'
#' @return a boolean
#'
#' @examples
#' if (rstudioapi::hasColorConsole()) {
#'   message("RStudio console supports ANSI color sequences.")
#' }
#' @note The \code{hasColorConsole} function was added in version 1.1.216
#'  of RStudio.
#' @export
hasColorConsole <- function() {
  callFun("getConsoleHasColor")
}
