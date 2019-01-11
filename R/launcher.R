
callLauncherFun <- function(fname, ...) {
  verifyAvailable()

  if (hasFun(fname))
    return(callFun(fname, ...))

  if (!exists("RStudio.Version", envir = globalenv()))
    stop("RStudio is not available.", call. = FALSE)

  RStudio.Version <- get("RStudio.Version", envir = globalenv())
  version <- RStudio.Version()

  if (is.null(version$edition)) {
    fmt <- "Launcher API '%s' is not available in the open-source edition of RStudio."
    stop(sprintf(fmt, fname))
  }

  if (identical(version$mode, "desktop")) {
    fmt <- "Launcher API '%s' is not yet available in the Desktop edition of RStudio."
    stop(sprintf(fmt, fname))
  }

  fmt <- "Launcher API '%s' is not available in your copy of RStudio."
  stop(sprintf(fmt, fname))

}
