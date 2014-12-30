#' Check if RStudio is running.
#' 
#' @return \code{isAvailable} a boolean; \code{verifyAvailable} an error message
#'   if RStudio is not running
#' @param version_needed An optional version specification. If supplied, 
#'   ensures that RStudio is at least that version.
#' @export
#' @examples
#' rstudioapi::isAvailable()
#' \dontrun{rstudioapi::verifyAvailable()}
isAvailable <- function(version_needed = NULL) {
  identical(.Platform$GUI, "RStudio") && version_ok(version_needed)
}

version_ok <- function(version = NULL) {
  if (is.null(version)) return(TRUE)
  
  getVersion() >= version
}

#' @rdname isAvailable
#' @export
verifyAvailable <- function(version_needed = NULL) {
  if (!isAvailable()) stop("RStudio not running", call. = FALSE)
  if (!version_ok(version_needed)) {
    stop("Need at least version ", version_needed, " of RStudio. ", 
      "Currently running ", getVersion(), call. = FALSE)
  }
  invisible(TRUE)  
}

#' Return the current version of the RStudio API
#' 
#' @return A \code{\link{numeric_version}} which you can compare to a string
#'   and get correct results.
#' @export
#' @examples
#' \dontrun{
#' if (rstudioapi::getVersion() < "0.98.100") {
#'   message("Your version of RStudio is quite old")
#' }
#' }
getVersion <- function() {
  verifyAvailable()
  callFun("versionInfo")$version
}


#' Call an RStudio API function
#' 
#' This function will return an error if RStudio is not running, or the 
#' function is not available. If you want to fall back to different 
#' behavior, use \code{\link{hasFun}}.
#' 
#' @param fname name of the RStudio function to call. 
#' @param ... Other arguments passed on to the function
#' @export
#' @examples
#' if (rstudioapi::isAvailable()) {
#'   rstudioapi::callFun("versionInfo")
#' }
callFun <- function(fname, ...) {
  verifyAvailable()
  
  if (usingTools())
    found <- exists(toolsName(fname), envir = toolsEnv(), mode = "function")
  else
    found <- exists(fname, envir = asNamespace("rstudio"), mode = "function")
  if (!found)
    stop("Function ", fname, " not found in RStudio", call. = FALSE)
  
  f <- findFun(fname, mode = "function")
  f(...)
}

#' Exists/get for RStudio functions
#' 
#' These are specialized versions of \code{\link[base]{get}} and 
#' \code{\link[base]{exists}} that look in the rstudio package namespace. 
#' If RStudio is not running,  \code{hasFun} will return \code{FALSE}.
#' 
#' @param name name of object to look for
#' @param ... other arguments passed on to \code{\link[base]{exists}} and 
#'   \code{\link[base]{get}}
#' @param version_needed An optional version specification. If supplied, 
#'   ensures that RStudio is at least that version. This is useful if 
#'   function behavior has changed over time.
#' @export
#' @examples
#' rstudioapi::hasFun("viewer")
hasFun <- function(name, version_needed = NULL, ...) {
  if (!isAvailable(version_needed)) return(FALSE)
  if (usingTools())
    exists(toolsName(name), toolsEnv(), ...)
  else
    exists(name, envir = asNamespace("rstudio"), ...)
}

#' @export
#' @rdname hasFun
findFun <- function(name, version_needed = NULL, ...) {
  verifyAvailable(version_needed)
  if (usingTools())
    get(toolsName(name), toolsEnv(), ...)
  else
    get(name, envir = asNamespace("rstudio"), ...)
}

usingTools <- function() {
  exists(toolsName("versionInfo"), envir = toolsEnv())
}

toolsName <- function(name) {
  paste(".rs.api.", name, sep="")
}

toolsEnv <- function() {
  as.environment(match("tools:rstudio", search()))
}

