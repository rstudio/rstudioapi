
#' Read Preference
#'
#' Reads a user preference, useful to remember preferences across different R
#' sessions for the same user.
#'
#' @param name The name of the preference.
#'
#' @param default The default value to use when the preference is not available.
#'
#' @seealso \code{\link{readRStudioPreference}}, which reads RStudio IDE
#'   preferences.
#'
#' @details User preferences can have arbitrary names and values. You must write
#'   the preference with \code{\link{writePreference}} before it can be read
#'   (otherwise its default value will be returned).
#'
#' @note The \code{readPreference} function was added in version 1.1.67 of
#'   RStudio.
#'
#' @export
readPreference <- function(name, default) {
  callFun("readPreference", name, default)
}

#' Write Preference
#'
#' Writes a user preference, useful to remember preferences across different R
#' sessions for the same user.
#'
#' @param name The name of the preference.
#'
#' @param value The value of the preference.
#'
#' @note The \code{writePreference} function was added in version 1.1.67 of
#'   RStudio.
#'
#' @seealso \code{\link{writeRStudioPreference}}, which changes RStudio IDE
#'   preferences.
#'
#' @export
writePreference <- function(name, value) {
  callFun("writePreference", name, value)
}

#' Write RStudio Preference
#'
#' Writes an internal RStudio IDE preference for the current user.
#'
#' @param name The name of the preference.
#'
#' @param value The value of the preference.
#'
#' @details RStudio IDE internal preferences include the values displayed in
#'   RStudio's Global Options dialog as well as a number of additional settings.
#'   Set them carefully; inappropriate values can cause unexpected behavior. See
#'   the RStudio Server Professional Administration Guide appendix for your
#'   version of RStudio for a full list of preference names and values.
#'
#' @seealso \code{\link{writePreference}}, which can be used to store arbitrary
#'   user (non-RStudio) preferences.
#'
#'   \code{\link{readRStudioPreference}}, which reads internal RStudio IDE
#'   preferences.
#'
#' @note The \code{writeRStudioPreference} function was added in version 1.3.387
#'   of RStudio.
#'
#' @examples
#' \dontrun{
#' # Hide RStudio's toolbar.
#' rstudioapi::writeRStudioPreference("toolbar_visible", FALSE)
#' }
#'
#' @export
writeRStudioPreference <- function(name, value) {
  callFun("writeRStudioPreference", name, value)
}

#' Read RStudio Preference
#'
#' Reads an internal RStudio IDE preference for the current user.
#'
#' @param name The name of the preference.
#'
#' @param default The default value of the preference, returned if the
#'   preference is not found.
#'
#' @details RStudio IDE internal preferences include the values displayed in
#'   RStudio's Global Options dialog as well as a number of additional settings.
#'
#' @seealso \code{\link{readPreference}}, which can be used to read arbitrary
#'   user (non-RStudio) preferences set with \code{\link{writePreference}}.
#'
#'   \code{link{writeRStudioPreference}}, which can be used to write internal
#'   RStudio IDE preferences.
#'
#' @note The \code{readRStudioPreference} function was added in version 1.3.387
#'   of RStudio.
#'
#' @examples
#' \dontrun{
#' # Get indentation settings
#' spaces <- rstudioapi::readRStudioPreference("num_spaces_for_tab", FALSE)
#' message("Using ", spaces, " per tab.")
#' }
#'
#' @export
readRStudioPreference <- function(name, default) {
  callFun("readRStudioPreference", name, default)
}
