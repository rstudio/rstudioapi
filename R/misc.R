#' @importFrom utils capture.output
formatText <- function(text, n = 20L, truncated = "<...>") {

  result <- if (nchar(text) < n)
    text
  else
    paste(text, truncated)

  encodeString(result)
}
