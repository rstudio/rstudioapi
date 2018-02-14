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
#' @param url And optional url to display under the \code{message}.
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
showDialog <- function(title, message, url = NULL) {
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
#' Reads a user interface preference, useful to remember preferences across
#' different r sessions for the same user.
#'
#' @param name The name of the preference.
#'
#' @param default The default value to use when the preference is not available.
#'
#' @note The \code{readPreference} function was added in version 1.1.67 of RStudio.
#'
#' @export
readPreference <- function(name, default) {
  callFun("readPreference", name, default)
}

#' Write Preference
#'
#' Writes a user interface preference, useful to remember preferences across
#' different r sessions for the same user.
#'
#' @param name The name of the preference.
#'
#' @param value The value of the preference.
#'
#' @note The \code{writePreference} function was added in version 1.1.67 of RStudio.
#'
#' @export
writePreference <- function(name, value) {
  callFun("writePreference", name, value)
}

#' Show Prompt for Secret Dialog
#'
#' Shows a dialog box asking for a secret with support to remember such secret
#' using the 'keyring' package.
#'
#' @param name The name of the secret.
#'
#' @param title The title to display in the dialog box.
#'
#' @param message A character vector with the contents to display in
#'   the main dialog area.
#'
#' @note The \code{showQuestion} function was added in version 1.2.350 of RStudio.
#'
#' @export
#' @export
askForSecret <- function(name, title = name, message = paste(name, ":", sep = "")) {
  callFun("askForSecret", name, title, message)
}
