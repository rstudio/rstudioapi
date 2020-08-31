#' Register Chunk Callback
#'
#' Registers a callback function to be executed after a specified chunk
#'
#' @param callback A callback function that returns a list of html output to be
#' displayed after a chunk is executed.
#' @return A handler that can be used to unregister the chunk.
#' @export
registerChunkCallback <- function(callback)
{
  callFun("registerChunkCallback", callback)
}

#' Unregister Chunk Callback
#'
#' Unregister a chunk callback
#'
#' @param id The handle returned when the callback was registered
#' @export
unregisterChunkCallback <- function(id)
{
  callFun("unregisterChunkCallback", id)
}
