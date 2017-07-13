
#' Send Text to a Terminal
#'
#' Send text to an existing terminal.
#'
#' @param id The terminal id. The \code{id} is obtained from
#'   \code{\link{terminalList}()}, \code{\link{terminalVisible}()},
#'   \code{\link{terminalCreate}()}, or \code{\link{terminalExecute}()}.
#' @param text Character vector containing text to be inserted.
#'
#' @note The \code{terminalSend} function was added in version 1.1.305 of RStudio.
#'
#' @examples
#' \dontrun{
#' rstudioapi::terminalSend(id='My Terminal', 'ls -l\n')
#' }
#'
#' @export
terminalSend <- function(id, text) {
  callFun("terminalSend", id, text)
}


#' Clear Terminal Buffer
#'
#' Clears the buffer for specified terminal.
#'
#' @param id The terminal id. The \code{id} is obtained from
#'   \code{\link{terminalList}()}, \code{\link{terminalVisible}()},
#'   \code{\link{terminalCreate}()}, or \code{\link{terminalExecute}()}.
#'
#' @note The \code{terminalClear} function was added in version 1.1.305 of RStudio.
#'
#' @examples
#' \dontrun{
#' rstudioapi::terminalClear('Terminal 1')
#' }
#'
#' @export
terminalClear <- function(id) {
  callFun("terminalClear", id)
}


#' Create a Terminal
#'
#' Create a new Terminal.
#'
#' @param id The desired terminal id. When \code{NULL} or blank,
#' the terminal id will be chosen by the system.
#' @param show If FALSE, terminal won't be brought to front
#'
#' @return The terminal identifier as a character vector (\code{NULL} if
#'   unable to create the terminal or the given terminal identifier is already
#'   in use).
#'
#' @note The \code{terminalCreate} function was added in version 1.1.305 of RStudio.
#'
#' @examples
#' \dontrun{
#' terminalId <- rstudioapi::terminalCreate('My Terminal')
#' }
#'
#' @export
terminalCreate <- function(id = NULL, show = TRUE) {
  callFun("terminalCreate", id, show)
}


#' Is Terminal Busy
#'
#' Are terminals reporting that they are busy?
#'
#' @param id The terminal id. The \code{id} is obtained from
#'   \code{\link{terminalList}()}, \code{\link{terminalVisible}()},
#'   \code{\link{terminalCreate}()}, or \code{\link{terminalExecute}()}.
#'
#' @return a boolean
#'
#' @note The \code{terminalBusy} function was added in version 1.1.305 of RStudio.
#'
#' @export
terminalBusy <- function(id) {
  callFun("terminalBusy", id)
}


#' Is Terminal Running
#'
#' Does a terminal have a process associated with it?
#'
#' @param id The terminal id. The \code{id} is obtained from
#'   \code{\link{terminalList}()}, \code{\link{terminalVisible}()},
#'   \code{\link{terminalCreate}()}, or \code{\link{terminalExecute}()}.
#'
#' @return a boolean
#'
#' @note The \code{terminalRunning} function was added in version 1.1.305 of RStudio.
#'
#' @export
terminalRunning <- function(id) {
  callFun("terminalRunning", id)
}


#' Get All Terminal Ids
#'
#' Return a character vector containing all the current terminal identifiers.
#'
#' @return The terminal identifiers as a character vector.
#'
#' @note The \code{terminalList} function was added in version 1.1.305 of RStudio.
#'
#' @export
terminalList <- function() {
  callFun("terminalList")
}


#' Retrieve Information about RStudio Terminals
#'
#' Returns information about RStudio terminal instances.
#'
#' @param id The terminal id. The \code{id} is obtained from
#'   \code{\link{terminalList}()}, \code{\link{terminalVisible}()},
#'   \code{\link{terminalCreate}()}, or \code{\link{terminalExecute}()}.
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
#' \code{exit_code} \tab process exit code or NULL\cr
#' \code{connection} \tab websockets or rpc\cr
#' \code{sequence} \tab creation sequence\cr
#' \code{lines} \tab lines of text in terminal buffer\cr
#' \code{cols} \tab columns in terminal\cr
#' \code{rows} \tab rows in terminal\cr
#' \code{pid} \tab process id of terminal shell\cr
#' \code{full_screen} \tab full screen program running\cr
#' }
#'
#' @note The \code{terminalContext} function was added in version 1.1.305 of RStudio.
#'
#' @export
terminalContext <- function(id) {
  callFun("terminalContext", id)
}


