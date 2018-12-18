#' Translate Local URL
#'
#' Translates a local URL into an externally accessible URL on RStudio Server.
#'
#' @param url The fully qualified URL to translate; for example,
#'   \code{http://localhost:1234/service/page.html}.
#' @param absolute Whether to return a relative path URL (the default) or an
#'   absolute URL.
#' @return The translated URL.
#'
#' @details
#'
#' On RStudio Server, URLs which refer to the local host network address (such
#' as \code{http://localhost:1234/} and \code{http://127.0.0.1:5678/}) must be
#' translated in order to be externally accessible from a browser. This method
#' performs the required translation, and returns the translated URL, which
#' RStudio Server uses to proxy HTTP requests.
#'
#' Returns an unmodified URL on RStudio Desktop, and when the URL does not refer
#' to a local address.
#'
#' @export
translateLocalUrl <- function(url, absolute = FALSE)
{
  callFun("translateLocalUrl", url = url, absolute = absolute)
}
