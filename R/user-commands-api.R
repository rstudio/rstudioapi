#' Register and Bind a Command
#'
#' Bind the execution of an \R function to a keyboard shortcut.
#'
#' @param name The name to assign to the command. This should be unique.
#' @param shortcuts A character vector, indicating what keys the command should
#'   be bound to. See \bold{Keyboard Shortcuts} for more information.
#' @param fn An \R function, currently accepting zero arguments, although this
#'   may change in the future. For compatibility with future versions of
#'   RStudio, you should ensure that your function accepts \code{...}.
#' @param overwrite If \code{TRUE} and another command with the name \code{name}
#'   is already registered, that command will be overwritten.
#'
#' @section Keyboard Shortcuts:
#'
#' \code{shortcuts} should be a combination of the modifiers e.g.
#' \code{Ctrl}, \code{Alt}, \code{Shift}, \code{Cmd}, \code{Meta}, and
#' an ASCII key. Note that non-ASCII keys may not map correctly on international
#' keyboard layouts. \emph{Sequences} of keys can be bound to a command by
#' separating key combinations with a single space. Some examples:
#'
#' \preformatted{
#'     "Ctrl+Alt+S"     # control, alt, and S keys pressed together
#'     "Ctrl+X Ctrl+S"  # control and X pressed together, followed by control and S
#' }
#'
#' Note that these bindings will take precedence over any pre-existing bindings.
#'
#' @examples
#' \dontrun{
#'    rstudioapi::registerCommand("hello", "Ctrl+Alt+Shift+K", function(...) {
#'       print("Hello, world!")
#'    })
#' }
#' @export
registerCommand <- function(name, shortcuts, fn, overwrite = TRUE) {
  callFun("registerCommand", name, shortcuts, fn, overwrite)
}
