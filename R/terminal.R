
#' Send Text to a Terminal
#'
#' Send text to specified terminal.
#'
#' @param text Character vector containing text to be inserted.
#' @param id The terminal id. When \code{NULL} or blank,
#'   the text will be inserted into the currently open, or last
#'   focused, RStudio terminal. Use the \code{id} returned
#'   from \code{\link{getActiveTerminalId}()} or
#'   \code{\link{createTerminal}()} to ensure the text is inserted
#'   to the intended terminal.
#'
#' @note The \code{sendToTerminal} function was added in version 1.1.227 of RStudio.
#'
#' @examples
#' \dontrun{
#' rstudioapi::sendToTerminal("ls -l", id = "Terminal 1")
#' }
#'
#' @export
sendToTerminal <- function(text, id = NULL) {
  callFun("sendToTerminal", text, id)
}


#' Clear Terminal Buffer
#'
#' Clears the buffer for specified terminal.
#'
#' @param id The terminal id. When \code{NULL} or blank,
#'   the currently open, or last focused, RStudio terminal will be cleared.
#'   Use the \code{id} returned from \code{\link{getActiveTerminalId}()}
#'   or \code{\link{createTerminal}()} to ensure the intended terminal is cleared.
#'
#' @note The \code{clearTerminal} function was added in version 1.1.227 of RStudio.
#'
#' @examples
#' \dontrun{
#' rstudioapi::clearTerminal("Terminal 1")
#' }
#'
#' @export
clearTerminal <- function(id = NULL) {
  callFun("clearTerminal", id)
}


#' Get Current Terminal
#'
#' Get the identifier for the currently active terminal.
#'
#' @return The terminal identifier as a character vector (\code{NULL} if no
#'   terminal is currently open).
#'
#' @note The \code{getActiveTerminalId} function was added in version 1.1.227 of RStudio.
#'
#' @export
getActiveTerminalId <- function() {
  callFun("getActiveTerminalId")
}


#' Create a Terminal
#'
#' Create a new Terminal.
#'
#' @param id The terminal id. When \code{NULL} or blank, the terminal id
#' will be chosen by the system.
#'
#' @return The terminal identifier as a character vector (\code{NULL} if
#'   unable to create the terminal or the given terminal identifier is already
#'   in use).
#'
#' @note The \code{createTerminal} function was added in version 1.1.227 of RStudio.
#'
#' @examples
#' \dontrun{
#' terminalId <- rstudioapi::createTerminal("My Terminal")
#' }
#'
#' @export
createTerminal <- function(id = NULL) {
  callFun("createTerminal", id)
}

#' Is Terminal Busy
#'
#' Is a terminal reporting that it is busy?
#'
#' @param id The terminal id. When \code{NULL} or blank,
#'   the currently open, or last focused, RStudio terminal will be checked.
#'   Use the \code{id} returned from \code{\link{getActiveTerminalId}()} or
#'   \code{\link{createTerminal}()} to ensure the intended terminal
#'   is queried.
#'
#' @return a boolean
#'
#' @note The \code{isTerminalBusy} function was added in version 1.1.227 of RStudio.
#'
#' @export
isTerminalBusy <- function(id = NULL) {
  callFun("isTerminalBusy", id)
}

