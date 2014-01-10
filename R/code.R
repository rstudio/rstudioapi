#' Check if RStudio is running?
#' 
#' @return \code{isRstudio} a boolean; \code{checkRstudio} an error message
#'   if Rstudio is not running
#' @export
#' @examples
#' rstudioapi::available()
#' \donttest{rstudioapi::check()}
available <- function() {
  identical(.Platform$GUI, "RStudio")
}

#' @rdname available
#' @export
check <- function() {
  if (!available()) stop("RStudio not running", call. = FALSE)
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
  
  f <- get(fname, mode = "function")
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
#' \donttest{rstudioapi::exists("viewer")}
exists <- function(name, ...) {
  if (!available()) return(FALSE)
  base::exists(name, envir = asNamespace("rstudio"), ...)
}

#' @export
#' @rdname exists
get <- function(name, ...) {
  check()
  base::get(name, envir = asNamespace("rstudio"), ...)
}