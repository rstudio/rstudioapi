
# returns the secret associated with a getenv 'getenv', or NULL
# if no secret is available
retrieveSecret <- function(getenv, label) {
  
  if (is.null(getenv))
    return(NULL)
  
  # build full name of environment variable
  name <- paste("RSTUDIOAPI_SECRET", getenv, sep = "_")
  
  # check for a definition
  value <- Sys.getenv(name, unset = NA)
  if (!is.na(value))
    return(value)
  
  # for non-interactive sessions, give a warning; otherwise,
  # fall through an attempt to ask for a password
  if (!interactive() && !isChildProcess()) {
    fmt <- "The %s associated with 'RSTUDIOAPI_SECRET_%s' is not set or could not be retrieved."
    msg <- sprintf(fmt, label, getenv)
    warning(msg)
  }
  
}

#' Ask the user for a password interactively
#' 
#' Ask the user for a password interactively.
#' 
#' RStudio also sets the global \code{askpass} option to the
#' \code{rstudioapi::askForPassword} function so that it can be invoked in a
#' front-end independent manner.
#' 
#' @param prompt The prompt to be shown to the user.
#'
#' @param getenv An optional getenv. When provided, RStudio will check to see if
#'   an environment variable of the name `RSTUDIOAPI_SECRET_<getenv>` is defined;
#'   if so, that environment variable will be used to supply the password.
#'   If the variable is unset, then (in interactive sessions) the user will
#'   be prompted for a password; otherwise, a warning will be shown.
#'
#' @note The \code{askForPassword} function was added in version 0.99.853 of
#'   RStudio.
#' 
#' @examples
#' 
#' \dontrun{
#' rstudioapi::askForPassword("Please enter your password")
#' }
#' 
#' @export askForPassword
askForPassword <- function(prompt = "Please enter your password",
                           getenv = NULL)
{
  password <- retrieveSecret(getenv, "password")
  if (!is.null(password))
    return(password)
  
  callFun("askForPassword", prompt)
}

#' Prompt user for secret
#'
#' Request a secret from the user. If the `getenvring` package is installed, it
#' will be used to cache requested secrets.
#' 
#' @param name The name of the secret.
#' 
#' @param message A character vector with the contents to display in the main
#'   dialog area.
#'   
#' @param title The title to display in the dialog box.
#' 
#' @param getenv An optional getenv. When provided, RStudio will check to see if
#'   an environment variable of the name `RSTUDIOAPI_SECRET_<getenv>` is defined;
#'   if so, that environment variable will be used to supply the secret.
#'   If the variable is unset, then (in interactive sessions) the user will
#'   be prompted for a password; otherwise, a warning will be shown.
#' 
#' @note The \code{askForSecret} function was added in version 1.1.419 of
#'   RStudio.
#' 
#' @export
askForSecret <- function(
  name,
  message = paste(name, ":", sep = ""),
  title = paste(name, "Secret"),
  getenv = NULL) {
  
  secret <- retrieveSecret(getenv, "secret")
  if (!is.null(secret))
    return(secret)
  
  # use 'askForSecret' if available
  if (hasFun("askForSecret") || isChildProcess())
    return(callFun("askForSecret", name, title, message))
  
  # otherwise, fall back to askForPassword
  askForPassword(message)
  
}
