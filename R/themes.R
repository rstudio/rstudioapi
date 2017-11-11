#' Retrieve Themes
#'
#' Retrieves a list with themes information. Currently, \code{editor} as
#' the theme used under the code editor, \code{global} as the global theme
#' applied to the main user interface in RStudio and \code{dark} when
#' the user interface is optimized for dark themes.
#'
#' @export
getThemeInfo <- function() {
  defaults <- list(
    editor = "TextMate",
    global = "Modern",
    dark   = FALSE
  )

  theme <- callFun("getThemeInfo")

  for (key in names(theme)) {
    if (is.null(theme[[key]]) || is.na(theme[[key]])) {
      theme[[key]] <- defaults[[key]]
    }
  }

  if (theme$editor == "Dracula") {
    theme$dark = TRUE
  }

  theme
}