#' Activate Terminal
#'
#' Ensure terminal is running and optionally bring to front in RStudio.
#'
#' @param id The terminal id. The \code{id} is obtained from
#'   \code{\link{terminalList}()}, \code{\link{terminalVisible}()},
#'   \code{\link{terminalCreate}()}, or \code{\link{terminalExecute}()}.
#'   If NULL, the terminal tab will be selected but no specific terminal
#'   will be chosen.
#' @param show If TRUE, bring the terminal to front in RStudio.
#' terminal buffer.
#'
#' @note The \code{terminalActivate} function was added in version 1.1.305 of RStudio.
#'
#' @examples
#' \dontrun{
#' rstudioapi::terminalActivate('Terminal 1', show=TRUE)
#' }
#'
#' @export
terminalActivate <- function(id = NULL, show = TRUE) {
  callFun("terminalActivate", id, show)
}


#' Get Terminal Buffer
#'
#' Returns contents of a terminal buffer.
#'
#' @param id The terminal id. The \code{id} is obtained from
#'   \code{\link{terminalList}()}, \code{\link{terminalVisible}()},
#'   \code{\link{terminalCreate}()}, or \code{\link{terminalExecute}()}.
#' @param stripAnsi If FALSE, don't strip out Ansi escape sequences before returning
#' terminal buffer.
#'
#' @return The terminal contents, one line per row.
#'
#' @note The \code{terminalBuffer} function was added in version 1.1.305 of RStudio.
#'
#' @export
terminalBuffer <- function(id, stripAnsi = TRUE) {
  callFun("terminalBuffer", id, stripAnsi)
}


#' Kill Terminal
#'
#' Kill processes and close a terminal.
#'
#' @param id The terminal id. The \code{id} is obtained from
#'   \code{\link{terminalList}()}, \code{\link{terminalVisible}()},
#'   \code{\link{terminalCreate}()}, or \code{\link{terminalExecute}()}.
#'
#' @note The \code{terminalKill} function was added in version 1.1.305 of RStudio.
#'
#' @export
terminalKill<- function(id) {
  callFun("terminalKill", id)
}

#' Get Visible Terminal
#'
#' @return Terminal identifier selected in the client, if any.
#'
#' @note The \code{terminalVisible} function was added in version 1.1.305 of RStudio.
#'
#' @export
terminalVisible <- function() {
  callFun("terminalVisible")
}

#' Execute Command
#'
#' Execute a command, showing results in the terminal pane.
#'
#' @param command System command to be invoked, as a character string.
#' @param workingDir Working directory for command
#' @param env Vector of name=value strings to set environment variables
#' @param show If FALSE, terminal won't be brought to front
#'
#' @return The terminal identifier as a character vector (\code{NULL} if
#'   unable to create the terminal).
#'
#' @note The \code{terminalExecute} function was added in version 1.1.305 of RStudio.
#'
#' @examples
#' \dontrun{
#' termId <- rstudioapi::terminalExecute(
#'     command = 'echo $HELLO && echo $WORLD',
#'     workingDir = '/usr/local',
#'     env = c('HELLO=WORLD', 'WORLD=EARTH'))
#' }
#' @export
terminalExecute <- function(command,
                            workingDir = NULL,
                            env = character(),
                            show = TRUE) {
  callFun("terminalExecute", command, workingDir, env, show)
}


#' Terminal Exit Code
#'
#' Get exit code of terminal process, or NULL if still running.
#'
#' @param id The terminal id. The \code{id} is obtained from
#'   \code{\link{terminalList}()}, \code{\link{terminalVisible}()},
#'   ,\code{\link{terminalCreate}()}, or \code{\link{terminalExecute}()}.
#'
#' @return The exit code as an integer vector, or NULL if process still running.
#'
#' @note The \code{terminalExitCode} function was added in version 1.1.305 of RStudio.
#'
#' @export
terminalExitCode <- function(id) {
  callFun("terminalExitCode", id)
}
