#' Retrieve Themes
#'
#' Retrieves a list with themes information. Currently, \code{editor} as
#' the theme used under the code editor, \code{global} as the global theme
#' applied to the main user interface in RStudio and \code{dark} when
#' the user interface is optimized for dark themes.
#'
#' @export
getThemeInfo <- function(title, message, url = NULL) {
  editor <- .rs.readUiPref("theme")

  global <- .rs.readUiPref("flat_theme")
  global <- switch(
    if (is.null(global)) "" else global,
    alternate = "Sky",
    default = "Modern",
    "Classic"
  )

  dark <- grepl(
    paste(
      "ambiance",
      "chaos",
      "clouds midnight",
      "cobalt",
      "idle fingers",
      "kr theme",
      "material",
      "merbivore soft",
      "merbivore",
      "mono industrial",
      "monokai",
      "pastel on dark",
      "solarized dark",
      "tomorrow night blue",
      "tomorrow night bright",
      "tomorrow night 80s",
      "tomorrow night",
      "twilight",
      "vibrant ink",
      sep = "|"
    ),
    editor,
    ignore.case = TRUE)
  dark <- !identical(global, "Classic") && dark

  list(
    editor = editor,
    global = global,
    dark = dark
  )
}
