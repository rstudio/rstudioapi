
#' Navigate to a Directory in the Files Pane
#' 
#' Navigate to a directory in the Files pane. The contents of that directory
#' will be listed and shown in the Files pane.
#' 
#' @param path The filesystem path to be shown.
#' 
#' @export
filesPaneNavigate <- function(path) {
  callFun("filesPaneNavigate", path)
}
