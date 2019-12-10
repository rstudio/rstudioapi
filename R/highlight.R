
#' Highlight UI Elements within the RStudio IDE
#' 
#' This function can be used to highlight UI elements within the RStudio IDE.
#' UI elements can be selected using query selectors; most commonly, one should
#' choose to highlight elements based on their IDs when available.
#'
#' The tool at:
#'
#' ``` 
#' Help -> Diagnostics -> Show DOM Elements
#' ```
#' 
#' can be useful for identifying the classes and IDs assigned to the different
#' elements within RStudio.
#'
#' @section Queries:
#' 
#' Elements are selected using the same queries as through the web
#' `querySelectorAll()` API. See <https://developer.mozilla.org/en-US/docs/Web/API/Document/querySelectorAll>
#' for more details.
#'
#' For example, to highlight the Save icon within the Source pane, one might
#' use:
#' 
#' ```
#' 
#' ```
#' 
#' @note The \code{executeCommand} function was introduced in RStudio 1.3.658.
#' 
#' @param queries A list of "query" objects. Each query should be a list with
#'   entries `"query"` and `"parent"`. See **Queries** for more details.
#'
#' @export
highlightUi <- function(queries) {
  callFun("highlight")
}
