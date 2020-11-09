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
#' See the RStudio Server Professional Administration Guide appendix for a list
#' of supported command IDs.
#' 
#' @param commandId The ID of the command to execute.
#' @param quiet Whether to show an error if the command does not exist.
#' @note The \code{executeCommand} function was introduced in RStudio 1.2.1261.
#' @export executeCommand
executeCommand <- function(commandId, quiet = FALSE) {
  callFun("executeCommand", commandId = commandId, quiet = quiet)
}
