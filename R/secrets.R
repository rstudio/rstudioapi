
# returns the secret associated with a key 'key', or NULL
# if no secret is available
retrieveSecret <- function(tag, label) {
  
  # nothing to do if we don't have a key
  if (is.null(tag))
    return(NULL)
  
  # build full name of environment variable
  name <- paste("RSTUDIOAPI_SECRET", toupper(tag), sep = "_")
  
  # check for a definition
  value <- Sys.getenv(name, unset = NA)
  if (!is.na(value))
    return(value)
  
  # for non-interactive sessions, give a warning; otherwise,
  # fall through an attempt to ask for a password
  if (!interactive() && !isChildProcess()) {
    fmt <- "The %s associated with tag '%s' is not set or could not be retrieved."
    msg <- sprintf(fmt, label, tag)
    warning(msg)
  }
  
}

#' @param name The name to associate with the secret. This name will be used
#'   to locate the requested secret; e.g. when requested via the `keyring`
#'   package.
#'   
#' @param prompt The prompt to be shown to the user.
#' 
#' @param tag An optional tag, used to assist `rstudioapi` in reading secrets
#'   in non-interactive \R sessions. Currently, when provided, `rstudioapi`
#'   will check if an environment variable of the name `RSTUDIOAPI_SECRET_<KEY>`
#'   is defined; if so, that environment variable will be used to supply the
#'   password. If the variable is unset, then (in interactive sessions) the user
#'   will be prompted for a password; otherwise, a warning will be shown.
#'
#' @name dialog-params
NULL

#' Ask the user for a password interactively
#' 
#' Ask the user for a password interactively. A dialog requesting a password
#' from the user will be shown, and the value of the retrieved password will
#' be returned.
#' 
#' RStudio also sets the global \code{askpass} option to the
#' [askForPassword()] function so that it can be invoked in a
#' front-end independent manner.
#' 
#' @inheritParams dialog-params
#' 
#' @note The \code{askForPassword} function was added in version 0.99.853 of
#'   RStudio.
#' 
#' @examples
#' 
#' \dontrun{
#' rstudioapi::askForPassword("Please enter your password:")
#' }
#' 
#' @export askForPassword
askForPassword <- function(prompt = "Please enter your password:",
                           name = NULL,
                           tag = NULL)
{
  # if 'name' was supplied, delegate to askForSecret
  if (!is.null(name))
    return(askForSecret(name = name, message = prompt, tag = tag))
  
  # try to retrieve password non-interactively
  password <- retrieveSecret(tag, "password")
  if (!is.null(password))
    return(password)
  
  # request password from user
  callFun("askForPassword", prompt)
}

#' Prompt user for secret
#'
#' Request a secret from the user. If the `keyring` package is installed, it
#' will be used to cache requested secrets.
#' 
#' @inheritParams dialog-params
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
askForSecret <- function(name,
                         message = NULL,
                         title = "Secret",
                         tag = NULL)
{
  # resolve 'message' argument
  if (is.null(message)) {
    fmt <- "Please enter a secret to associate with name '%s':"
    message <- sprintf(fmt, name)
  }
  
  # try to retrieve secret non-interactively
  secret <- retrieveSecret(tag, "secret")
  if (!is.null(secret))
    return(secret)
  
  # use 'askForSecret' if available
  if (hasFun("askForSecret") || isChildProcess())
    return(callFun("askForSecret", name, title, message))
  
  # otherwise, fall back to askForPassword
  askForPassword(message)
}
