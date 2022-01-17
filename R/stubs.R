#' RStudio version information
#' 
#' Query information about the currently running instance of RStudio.
#' 
#' @return
#' 
#' An \R list with the following elements:
#' 
#' \tabular{ll}{
#' \code{version} \tab The version of RStudio. \cr
#' \code{mode} \tab `"desktop"` for RStudio Desktop, or `"server"` for RStudio Server. \cr
#' \code{citation} \tab Information on how RStudio can be cited in academic publications. \cr
#' }
#' 
#' @note The \code{versionInfo} function was added in version 0.97.124 of
#' RStudio.
#' 
#' @examples
#' 
#' \dontrun{
#' info <- rstudioapi::versionInfo()
#' 
#' # check what version of RStudio is in use
#' if (info$version >= "1.4") {
#'   # code specific to versions of RStudio 1.4 and newer
#' }
#' 
#' # check whether RStudio Desktop or RStudio Server is being used
#' if (info$mode == "desktop") {
#'   # code specific to RStudio Desktop
#' }
#' 
#' # Get the citation
#' info$citation
#' 
#' }
#' 
#' @export
versionInfo <- function() {
  callFun("versionInfo")
}



#' Preview an Rd topic in the Help pane
#' 
#' Preview an Rd topic in the Help pane.
#' 
#' @param rdFile The path to an `.Rd` file.
#' 
#' @note The \code{previewRd} function was added in version 0.98.191 of
#' RStudio.
#' 
#' @examples
#' 
#' \dontrun{
#' rstudioapi::previewRd("~/MyPackage/man/foo.Rd")
#' }
#' 
#' @export previewRd
previewRd <- function(rdFile) {
  callFun("previewRd", rdFile)
}



#' View local web content within RStudio
#' 
#' View local web content within RStudio. Content can be served from static
#' files in the R session temporary directory, or via a web application running
#' on localhost.
#' 
#' RStudio also sets the global \code{viewer} option to the
#' \code{rstudioapi::viewer} function so that it can be invoked in a front-end
#' independent manner.
#' 
#' Applications are displayed within the Viewer pane. The application URL must
#' either be served from localhost or be a path to a file within the R session
#' temporary directory. If the URL doesn't conform to these requirements it is
#' displayed within a standard browser window.
#' 
#' The \code{height} parameter specifies a desired height, however it's
#' possible the Viewer pane will end up smaller if the request can't be
#' fulfilled (RStudio ensures that the pane paired with the Viewer maintains a
#' minimum height). A height of 400 pixels or lower is likely to succeed in a
#' large proportion of configurations.
#' 
#' A very large height (e.g. 2000 pixels) will allocate the maximum allowable
#' space for the Viewer (while still preserving some view of the pane above or
#' below it). The value \code{"maximize"} will force the Viewer to full height.
#' Note that this value should only be specified in cases where maximum
#' vertical space is essential, as it will result in one of the user's other
#' panes being hidden.
#' 
#' @param url Application URL. This can be either a localhost URL or a path to a
#'   file within the R session temporary directory (i.e. a path returned by
#'   [tempfile()]).
#' 
#' @param height Desired height. Specifies a desired height for the Viewer pane
#'   (the default is \code{NULL} which makes no change to the height of the
#'   pane). This value can be numeric or the string \code{"maximize"} in which
#'   case the Viewer will expand to fill all vertical space. See details below
#'   for a discussion of constraints imposed on the height.
#' 
#' @note The \code{viewer} function was added in version 0.98.423 of RStudio.
#'   The ability to specify \code{maximize} for the \code{height} parameter was
#'   introduced in version 0.99.1001 of RStudio.
#'
#' @section Viewer Detection:
#' 
#' When a page is displayed within the Viewer it's possible that the user will
#' choose to pop it out into a standalone browser window. When rendering inside
#' a standard browser you may want to make different choices about how content
#' is laid out or scaled. Web pages can detect that they are running inside the
#' Viewer pane by looking for the \code{viewer_pane} query parameter, which is
#' automatically injected into URLs when they are shown in the Viewer. For
#' example, the following URL:
#' 
#' \preformatted{ http://localhost:8100 }
#' 
#' When rendered in the Viewer pane is transformed to:
#' 
#' \preformatted{ http://localhost:8100?viewer_pane=1 }
#' 
#' To provide a good user experience it's strongly recommended that callers
#' take advantage of this to automatically scale their content to the current
#' size of the Viewer pane. For example, re-rendering a JavaScript plot with
#' new dimensions when the size of the pane changes.
#' @examples
#' 
#' \dontrun{
#' 
#' # run an application inside the IDE
#' rstudioapi::viewer("http://localhost:8100")
#' 
#' # run an application and request a height of 500 pixels
#' rstudioapi::viewer("http://localhost:8100", height = 500)
#' 
#' # use 'viewer' option if set, or `utils::browseURL()` if unset
#' viewer <- getOption("viewer", default = utils::browseURL)
#' viewer("http://localhost:8100")
#' 
#' # generate a temporary html file and display it
#' dir <- tempfile()
#' dir.create(dir)
#' htmlFile <- file.path(dir, "index.html")
#' # (code to write some content to the file)
#' rstudioapi::viewer(htmlFile)
#' 
#' }
#' 
#' 
#' @export viewer
viewer <- function(url, height = NULL) {
  callFun("viewer", url, height = height)
}



