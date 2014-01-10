#' Check if RStudio is running.
#' 
#' @return \code{available} a boolean; \code{check} an error message
#'   if Rstudio is not running
#' @param version_needed An optional version specification. If supplied, 
#'   ensures that Rstudio is at least that version.
#' @export
#' @examples
#' rstudioapi::available()
#' \dontrun{rstudioapi::check()}
available <- function(version_needed = NULL) {
  identical(.Platform$GUI, "RStudio") && version_ok(version_needed)
}

version_ok <- function(version = NULL) {
  if (is.null(version)) return(TRUE)
  
  version() >= version
}

#' @rdname available
#' @export
check <- function(version_needed = NULL) {
  if (!available()) stop("RStudio not running", call. = FALSE)
  if (!version_ok(version_needed)) {
    stop("Need at least version ", version_needed, " of RStudio. ", 
      "Currently running ", version(), call. = FALSE)
  }
  invisible(TRUE)  
}

#' Return the current version of the RStudio api.
#' 
#' @return A \code{\link{numeric_version}} which you can compare to a string
#'   and get correct results.
#' @export
#' @examples
#' \dontrun{
#' if (rstudio::version() < "0.98.100") {
#'   message("Your version of Rstudio is quite old")
#' }
#' }
version <- function() {
  check()
  packageVersion("rstudio")
}

#' Call an Rstudio API function
#' 
#' This function will return an error if Rstudio is not running, or the 
#' function is not available. If you want to fall back to different 
#' behavour, use \code{\link{exists}}.
#' 
#' @param fname name of the Rstudio function to call. 
#'   See \code{help(package = "Rstudio")}. For a complete list of functions
#'   in the current API.
#' @param ... Other arguments passed on to the function
#' @export
#' @examples
#' if (rstudioapi::available()) {
#'   rstudioapi::call("versionInfo")
#' }
call <- function(fname, ...) {
  check()
  
  if (!exists(fname, mode = "function")) {
    stop("Function ", fname, " not found in Rstudio", call. = FALSE)
  }
  
  f <- find(fname, mode = "function")
  f(...)
}

#' Exists/get for Rstudio functions
#' 
#' These are specialised versions of \code{\link[base]{get}} and 
#' \code{\link[base]{exists}} that look in the rstudio package namespace. 
#' If Rstudio is not running,  \code{exists} will return \code{FALSE}, 
#' and \code{getRstudio} will raise an error.
#' 
#' @param name name of object to look for
#' @param ... other arguments passed on to \code{\link[base]{exists}} and 
#'   \code{\link[base]{get}}
#' @export
#' @examples
#' rstudioapi::exists("viewer")
#' \dontrun{rstudioapi::exists("viewer")}
exists <- function(name, ...) {
  if (!available()) return(FALSE)
  base::exists(name, envir = asNamespace("rstudio"), ...)
}

#' @export
#' @rdname exists
find <- function(name, ...) {
  check()
  find(name, envir = asNamespace("rstudio"), ...)
}