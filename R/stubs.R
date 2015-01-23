


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