#' Display source markers
#' 
#' Display user navigable source markers in a pane within RStudio.
#' 
#' The \code{markers} argument can contains either a list of marker lists or a
#' data frame with the appropriate marker columns. The fields in a marker are
#' as follows (all are required):
#' 
#' \tabular{ll}{
#' \code{type} \tab The marker type ("error", "warning", "info", "style", or "usage"). \cr
#' \code{file} \tab The path to the associated source file. \cr
#' \code{line} \tab The line number for the associated marker. \cr
#' \code{column} \tab The column number for the associated marker. \cr
#' \code{message} \tab A message associated with the marker at this location. \cr
#' }
#'
#' Note the marker \code{message} can contain ANSI SGR codes for formatting.
#' The \code{cli} package can format text for style and color.
#'  
#' @param name The name of marker set. If there is a market set with this name
#'   already being shown, those markers will be replaced.
#'
#' @param markers An \R list, or data.frame, of source markers. See **details**
#'   for more details on the expected format.
#' 
#' @param basePath Optional. If all source files are within a base path, then
#'   specifying that path here will result in file names being displayed as
#'   relative paths. Note that in this case markers still need to specify source
#'   file names as full paths.
#'
#' @param autoSelect Auto-select a marker after displaying the marker set?
#'
#' @note The \code{sourceMarkers} function was added in version 0.99.225 of
#'   RStudio.
#'
#' @export
sourceMarkers <- function(name, markers, basePath = NULL,
                          autoSelect = c("none", "first", "error")) {
  callFun("sourceMarkers", name, markers, basePath, autoSelect)
}



#' Navigate to file
#' 
#' Open a file in RStudio, optionally at a specified location.
#' 
#' The \code{navigateToFile} opens a file in RStudio. If the file is already
#' open, its tab or window is activated.
#' 
#' Once the file is open, the cursor is moved to the specified location. If the
#' \code{file} argument is empty (the default), then the file is the file
#' currently in view if one exists. If the \code{line} and \code{column}
#' arguments are both equal to \code{-1L} (the default), then the cursor
#' position in the document that is opened will be preserved. Alternatively,
#' \code{moveCursor} can be set to `FALSE` to preserve the cursor position.
#' 
#' Note that if your intent is to navigate to a particular function within a
#' file, you can also cause RStudio to navigate there by invoking
#' \code{\link[utils]{View}} on the function, which has the advantage of
#' falling back on deparsing if the file is not available.
#' 
#' @param file The file to be opened.
#' 
#' @param line The line number where the cursor should be placed. When `-1L`
#'   (the default), the cursor will not be moved.
#'   
#' @param column The column number where the cursour should be placed. When
#'   `-1L` (the default), the cursor will not be moved.
#'
#' @param moveCursor Boolean; should the cursor be moved to the requested
#'   (`line`, `column`) position? Set this to `FALSE` to preserve the existing
#'   cursor position in the document.
#'   
#' @note The \code{navigateToFile} function was added in version 0.99.719 of
#'   RStudio.
#'   
#' @export
navigateToFile <- function(file = character(0),
                           line = -1L,
                           column = -1L,
                           moveCursor = TRUE)
{
  callFun("navigateToFile",
          file,
          as.integer(line),
          as.integer(column),
          as.logical(moveCursor))
}


#' Ask the user for a password interactively
#' 
#' Ask the user for a password interactively.
#' 
#' RStudio also sets the global \code{askpass} option to the
#' \code{rstudioapi::askForPassword} function so that it can be invoked in a
#' front-end independent manner.
#' 
#' @param prompt The prompt to be shown to the user.
#' 
#' @note The \code{askForPassword} function was added in version 0.99.853 of
#'   RStudio.
#' 
#' @examples
#' 
#' \dontrun{
#' rstudioapi::askForPassword("Please enter your password")
#' }
#' 
#' @export askForPassword
askForPassword <- function(prompt = "Please enter your password") {
  callFun("askForPassword", prompt)
}



