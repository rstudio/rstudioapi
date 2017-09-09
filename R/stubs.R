

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
navigateToFile <- function(file, line = -1L, column = -1L) {
  callFun("navigateToFile", file, as.integer(line), as.integer(column))
}

#' @export
askForPassword <- function(prompt = "Please enter your password") {
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
#' \dontrun{
#' if (rstudioapi::hasColorConsole()) {
#'   message("RStudio console supports ANSI color sequences.")
#' }
#' }
#'
#' @note The \code{hasColorConsole} function was added in version 1.1.216
#'  of RStudio.
#'
#' @export
hasColorConsole <- function() {
  callFun("getConsoleHasColor")
}

#' Restart the R Session
#'
#' Restart the RStudio \R session.
#'
#' @param command An \R command (as a string) to be run
#'   after restarting \R.
#'
#' @note The \code{restartSession} function was added in version 1.1.281
#'   of RStudio.
#'
#' @export
restartSession <- function(command = "") {
  callFun("restartSession", command)
}


#' Select a File / Folder
#'
#' Prompt the user for the path to a file or folder, using the system
#' file dialogs with RStudio Desktop, and RStudio's own web dialogs
#' with RStudio Server.
#'
#' When the selected file resolves within the user's home directory,
#' RStudio will return an aliased path -- that is, prefixed with \code{~/}.
#'
#' @param caption The window title.
#' @param label The label to use for the 'Accept' / 'OK' button.
#' @param path The initial working directory, from which the file dialog
#'   should begin browsing. When \code{NULL}, defaults to the current RStudio
#'   project directory.
#' @param filter A glob filter, to be used when attempting to open a file with a
#'   particular extension. For example, to scope the dialog to \R files, one could use
#'   \code{R Files (*.R)} here.
#' @param existing Boolean; should the file dialog limit itself to existing
#'   files on the filesystem, or allow the user to select the path to a new file?
#'
#' @note The \code{selectFile} and \code{selectDirectory} functions were
#'   added in version 1.1.287 of RStudio.
#'
#' @name file-dialogs
NULL

#' @name file-dialogs
#' @export
selectFile <- function(caption = "Select File",
                       label = "Select",
                       path = NULL,
                       filter = "All Files (*)",
                       existing = TRUE)
{
  callFun("selectFile", caption, label, path, filter, existing)
}

#' @name file-dialogs
#' @export
selectDirectory <- function(caption = "Select Directory",
                            label = "Select",
                            path = NULL)
{
  callFun("selectDirectory", caption, label, path)
}

#' Open a Project in RStudio
#'
#' Initialize and open RStudio projects.
#'
#' Calling \code{openProject()} without arguments effectively re-opens the
#' currently open project in RStudio. When switching projects, users will
#' be prompted to save any unsaved files; alternatively, you can explicitly
#' save any open documents using \code{\link{documentSaveAll}()}.
#'
#' @param path Either the path to an existing \code{.Rproj} file, or a path
#'   to a directory in which a new project should be initialized and opened.
#' @param newSession Boolean; should the project be opened in a new session,
#'   or should the current RStudio session switch to that project? Note that
#'   \code{TRUE} values are only supported with RStudio Desktop and RStudio
#'   Server Pro.
#'
#' @note The \code{openProject} and \code{initializeProject} functions were
#'   added in version 1.1.287 of RStudio.
#'
#' @name projects
NULL

#' @name projects
#' @export
openProject <- function(path = NULL, newSession = FALSE) {
  callFun("openProject", path, newSession)
}

#' @name projects
#' @export
initializeProject <- function(path = getwd()) {
  callFun("initializeProject", path)
}
