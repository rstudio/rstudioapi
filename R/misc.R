#' @importFrom utils capture.output
formatText <- function(text, n = 20L, truncated = "<...>") {

  result <- if (nchar(text) < n)
    text
  else
    paste(text, truncated)

  # use capture.output and print.default to escape e.g. newlines
  captured <- capture.output(print.default(result, quote = FALSE))
  substring(captured, 5)
}
