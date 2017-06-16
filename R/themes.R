#' Retrieve Themes
#'
#' Retrieves a list with themes information. Currently, `editor` as
#' the theme used under the code editor and `global` as the global theme
#' applied to the main user interface in RStudio.
#'
#' @export
getThemeInfo <- function(title, message, url = NULL) {
  editor <- .rs.readUiPref("theme")
  global <- .rs.readUiPref("flat_theme")

  list(
    editor = editor,
    global = switch(
      if (is.null(global)) "" else global,
      alternate = "Sky",
      default = "Modern",
      "Classic"
    )
  )
}
