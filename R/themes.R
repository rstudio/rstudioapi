#' Retrieve Themes
#'
#' Retrieves a list with themes information. Currently, \code{editor} as
#' the theme used under the code editor, \code{global} as the global theme
#' applied to the main user interface in RStudio and \code{dark} when
#' the user interface is optimized for dark themes.
#'
#' RStudio 1.2.553 adds support for \code{background} and \code{color}
#' as the primary colors used under the code editor.
#'
#' @export
getThemeInfo <- function() {
  callFun("getThemeInfo")
}
