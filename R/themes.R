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

#' Add a Custom Editor Theme
#'
#' Adds a custom editor theme to RStudio and returns the name of the newly added theme.
#'
#' @param themePath      A full or relative path to the \code{rstheme} file to be added.
#' @param apply          Whether to immediately apply the newly added theme. Setting this to
#'                       \code{TRUE} has the same impact as running
#'                       \code{{ rstudioapi::addTheme(<themePath>); rstudioapi::applyTheme(<themeName>) }}.\cr
#'                       Default: \code{FALSE}.
#' @param force          Whether to force the operation and overwrite an existing file with the same
#'                       name.\cr
#'                       Default: \code{FALSE}.
#' @param globally       Whether to install this theme for the current user or all users. If set to
#'                       \code{TRUE} this will attempt to install the theme for all users, which may
#'                       require administrator privileges.\cr
#'                       Default: \code{FALSE}.
#'
#' @note The \code{addTheme} function was introduced in RStudio 1.2.879.
#'
#' @export
addTheme <- function(themePath,
                     apply = FALSE,
                     force = FALSE,
                     globally = FALSE)
{
  callFun("addTheme", themePath, apply, force, globally)
}

#' Apply an Editor Theme to RStudio
#'
#' Applies the specified editor theme to RStudio.
#'
#' @param name    The unique name of the theme to apply.
#'
#' @note The \code{applyTheme} function was introduced in RStudio 1.2.879.
#'
#' @export
applyTheme <- function(name)
{
  callFun("applyTheme", name)
}

#' Convert a tmTheme to an RStudio Theme
#'
#' Converts a \code{tmTheme} to an \code{rstheme} and optionally adds and applies it to RStudio and returns the
#' name of the theme.
#'
#' @param themePath        A full or relative path to the \code{tmTheme} file to be converted.
#' @param add              Whether to add the newly converted theme to RStudio. Setting this to true
#'                         will have the same impact as running \code{{ rstudioapi::convertTheme(<themePath>, outputLocation = <convertedThemePath>); rstudioapi::addTheme(<convertedThemePath>) }}.\cr
#'                         Default: \code{TRUE}.
#' @param outputLocation   A full or relative path where a copy of the converted theme will be saved.
#'                         If this value is \code{NULL}, no copy will be saved.\cr
#'                         Default: \code{NULL}.
#' @param apply            Whether to immediately apply the newly added theme. This paramater cannot be set to
#'                         \code{TRUE} if \code{add} is set to \code{FALSE}. Setting this and \code{add}
#'                         to \code{TRUE} has the same impact as running
#'                         \code{{ rstudioapi::convertTheme(<themePath>, outputLocation = <convertedThemePath>); rstudioapi::addTheme(<convertedThemePath>); rstudioapi::applyTheme(<themeName>) }}.\cr
#'                         Default: \code{FALSE}.
#' @param force            Whether to force the operation and overwrite an existing file with the same
#'                         name.\cr
#'                         Default: \code{FALSE}.
#' @param globally         Whether to install this theme for the current user or all users. If set to
#'                         \code{TRUE} this will attempt to install the theme for all users, which may
#'                         require administrator privileges. Only applies when \code{add} is \code{TRUE}. \cr
#'                         Default: \code{FALSE}.
#'
#' @note The \code{convertTheme} function was introduced in RStudio 1.2.879.
#'
#' @export
convertTheme <- function(themePath, add = TRUE, outputLocation = NULL, apply = FALSE, force = FALSE, globally = FALSE)
{
  callFun("convertTheme", themePath, add, outputLocation, apply, force, globally)
}

#' Get Theme List
#'
#' Retrieves a list of the names of all the editor themes installed for RStudio.
#'
#' @note The \code{getThemes} function was introduced in RStudio 1.2.879.
#'
#' @export
getThemes <- function()
{
  callFun("getThemes")
}
