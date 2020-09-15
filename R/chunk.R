#' Register and Unregister a Chunk Callback
#'
#' Register a callback function to be executed after a chunk within an R
#' Markdown document is run.
#'
#' @section Chunk Callbacks:
#' 
#' The `callback` argument should be a function accepting two parameters:
#' 
#' - `chunkName`: The chunk label,
#' - `chunkCode`: The code within the chunk.
#' 
#' The function should return an \R list of HTML outputs, to be displayed after
#' that chunk has been executed.
#' 
#' @param id A unique identifier.
#' 
#' @param callback A callback function. See **Chunk Callbacks** for more details.
#'
#' @return For `registerChunkCallback()`, a unique identifier. That identifier
#'   can be passed to `unreigsterChunkCallback()` to de-register a
#'   previously-registered callback.
#'
#' @name chunk-callbacks
NULL

#' @name chunk-callbacks
#' @export
registerChunkCallback <- function(callback) {
  callFun("registerChunkCallback", callback)
}

#' @name chunk-callbacks
#' @export
unregisterChunkCallback <- function(id = NULL) {
  callFun("unregisterChunkCallback", id)
}
