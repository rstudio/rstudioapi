#' Register Chunk Callback
#'
#' Registers a callback function to be executed after a specified chunk
#'
#' @param chunkName A className of an existing chunk.
#' @param chunkCode The code within the specified chunk that when ran will trigger this callback.
#'   Leave this empty to only execute the callback when the full chunk is ran.
#' @param result An object representing what the user sees. ?????
#' @param callback A list of callbacks to execute after the specified code.
#' @export
registerChunkCallback <- function(chunkName, chunkCode, result, callbacks)
{
  callFun("registerChunkCallback", chunkName, chunkCode, result, callbacks)
}
registerChunkCallback <- function(callbackFunction)
{
  callFun("registerChunkCallback", callbackFunction)
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
