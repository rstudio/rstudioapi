#' Retrieve Themes
#' 
#' Retrieves a list with information about the current color theme used by
#' RStudio.
#' 
#' A list is returned with the following elements: \describe{ \item{editor}{The
#' name of the current editor theme, such as \code{Textmate}.}
#' \item{global}{The name of the current global theme. One of \code{Modern},
#' \code{Classic}, or \code{Sky}.} \item{dark}{\code{TRUE} if the editor theme
#' is dark, \code{FALSE} otherwise.} \item{foreground}{The current editor
#' theme's default text foreground color, formatted as a CSS-compatible color
#' string, such as \code{rgb(1, 22, 39)}. Supported since RStudio 1.2.1214.}
#' \item{background}{The current editor theme's default text background color,
#' formatted as a CSS-compatible color string. Supported since RStudio
#' 1.2.1214.} }
#' 
#' @export getThemeInfo
getThemeInfo <- function() {
  callFun("getThemeInfo")
}



#' Add a Custom Editor Theme
#' 
#' Adds a custom editor theme to RStudio and returns the name of the newly
#' added theme.
#' 
#' 
#' @param themePath A full or relative path or URL to an \code{rstheme} or
#' \code{tmtheme} to be added.
#' @param apply Whether to immediately apply the newly added theme. Setting
#' this to \code{TRUE} has the same impact as running \code{{
#' rstudioapi::addTheme(<themePath>); rstudioapi::applyTheme(<themeName>)
#' }}.\cr Default: \code{FALSE}.
#' @param force Whether to force the operation and overwrite an existing file
#' with the same name.\cr Default: \code{FALSE}.
#' @param globally Whether to install this theme for the current user or all
#' users. If set to \code{TRUE} this will attempt to install the theme for all
#' users, which may require administrator privileges.\cr Default: \code{FALSE}.
#' @note The \code{addTheme} function was introduced in RStudio 1.2.879.
#' @export addTheme
addTheme <- function(themePath,
                     apply = FALSE,
                     force = FALSE,
                     globally = FALSE)
{
  path <- themePath

  # Ensure path looks like something we can use
  ext <- tolower(tools::file_ext(path))
  if (!identical(ext, "rstheme") && !identical(ext, "tmtheme")) {
    stop("Invalid path ", path, ". ",
         "Please supply a path or URL to an .rstheme or .tmtheme file to add.")
  }

  # If the path appears to be a URL, download it.
  if (grepl("^https?:", themePath)) {
    # Give the downloaded filename the same name and extension as the original.
    path <- file.path(tempdir(), utils::URLdecode(basename(themePath)))
    if (file.exists(path)) {
      # It's unlikely that the theme file will exist in the temp dir, but move it out
      # of the way if it does.
      unlink(path)
    }

    # Perform the download
    utils::download.file(themePath, path)
  }

  if (identical(ext, "tmtheme")) {
    # needs conversion first
    convertTheme(path, add = TRUE, apply = apply, force = force, globally = globally)
  } else if (identical(ext, "rstheme")) {
    # no conversion necessary
    callFun("addTheme", path, apply, force, globally)
  }
}



#' Apply an Editor Theme to RStudio
#' 
#' Applies the specified editor theme to RStudio.
#' 
#' 
#' @param name The unique name of the theme to apply.
#' @note The \code{applyTheme} function was introduced in RStudio 1.2.879.
#' @examples
#' \dontrun{
#' rstudioapi::applyTheme('Kr Theme')
#' }
#' @export applyTheme
applyTheme <- function(name)
{
  callFun("applyTheme", name)
}



#' Convert a tmTheme to an RStudio Theme
#' 
#' Converts a \code{tmTheme} to an \code{rstheme} and optionally adds and
#' applies it to RStudio and returns the name of the theme.
#' 
#' 
#' @param themePath A full or relative path to the \code{tmTheme} file to be
#' converted.
#' @param add Whether to add the newly converted theme to RStudio. Setting this
#' to true will have the same impact as running \code{{
#' rstudioapi::convertTheme(<themePath>, outputLocation =
#' <convertedThemePath>); rstudioapi::addTheme(<convertedThemePath>) }}.\cr
#' Default: \code{TRUE}.
#' @param outputLocation A full or relative path where a copy of the converted
#' theme will be saved. If this value is \code{NULL}, no copy will be saved.\cr
#' Default: \code{NULL}.
#' @param apply Whether to immediately apply the newly added theme. This
#' paramater cannot be set to \code{TRUE} if \code{add} is set to \code{FALSE}.
#' Setting this and \code{add} to \code{TRUE} has the same impact as running
#' \code{{ rstudioapi::convertTheme(<themePath>, outputLocation =
#' <convertedThemePath>); rstudioapi::addTheme(<convertedThemePath>);
#' rstudioapi::applyTheme(<themeName>) }}.\cr Default: \code{FALSE}.
#' @param force Whether to force the operation and overwrite an existing file
#' with the same name.\cr Default: \code{FALSE}.
#' @param globally Whether to install this theme for the current user or all
#' users. If set to \code{TRUE} this will attempt to install the theme for all
#' users, which may require administrator privileges. Only applies when
#' \code{add} is \code{TRUE}. \cr Default: \code{FALSE}.
#' @note The \code{convertTheme} function was introduced in RStudio 1.2.879.
#' @export convertTheme
convertTheme <- function(themePath, add = TRUE, outputLocation = NULL, apply = FALSE, force = FALSE, globally = FALSE)
{
  callFun("convertTheme", themePath, add, outputLocation, apply, force, globally)
}



#' Get Theme List
#' 
#' Retrieves a list of the names of all the editor themes installed for
#' RStudio.
#' 
#' 
#' @note The \code{getThemes} function was introduced in RStudio 1.2.879.
#' @export getThemes
getThemes <- function()
{
  callFun("getThemes")
}



#' Remove a custom theme from RStudio.
#' 
#' Remove a custom theme from RStudio.
#' 
#' 
#' @param name The unique name of the theme to remove.
#' @note The \code{removeTheme} function was introduced in RStudio 1.2.879.
#' @export removeTheme
removeTheme <- function(name)
{
  callFun("removeTheme", name)
}
