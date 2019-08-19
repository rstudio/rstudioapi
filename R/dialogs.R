#' Show Dialog Box
#'
#' Shows a dialog box with a given title and contents.
#'
#' @param title The title to display in the dialog box.
#'
#' @param message A character vector with the contents to display in
#'   the main dialog area. Contents can contain the following HTML tags:
#'   "p", "em", "strong", "b" and "i".
#'
#' @param url An optional url to display under the \code{message}.
#'
#' @details
#'
#' \preformatted{
#'     showDialog("A dialog", "Showing <b>bold</b> text in the message.")
#' }
#'
#' @note The \code{showDialog} function was added in version 1.1.67 of RStudio.
#'
#' @export
showDialog <- function(title, message, url = "") {
  callFun("showDialog", title, message, url)
}

#' Updates a Dialog Box
#'
#' Updates specific properties from the current dialog box.
#'
#' @param ... Named parameters and values to update a dialog box.
#'
#' @details
#'
#' Currently, the only dialog with support for this action is the
#' New Connection dialog in which the code preview can be
#' updated through this API.
#'
#' \preformatted{
#'     updateDialog(code = "con <- NULL")
#' }
#'
#' @note The \code{updateDialog} function was added in version 1.1.67 of RStudio.
#'
#' @export
updateDialog <- function(...) {
  callFun("updateDialog", ...)
}

#' Show Prompt Dialog Box
#'
#' Shows a dialog box with a prompt field.
#'
#' @param title The title to display in the dialog box.
#'
#' @param message A character vector with the contents to display in
#'   the main dialog area.
#'
#' @param default An optional character vector that fills the prompt field
#'   with a default value.
#'
#' @note The \code{showPrompt} function was added in version 1.1.67 of RStudio.
#'
#' @export
showPrompt <- function(title, message, default = NULL) {
  callFun("showPrompt", title, message, default)
}

#' Show Question Dialog Box
#'
#' Shows a dialog box asking a question.
#'
#' @param title The title to display in the dialog box.
#'
#' @param message A character vector with the contents to display in
#'   the main dialog area.
#'
#' @param ok And optional character vector that overrides the caption for
#'   the OK button.
#'
#' @param cancel An optional character vector that overrides the caption for
#'   the Cancel button.
#'
#' @note The \code{showQuestion} function was added in version 1.1.67 of RStudio.
#'
#' @export
showQuestion <- function(title, message, ok = NULL, cancel = NULL) {
  callFun("showQuestion", title, message, ok, cancel)
}

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
#' @note The \code{writeRStudioPreference} function was added in version 1.3.400
#'   of RStudio.
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
#' @details RStudio IDE internal preferences include the values displayed in
#'   RStudio's Global Options dialog as well as a number of additional settings.
#'
#' @seealso \code{\link{readPreference}}, which can be used to read arbitrary
#'   user (non-RStudio) preferences set with \code{\link{writePreference}}.
#'
#' @note The \code{writeRStudioPreference} function was added in version 1.3.400
#'   of RStudio.
#'
#' @export
writeRStudioPreference <- function(name, value) {
  callFun("writeRStudioPreference", name, value)
}
#' Show Prompt for Secret Dialog
#'
#' Shows a dialog box asking for a secret with support to remember such secret
#' using the 'keyring' package.
#'
#' @param name The name of the secret.
#'
#' @param message A character vector with the contents to display in
#'   the main dialog area.
#'
#' @param title The title to display in the dialog box.
#'
#' @note The \code{askForSecret} function was added in version 1.1.419 of RStudio.
#'
#' @export
askForSecret <- function(
  name,
  message = paste(name, ":", sep = ""),
  title = paste(name, "Secret")) {

  if (hasFun("askForSecret")) {
    callFun("askForSecret", name, title, message)
  } else {
    askForPassword(message)
  }

}