#' Retrieve path to active RStudio project
#' 
#' Get the path to the active RStudio project (if any). If the path contains
#' non-ASCII characters, it will be UTF-8 encoded.
#' 
#' @return The path to the current project, or \code{NULL} if no project is
#'   currently open.
#'   
#' @note The \code{getActiveProject} function was added in version 0.99.854 of
#'   RStudio.
#'   
#' @export
getActiveProject <- function() {
  
  path <- callFun("getActiveProject")

  # path is NULL iff there is no open project
  if (is.null(path))
    return(path)

  # ... otherwise path is UTF-8 encoded
  Encoding(path) <- "UTF-8"
  path
  
}



#' Save active RStudio plot image
#' 
#' Save the plot currently displayed in the Plots pane as an image.
#' 
#' @param file The target file path.
#' 
#' @param format The Image format.
#'   Must be one of ("png", "jpeg", "bmp", "tiff", "emf", "svg", or "eps").
#'   
#' @param width The image width, in pixels.
#' 
#' @param height The image height, in pixels.
#' 
#' @note The \code{savePlotAsImage} function was introduced in RStudio 1.1.57.
#' 
#' @export savePlotAsImage
savePlotAsImage <- function(file,
                            format = c("png", "jpeg", "bmp", "tiff", "emf", "svg", "eps"),
                            width,
                            height)
{
  format <- match.arg(format)
  callFun("savePlotAsImage", file, format, width, height)
}




#' Send code to the R console
#' 
#' Send code to the R console, and optionally execute it.
#' 
#' @param code The \R code to be executed, as a character vector.
#' 
#' @param execute Boolean; execute the code immediately or just enter the text
#'   into the console?
#'   
#' @param echo Boolean; echo the code in the console as it is executed?
#' 
#' @param focus Boolean; focus the console after sending code?
#' 
#' @param animate Boolean; should the code be animated as if someone was typing it ?
#' 
#' @note The \code{sendToConsole} function was added in version 0.99.787 of
#'   RStudio.
#' 
#' @examples
#' 
#' \dontrun{
#' rstudioapi::sendToConsole(".Platform", execute = TRUE)
#' }
#' 
#' 
#' @export
sendToConsole <- function(code, execute = TRUE, echo = TRUE, focus = TRUE, animate = FALSE) {
  callFun("sendToConsole",
          code = code,
          echo = echo,
          execute = execute,
          focus = focus, 
          animate = animate)
}

#' Persistent keys and values
#'
#' Store persistent keys and values. Storage is per-project; if there is
#' no project currently active, then a global store is used.
#'
#' @param name The key name.
#' @param value The key value.
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



#' Check if console supports ANSI color escapes.
#' 
#' Check if the RStudio console supports ANSI color escapes.
#' 
#' 
#' @return `TRUE` if ANSI color escapes are supported; `FALSE` otherwise.
#' 
#' @note The \code{hasColorConsole} function was added in version 1.1.216 of
#' RStudio.
#' 
#' @examples
#' 
#' \dontrun{
#' if (rstudioapi::hasColorConsole()) {
#'   message("RStudio console supports ANSI color sequences.")
#' }
#' 
#' }
#' 
#' 
#' @export hasColorConsole
hasColorConsole <- function() {
  callFun("getConsoleHasColor")
}



#' Restart the R Session
#' 
#' Restart the RStudio session.
#' 
#' 
#' @param command A command (as a string) to be run after restarting.
#' 
#' @note The \code{restartSession} function was added in version 1.1.281 of
#'   RStudio.
#'   
#' @export
restartSession <- function(command = "") {
  callFun("restartSession", command)
}


#' Select a file / folder
#'
#' Prompt the user for the path to a file or folder, using the system file
#' dialogs with RStudio Desktop, and RStudio's own dialogs with RStudio Server.
#'
#' When the selected file resolves within the user's home directory,
#' RStudio will return an aliased path -- that is, prefixed with \code{~/}.
#'
#' @param caption The window title.
#' @param label The label to use for the 'Accept' / 'OK' button.
#' @param path The initial working directory, from which the file dialog
#'   should begin browsing. Defaults to the current RStudio
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
                       path = getActiveProject(),
                       filter = "All Files (*)",
                       existing = TRUE)
{
  out <- callFun("selectFile", caption, label, path, filter, existing)
  if (is.character(out))
    Encoding(out) <- "UTF-8"
  out
}

#' @name file-dialogs
#' @export
selectDirectory <- function(caption = "Select Directory",
                            label = "Select",
                            path = getActiveProject())
{
  callFun("selectDirectory", caption, label, path)
}

#' Open a project in RStudio
#'
#' Initialize and open RStudio projects.
#'
#' Calling \code{openProject()} without arguments effectively re-opens the
#' currently open project in RStudio. When switching projects, users will
#' be prompted to save any unsaved files; alternatively, you can explicitly
#' save any open documents using [documentSaveAll()].
#'
#' @param path Either the path to an existing \code{.Rproj} file, or a path
#'   to a directory in which a new project should be initialized and opened.
#'   
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
