#' Check if RStudio is running
#'
#' Check if RStudio is running.
#'
#' @aliases isAvailable verifyAvailable
#'
#' @param version_needed An optional version specification. If supplied, ensures
#'   that RStudio is at least that version.
#'
#' @param child_ok Boolean; check if the current R process is a child process of
#'   the main RStudio session? This can be useful for e.g. RStudio Jobs, where
#'   you'd like to communicate back with the main R session from a child process
#'   through \code{rstudioapi}.
#'
#' @return \code{isAvailable} a boolean; \code{verifyAvailable} an error message
#'   if RStudio is not running
#'
#' @examples
#'
#' rstudioapi::isAvailable()
#' \dontrun{rstudioapi::verifyAvailable()}
#'
#' @export
isAvailable <- function(version_needed = NULL, child_ok = FALSE) {

  if (child_ok && isJob())
    return(callRemote(sys.call(), parent.frame()))

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



#' Return the current version of the RStudio IDE
#'
#' Return the current version of the RStudio IDE
#'
#'
#' @return A \code{\link{numeric_version}} which you can compare to a string
#' and get correct results.
#' @examples
#'
#' \dontrun{
#' if (rstudioapi::getVersion() < "0.98.100") {
#'   message("Your version of RStudio is quite old")
#' }
#' }
#'
#' @export getVersion
getVersion <- function() {
  verifyAvailable()
  callFun("versionInfo")$version
}




#' Call an RStudio API function
#'
#' This function will return an error if RStudio is not running, or the
#' function is not available. If you want to fall back to different behavior,
#' use \code{\link{hasFun}}.
#'
#'
#' @param fname name of the RStudio function to call.
#' @param ... Other arguments passed on to the function
#' @examples
#'
#' if (rstudioapi::isAvailable()) {
#'   rstudioapi::callFun("versionInfo")
#' }
#'
#' @export callFun
callFun <- function(fname, ...) {

  if (isJob())
    return(callRemote(sys.call(), parent.frame()))

  verifyAvailable()

  # get reference to RStudio function
  f <- tryCatch(findFun(fname, mode = "function"), error = identity)
  if (inherits(f, "error"))
    stop("Function ", fname, " not found in RStudio", call. = FALSE)

  # drop arguments that aren't accepted by RStudio
  # (ensure backwards-compatibility with older versions of RStudio)
  args <- list(...)
  if (!"..." %in% names(formals(f)))
    if (length(args) > length(formals(f)))
      length(args) <- length(formals(f))

  # invoke the function
  do.call(f, args)

}



#' Exists/get for RStudio functions
#'
#' These are specialized versions of \code{\link[base]{get}} and
#' \code{\link[base]{exists}} that look in the rstudio package namespace. If
#' RStudio is not running, \code{hasFun} will return \code{FALSE}.
#'
#'
#' @aliases hasFun findFun
#' @param name name of object to look for
#' @param version_needed An optional version specification. If supplied,
#' ensures that RStudio is at least that version. This is useful if function
#' behavior has changed over time.
#' @param ... other arguments passed on to \code{\link[base]{exists}} and
#' \code{\link[base]{get}}
#' @examples
#'
#' rstudioapi::hasFun("viewer")
#'
#' @export hasFun
hasFun <- function(name, version_needed = NULL, ...) {

  if (!isAvailable(version_needed))
    return(FALSE)

  if (usingTools())
    return(exists(toolsName(name), toolsEnv(), ...))

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

