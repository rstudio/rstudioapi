
#' Send Text to a Terminal
#'
#' Send text to an existing terminal.
#'
#' @param id The terminal id. The \code{id} is obtained from
#'   \code{\link{terminalList}()}, \code{\link{terminalVisible}()},
#'   \code{\link{terminalCreate}()}, or \code{\link{terminalExecute}()}.
#' @param text Character vector containing text to be inserted.
#'
#' @note The \code{terminalSend} function was added in version 1.1.350 of RStudio.
#'
#' @examples
#' \dontrun{
#' termId <- rstudioapi::terminalCreate()
#' rstudioapi::terminalSend(termId, 'ls -l\n')
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
#' @note The \code{terminalClear} function was added in version 1.1.350 of RStudio.
#'
#' @examples
#' \dontrun{
#' termId <- rstudioapi::terminalCreate()
#' rstudioapi::terminalSend(termId, 'ls -l\n')
#' Sys.sleep(3)
#' rstudioapi::terminalClear(termId)
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
#' @param caption The desired terminal caption. When \code{NULL} or blank,
#' the terminal caption will be chosen by the system.
#' @param show If \code{FALSE}, terminal won't be brought to front.
#' @param shellType Shell type for the terminal: NULL or "default" to use the
#' shell selected in Global Options. For Microsoft Windows, alternatives
#' are "win-cmd" for 64-bit Command Prompt, "win-ps" for 64-bit PowerShell,
#' "win-git-bash" for Git Bash, or "win-wsl-bash" for Bash on Windows Subsystem
#' for Linux. On Linux, Mac, and RStudio Server "custom" will use the custom
#' terminal defined in Global Options. If the requested shell type is not
#' available, the default shell will be used, instead.
#'
#' @return The terminal identifier as a character vector (\code{NULL} if
#'   unable to create the terminal or the given terminal caption is already
#'   in use).
#'
#' @note The \code{terminalCreate} function was added in version 1.1.350 of RStudio
#' and the ability to specify shellType was added in version 1.2.696.
#'
#' @examples
#' \dontrun{
#' termId <- rstudioapi::terminalCreate('My Terminal')
#' }
#'
#' @export
terminalCreate <- function(caption = NULL, show = TRUE, shellType = NULL) {
  if (rstudioapi::getVersion() < "1.2.696") {
    if (!is.null(shellType)) {
      warning('shellType parameter ignored: not supported in this version of RStudio')
    }
    callFun("terminalCreate", caption, show)
  } else {
    callFun("terminalCreate", caption, show, shellType)
  }
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
#' @details  This feature is only supported on RStudio Desktop for Mac and Linux,
#' and RStudio Server. It always returns \code{FALSE} on RStudio Desktop for
#' Microsoft Windows.
#' 
#' @note The \code{terminalBusy} function was added in version 1.1.350 of RStudio.
#'
#' @examples
#' \dontrun{
#' # create a hidden terminal and run a lengthy command
#' termId <- rstudioapi::terminalCreate(show = FALSE)
#' rstudioapi::terminalSend(termId, "sleep 5\n")
#'
#' # wait until a busy terminal is finished
#' while (rstudioapi::terminalBusy(termId)) {
#'   Sys.sleep(0.1)
#' }
#' print("Terminal available")
#' }
#' @export
terminalBusy <- function(id) {
  callFun("terminalBusy", id)
}


#' Is Terminal Running
#'
#' Does a terminal have a process associated with it? If the R session is
#' restarted after a terminal has been created, the terminal will not
#' restart its shell until it is displayed either via the user
#' interface, or via \code{\link{terminalActivate}()}.
#'
#' @param id The terminal id. The \code{id} is obtained from
#'   \code{\link{terminalList}()}, \code{\link{terminalVisible}()},
#'   \code{\link{terminalCreate}()}, or \code{\link{terminalExecute}()}.
#'
#' @return a boolean
#'
#' @note The \code{terminalRunning} function was added in version 1.1.350 of RStudio.
#'
#' @examples
#' \dontrun{
#' # termId has a handle to a previously created terminal
#' # make sure it is still running before we send it a command
#' if (!rstudioapi::terminalRunning(termId)) {
#'    rstudioapi::terminalActivate(termId))
#'
#'    # wait for it to start
#'    while (!rstudioapi::terminalRunning(termId)) {
#'       Sys.sleep(0.1)
#'    }
#'
#'    terminalSend(termId, "echo Hello\n")
#' }
#' }
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
#' @note The \code{terminalList} function was added in version 1.1.350 of RStudio.
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
#' \code{caption} \tab caption\cr
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
#' @note The \code{terminalContext} function was added in version 1.1.350 of RStudio.
#'
#' @examples
#' \dontrun{
#' termId <- rstudioapi::terminalCreate("example", show = FALSE)
#' View(rstudioapi::terminalContext(termId))
#'
#' }
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
#'
#' @note The \code{terminalActivate} function was added in version 1.1.350 of RStudio.
#'
#' @examples
#' \dontrun{
#' # create a hidden terminal and run a lengthy command
#' termId = rstudioapi::terminalCreate(show = FALSE)
#' rstudioapi::terminalSend(termId, "sleep 5\n")
#'
#' # wait until a busy terminal is finished
#' while (rstudioapi::terminalBusy(termId)) {
#'   Sys.sleep(0.1)
#' }
#' print("Terminal available")#'
#'
#' rstudioapi::terminalActivate(termId)
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
#' @note The \code{terminalBuffer} function was added in version 1.1.350 of RStudio.
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
#' @note The \code{terminalKill} function was added in version 1.1.350 of RStudio.
#'
#' @export
terminalKill<- function(id) {
  callFun("terminalKill", id)
}

#' Get Visible Terminal
#'
#' @return Terminal identifier selected in the client, if any.
#'
#' @note The \code{terminalVisible} function was added in version 1.1.350 of RStudio.
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
#' @note The \code{terminalExecute} function was added in version 1.1.350 of RStudio.
#'
#' @examples
#' \dontrun{
#' termId <- rstudioapi::terminalExecute(
#'   command = 'echo $HELLO && echo $WORLD',
#'   workingDir = '/usr/local',
#'   env = c('HELLO=WORLD', 'WORLD=EARTH'),
#'   show = FALSE)
#'
#' while (is.null(rstudioapi::terminalExitCode(termId))) {
#'   Sys.sleep(0.1)
#' }
#'
#' result <- terminalBuffer(termId)
#' terminalKill(termId)
#' print(result)
#' }
#'
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
#' @note The \code{terminalExitCode} function was added in version 1.1.350 of RStudio.
#'
#' @export
terminalExitCode <- function(id) {
  callFun("terminalExitCode", id)
}
