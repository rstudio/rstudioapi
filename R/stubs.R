


#' @export
versionInfo <- function() {
  callFun("versionInfo")
}

#' @export
diagnosticsReport <- function() {
  callFun("diagnosticsReport")
}

#' @export
previewRd <- function(rdFile) {
  callFun("previewRd", rdFile)
}

#' @export
viewer <- function(url, height = NULL) {
  callFun("viewer", url, height = height)
}
