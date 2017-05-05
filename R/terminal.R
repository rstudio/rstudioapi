
#' Send Text to a Terminal
#'
#' Send text to specified terminal.
#'
#' @param text Character vector containing text to be inserted.
#' @param id The terminal id. When \code{NULL} or blank,
#'   the text will be inserted into the currently open, or last
#'   focused, RStudio terminal. Use the \code{id} returned
#'   from \code{\link{getActiveTerminalId}()} to ensure
#'   that the text is inserted to the intended terminal.
##'
#' @note The \code{sendToTerminal} function was added in version 1.1.223 of RStudio.
#'
#' @examples
#' \dontrun{
#' rstudioapi::sendToTerminal("ls -l", id = "Terminal 1")
#' }
#'
#' @export
sendToTerminal <- function (text, id = NULL) {
  callFun("sendToTerminal", text, id)
}


#' Clear Terminal Buffer
#'
#' Clears the buffer for specified terminal.
#'
#' @param id The terminal id. When \code{NULL} or blank,
#'   the currently open, or last focused, RStudio terminal will be cleared.
#'   Use the \code{id} returned from \code{\link{getActiveTerminalId}()} to ensure
#'   that the intended terminal is cleared.
##'
#' @note The \code{clearTerminal} function was added in version 1.1.223 of RStudio.
#'
#' @examples
#' \dontrun{
#' rstudioapi::clearTerminal("Terminal 1")
#' }
#'
#' @export
clearTerminal <- function (id = NULL) {
  callFun("clearTerminal", id)
}

#' Get Current Terminal
#'
#' Get the identifier for the currently active terminal.
#'
#' @note The \code{getActiveTerminalId} function was added in version 1.1.223 of RStudio.
#'
#' @export
getActiveTerminalId <- function() {
  callFun("getActiveTerminalId")
}

