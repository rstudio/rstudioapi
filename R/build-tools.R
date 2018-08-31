#' Build Tools
#'
#' Check and install build tools as required.
#'
#' These functions are intended to be used together -- one should
#' first check whether build tools are available, and when not,
#' prompt for installation. For example:
#'
#' ```R
#' compile_model <- function(...) {
#'   if (!rstudioapi::buildToolsCheck())
#'     rstudioapi::buildToolsInstall("Model compilation")
#'
#'   # proceed with compilation
#' }
#' ```
#'
#' The `action` parameter is used to communicate (with a prompt) the operation
#' being performed that requires build tool installation. Setting it to `NULL`
#' or the empty string will suppress that prompt.
#'
#' @param action The action (as a string) being taken that will require
#'   installation of build tools.
#'
#' @note The `buildToolsCheck()` and `buildToolsInstall()` functions were added
#'   with version 1.2.945 of RStudio.
#'
#' @name build-tools
NULL

#' @name build-tools
buildToolsCheck <- function() {
  callFun("buildToolsCheck")
}

#' @name build-tools
buildToolsInstall <- function(action) {
  callFun("buildToolsInstall", action)
}
