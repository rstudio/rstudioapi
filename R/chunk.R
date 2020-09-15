#' Register Chunk Callback
#'
#' Registers a callback function to be executed after a chunk within an R Markdown document is run.
#' Only one callback can be registered at a time, \code{\link{unregisterChunkCallback}} must be called to 
#' unregister the callback between registrations.
#'
#' @param callback A callback function that returns a named list containing html output in the
#' member 'html' to be displayed after a chunk is executed. The callback will be passed two
#' parameters; `chunkName` (referring to the chunk label) and `chunkCode` (the code within the chunk).
#' @return A handle that can be used to unregister the chunk.
#' @seealso \code{\link{unregisterChunkCallback}}
#' @export
registerChunkCallback <- function(callback)
{
  callFun("registerChunkCallback", callback)
}

#' Unregister Chunk Callback
#'
#' Unregister a chunk callback previously registered via `registerChunkCallback()`.
#'
#' @param id A handle, as returned via a previous call to [registerChunkCallback]
#'  or do not include to unregister current callback.
#' @seealso \code{\link{registerChunkCallback}}
#' @export
unregisterChunkCallback <- function(id = NULL)
{
  callFun("unregisterChunkCallback", id)
}
