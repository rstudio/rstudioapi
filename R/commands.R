#' Execute Command
#' 
#' Executes an arbitrary RStudio command.
#' 
#' Most menu commands and many buttons in RStudio can be invoked from the API
#' using this method.
#' 
#' The \code{quiet} command governs the behavior of the function when the
#' command does not exist. By default, an error is shown if you attempt to
#' invoke a non-existent command. You should set this to \code{TRUE} when
#' invoking a command that may not be available if you don't want your users to
#' see an error.
#' 
#' The command is run asynchronously, so no status is returned.
#' 
#' See the [RStudio Server Professional Administration
#' Guide](https://docs.posit.co/ide/server-pro/reference/rstudio_ide_commands.html)
#' for a list of supported command IDs.
#' 
#' @param commandId The ID of the command to execute.
#' @param quiet Whether to show an error if the command does not exist.
#' @note The \code{executeCommand} function was introduced in RStudio 1.2.1261.
#' @seealso \code{\link{registerCommandCallback}} to be notified of command
#'   executions.
#' @export executeCommand
executeCommand <- function(commandId, quiet = FALSE) {
  response <- callFun("executeCommand", commandId = commandId, quiet = quiet)
  invisible(response)
}

#' Register Command Callback
#' 
#' Registers a callback to be executed when an RStudio command is invoked.
#' 
#' RStudio commands can be invoked from menus, toolbars, keyboard shortcuts,
#' and the Command Palette, as well as the RStudio API. The callback will
#' be executed whenever the command is invoked, regardless of how the
#' invocation was triggered.
#' 
#' See the RStudio Server Professional Administration Guide appendix for a list
#' of supported command IDs.
#' 
#' @details  The callback is executed *after* the command has been run, but as
#'   some commands initiate asynchronous processes, there is no guarantee that
#'   the command has finished its work when the callback is invoked.
#'   
#'   If you're having trouble figuring out the ID of a command you want to listen
#'   for, it can be helpful to discover it by listening to the full command stream; 
#'   see the example in \code{\link{registerCommandStreamCallback}} for details.
#'   
#'   Note that no error will be raised if you use a command ID that does not exist.
#' @param commandId The ID of the command to listen for.
#' @param callback A function to execute when the command is invoked.
#' @returns A handle representing the registration. Pass this handle 
#'   to \code{\link{unregisterCommandCallback}} to unregister the callback.
#' @note The \code{registerCommandCallback} function was introduced in RStudio 1.4.1589.
#' @seealso \code{\link{unregisterCommandCallback}} to unregister the callback, and
#'   \code{\link{registerCommandStreamCallback}} to be notified whenever *any* command
#'   is executed.
#' @examples
#' 
#' \dontrun{
#' # Set up a callback to display an encouraging dialog whenever 
#' # the user knits a document
#' handle <- rstudioapi::registerCommandCallback(
#'   "knitDocument", 
#'   function() {
#'     rstudioapi::showDialog(
#'       "Achievement",
#'       "Congratulations, you have knitted a document. Well done."
#'     )
#'   })
#' 
#' # Knit the document interactively and observe the dialog
#' 
#' # Later: Unregister the callback
#' rstudioapi::unregisterCommandCallback(handle)
#' }
#' 
#' @export registerCommandCallback
registerCommandCallback <- function(commandId, callback) {
  callFun("registerCommandCallback", commandId = commandId, commandCallback = callback)
}

#' Unregister Command Callback
#' 
#' Removes a previously registered command callback.
#' 
#' @param handle The registration handle to remove. 
#' @returns `NULL`, invisibly.
#' @note The \code{unregisterCommandCallback} function was introduced in RStudio 1.4.1589.
#' @export unregisterCommandCallback
unregisterCommandCallback <- function(handle) {
  callFun("unregisterCommandCallback", handle = handle)
}

#' Register Command Stream Callback
#' 
#' Registers a callback to be executed whenever any RStudio command is invoked. 
#' 
#' The callback function will be given a single argument with the ID of the
#' command that was invoked. See the RStudio Server Professional Administration
#' Guide appendix for a list of command IDs.
#' 
#' Note that there is a small performance penalty incurred across the IDE when
#' a command stream listener is present. If you only need to listen to a few
#' specific commands, it is recommended to set up callbacks for them individually
#' using \code{\link{registerCommandCallback}}.
#' 
#' @param callback A function to execute when the command is invoked.
#' @returns A handle representing the registration. Pass this handle 
#'   to \code{\link{unregisterCommandCallback}} to unregister the callback.
#' @note The \code{registerCommandStreamCallback} function was introduced in RStudio 1.4.1589.
#' @seealso \code{\link{unregisterCommandCallback}} to unregister the callback, and
#'   \code{\link{registerCommandCallback}} to be notified whenever a *specific* command
#'   is executed.
#' @examples 
#' 
#' \dontrun{
#' # Set up a callback to print the ID of commands executed to the console.
#' handle <- rstudioapi::registerCommandStreamCallback(function(id) {
#'   message("Command executed: ", id)
#' })
#' 
#' # Later: Unregister the callback
#' rstudioapi::unregisterCommandCallback(handle)
#' }
#' @export registerCommandStreamCallback
registerCommandStreamCallback <- function(callback) {
  callFun("registerCommandCallback", commandId = "*", commandCallback = callback)
}
