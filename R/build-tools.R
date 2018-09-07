#' Build Tools
#'
#' Check, install, and use build tools as required.
#'
#' These functions are intended to be used together -- one should
#' first check whether build tools are available, and when not,
#' prompt for installation. For example:
#'
#' ```R
#' compile_model <- function(...) {
#'
#'   if (rstudioapi::isAvailable()) {
#'
#'     if (!rstudioapi::buildToolsCheck())
#'       rstudioapi::buildToolsInstall("Model compilation")
#'
#'     rstudioapi::buildToolsExec({
#'       # code requiring build tools here
#'     })
#'
#'   }
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
#' @param expr An \R expression (unquoted) to be executed with build tools
#'   available and on the `PATH`.
#'
#' @note The `buildToolsCheck()`, `buildToolsInstall()`, and `buildToolsExec()`
#'   functions were added with version 1.2.962 of RStudio.
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

#' @name build-tools
buildToolsExec <- function(expr) {
  callFun("buildToolsExec", expr)
}
