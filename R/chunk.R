#' Register Chunk Callback
#'
#' Registers a callback function to be executed after a chunk within an R Markdown document is run.
#'
#' @param callback A callback function that returns a list of html output to be
#' displayed after a chunk is executed. The callback will be passed two parameters; `chunkName` (referring to the chunk label) and `chunkCode` (the code within the chunk).
#' @return A handle that can be used to unregister the chunk.
#' @seealso \code{\link{registerChunkCallback}}
#' @export
registerChunkCallback <- function(callback)
{
  callFun("registerChunkCallback", callback)
}

#' Unregister Chunk Callback
#'
#' Unregister a chunk callback previously registered via `registerChunkCallback()`.
#'
#' @param id A handle, as returned via a previous call to [registerChunkCallback].
#' @seealso \code{\link{registerChunkCallback}}
#' @export
unregisterChunkCallback <- function(id)
{
  callFun("unregisterChunkCallback", id)
}
