#' Show Dialog Box
#' 
#' Shows a dialog box with a given title and contents.
#' 
#' \preformatted{ showDialog("A dialog", "Showing <b>bold</b> text in the
#' message.") }
#' 
#' @param title The title to display in the dialog box.
#' @param message A character vector with the contents to display in the main
#' dialog area. Contents can contain the following HTML tags: "p", "em",
#' "strong", "b" and "i".
#' @param url An optional url to display under the \code{message}.
#' @note The \code{showDialog} function was added in version 1.1.67 of RStudio.
#' @export showDialog
showDialog <- function(title, message, url = "") {
  callFun("showDialog", title, message, url)
}



#' Updates a Dialog Box
#' 
#' Updates specific properties from the current dialog box.
#' 
#' Currently, the only dialog with support for this action is the New
#' Connection dialog in which the code preview can be updated through this API.
#' 
#' \preformatted{ updateDialog(code = "con <- NULL") }
#' 
#' @param ... Named parameters and values to update a dialog box.
#' @note The \code{updateDialog} function was added in version 1.1.67 of
#' RStudio.
#' @export updateDialog
updateDialog <- function(...) {
  callFun("updateDialog", ...)
}



#' Show Prompt Dialog Box
#' 
#' Shows a dialog box with a prompt field.
#' 
#' 
#' @param title The title to display in the dialog box.
#' @param message A character vector with the contents to display in the main
#' dialog area.
#' @param default An optional character vector that fills the prompt field with
#' a default value.
#' @note The \code{showPrompt} function was added in version 1.1.67 of RStudio.
#' @export showPrompt
showPrompt <- function(title, message, default = NULL) {
  callFun("showPrompt", title, message, default)
}



#' Show Question Dialog Box
#' 
#' Shows a dialog box asking a question.
#' 
#' 
#' @param title The title to display in the dialog box.
#' @param message A character vector with the contents to display in the main
#' dialog area.
#' @param ok And optional character vector that overrides the caption for the
#' OK button.
#' @param cancel An optional character vector that overrides the caption for
#' the Cancel button.
#' @note The \code{showQuestion} function was added in version 1.1.67 of
#' RStudio.
#' @export showQuestion
showQuestion <- function(title, message, ok = NULL, cancel = NULL) {
  callFun("showQuestion", title, message, ok, cancel)
}



#' Prompt user for secret
#'
#' Request a secret from the user. If the `keyring` package is installed, it
#' will be used to cache requested secrets.
#' 
#' 
#' @param name The name of the secret.
#' 
#' @param message A character vector with the contents to display in the main
#'   dialog area.
#'   
#' @param title The title to display in the dialog box.
#' 
#' @note The \code{askForSecret} function was added in version 1.1.419 of
#'   RStudio.
#' 
#' @export
askForSecret <- function(
  name,
  message = paste(name, ":", sep = ""),
  title = paste(name, "Secret")) {

  if (hasFun("askForSecret") || isJob()) {
    callFun("askForSecret", name, title, message)
  } else {
    askForPassword(message)
  }

}
