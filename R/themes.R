#' Retrieve Themes
#'
#' Retrieves a list with themes information. Currently, `editor` as
#' the theme used under the code editor and `global` as the global theme
#' applied to the main user interface in RStudio.
#'
#' @export
getThemeInfo <- function(title, message, url = NULL) {
  list(
    editor = .rs.readUiPref("theme"),
    global = switch(
      .rs.readUiPref("flat_theme"),
      alternate = "Sky",
      default = "Modern"
    )
  )
}
