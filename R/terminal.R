
#' Send Text to a Terminal
#'
#' Send text to specified terminal.
#'
#' @param id The terminal id. The \code{id} is obtained from
#'   \code{\link{getAllTerminals}()}, \code{\link{getVisibleTerminal}()},
#'   or \code{\link{createTerminal}()}.
#' @param text Character vector containing text to be inserted.
#'
#' @note The \code{sendToTerminal} function was added in version 1.1.234 of RStudio.
#'
#' @examples
#' \dontrun{
#' rstudioapi::sendToTerminal(id='My Terminal', 'ls -l\n')
#' }
#'
#' @export
sendToTerminal <- function(id, text) {
  callFun("sendToTerminal", id, text)
}


#' Clear Terminal Buffer
#'
#' Clears the buffer for specified terminal.
#'
#' @param id The terminal id. The \code{id} is obtained from
#'   \code{\link{getAllTerminals}()}, \code{\link{getVisibleTerminal}()},
#'   or \code{\link{createTerminal}()}.'
#'
#' @note The \code{clearTerminal} function was added in version 1.1.234 of RStudio.
#'
#' @examples
#' \dontrun{
#' rstudioapi::clearTerminal('Terminal 1')
#' }
#'
#' @export
clearTerminal <- function(id) {
  callFun("clearTerminal", id)
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
#' @note The \code{createTerminal} function was added in version 1.1.234 of RStudio.
#'
#' @examples
#' \dontrun{
#' terminalId <- rstudioapi::createTerminal('My Terminal')
#' }
#'
#' @export
createTerminal <- function(id = NULL) {
  callFun("createTerminal", id)
}


#' Is Terminal Busy
#'
#' Are terminals reporting that they are busy?
#'
#' @param id The terminal id. The \code{id} is obtained from
#'   \code{\link{getAllTerminals}()}, \code{\link{getVisibleTerminal}()},
#'   or \code{\link{createTerminal}()}.'
#'
#' @return a boolean
#'
#' @note The \code{isTerminalBusy} function was added in version 1.1.234 of RStudio.
#'
#' @export
isTerminalBusy <- function(id) {
  callFun("isTerminalBusy", id)
}


#' Is Terminal Running
#'
#' Does a terminal have a process associated with it?
#'
#' @param id The terminal id. The \code{id} is obtained from
#'   \code{\link{getAllTerminals}()}, \code{\link{getVisibleTerminal}()},
#'   or \code{\link{createTerminal}()}.'
#'
#' @return a boolean
#'
#' @note The \code{isTerminalRunning} function was added in version 1.1.234 of RStudio.
#'
#' @export
isTerminalRunning <- function(id) {
  callFun("isTerminalRunning", id)
}


#' Get All Terminal Ids
#'
#' Return a character vector containing all the current terminal identifiers.
#'
#' @return The terminal identifiers as a character vector.
#'
#' @note The \code{getAllTerminals} function was added in version 1.1.234 of RStudio.
#'
#' @export
getAllTerminals <- function() {
  callFun("getAllTerminals")
}


#' Retrieve Information about RStudio Terminals
#'
#' Returns information about RStudio terminal instances.
#'
#' @param id The terminal id. The \code{id} is obtained from
#'   \code{\link{getAllTerminals}()}, \code{\link{getVisibleTerminal}()},
#'   or \code{\link{createTerminal}()}.'
#'
#' @return A \code{list} with elements:
#' \tabular{ll}{
#' \code{handle} \tab the internal handle\cr
#' \code{caption} \tab caption (terminal identifier)\cr
#' \code{title} \tab title set by the shell\cr
#' \code{working_dir} \tab working directory\cr
#' \code{shell} \tab shell type\cr
#' \code{running} \tab is terminal process executing\cr
#' \code{busy} \tab is terminal running a program\cr
#' \code{connection} \tab websockets or rpc\cr
#' \code{sequence} \tab creation sequence\cr
#' \code{lines} \tab lines of text in terminal buffer\cr
#' \code{cols} \tab columns in terminal\cr
#' \code{rows} \tab rows in terminal\cr
#' \code{pid} \tab process id of terminal shell\cr
#' \code{full_screen} \tab full screen program running\cr
#' }
#'
#' @note The \code{getTerminalContext} function was added in version 1.1.234 of RStudio.
#'
#' @export
getTerminalContext <- function(id) {
  callFun("getTerminalContext", id)
}


#' Activate Terminal
#'
#' Ensure terminal is running and optionally bring to front in RStudio.
#'
#' @param id The terminal id. The \code{id} is obtained from
#'   \code{\link{getAllTerminals}()}, \code{\link{getVisibleTerminal}()},
#'   or \code{\link{createTerminal}()}. If NULL, the terminal tab will be
#'   selected but no specific terminal will be chosen.
#' @param show If TRUE, bring the terminal to front in RStudio.
#' terminal buffer.
#'
#' @note The \code{activateTerminal} function was added in version 1.1.234 of RStudio.
#'
#' @examples
#' \dontrun{
#' rstudioapi::activateTerminal('Terminal 1', show=TRUE)
#' }
#'
#' @export
activateTerminal <- function(id = NULL, show = TRUE) {
  callFun("activateTerminal", id, show)
}


#' Get Terminal Buffer
#'
#' Returns contents of a terminal buffer.
#'
#' @param id The terminal id. The \code{id} is obtained from
#'   \code{\link{getAllTerminals}()}, \code{\link{getVisibleTerminal}()},
#'   or \code{\link{createTerminal}()}.'
#' @param stripAnsi If FALSE, don't strip out Ansi escape sequences before returning
#' terminal buffer.
#'
#' @return The terminal contents, one line per row.
#'
#' @note The \code{getTerminalBuffer} function was added in version 1.1.234 of RStudio.
#'
#' @export
getTerminalBuffer <- function(id, stripAnsi = TRUE) {
  callFun("getTerminalBuffer", id, stripAnsi)
}


#' Kill Terminal
#'
#' Kill processes and close a terminal.
#'
#' @param id The terminal id. The \code{id} is obtained from
#'   \code{\link{getAllTerminals}()}, \code{\link{getVisibleTerminal}()},
#'   or \code{\link{createTerminal}()}.'
#'
#' @note The \code{killTerminal} function was added in version 1.1.234 of RStudio.
#'
#' @export
killTerminal <- function(id) {
  callFun("killTerminal", id)
}

#' Get Visible Terminal
#'
#' @return Terminal selected in the client, if any.
#'
#' @note The \code{getVisibleTerminal} function was added in version 1.1.234 of RStudio.
#'
#' @export
getVisibleTerminal <- function() {
  callFun("getVisibleTerminal")
}
