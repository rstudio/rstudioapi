#' Get RStudio Package Dependencies
#' 
#' Gets a list of the all the R packages that RStudio depends on in some way.
#' 
#' The data frame of package dependencies contains the following columns:
#' \describe{ \item{name}{The name of the R package.} \item{version}{The
#' required minimum version of the R package.} \item{location}{Where RStudio
#' expects the package to be, \code{cran} for a CRAN-like repository or
#' \code{embedded} for development packages embedded in RStudio itself.}
#' \item{source}{Whether the package should be installed from source.} }
#' 
#' @return A data frame containing a row per R package.
#' @note The \code{getRStudioPackageDependencies} function was introduced in
#' RStudio 1.3.525.
#' @export getRStudioPackageDependencies
getRStudioPackageDependencies <- function() {
  callFun("getPackageDependencies")
}
