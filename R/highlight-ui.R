
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
#' rstudioapi::highlightUi("#rstudio_tb_savesourcedoc")
#' ```
#' 
#' In some cases, multiple UI elements need to be highlighted -- e.g. if
#' you want to highlight both a menu button, and a menu item within the
#' menu displayed after the button is pressed. We'll use the Environment Pane's
#' Import Dataset button as an example. To highlight the `From Text (readr)`
#' command, you might use:
#' 
#' ```
#' rstudioapi::highlightUi(
#'   list(
#'     list(query = "#rstudio_mb_import_dataset", parent = 0L),
#'     list(query = "#rstudio_label_from_text_readr_command", parent = 1L)
#'    )
#' )
#' ```
#' 
#' @note The \code{highlightUi} function was introduced in RStudio 1.3.658.
#' 
#' @param queries A list of "query" objects. Each query should be a list with
#'   entries `"query"` and `"parent"`. See **Queries** for more details.
#' @export
#' @examples
#' \dontrun{rstudioapi::highlightUi("#rstudio_workbench_panel_git")}
#' 
#' # clear current highlights
#' \dontrun{rstudioapi::highlightUi("")}
#' 
#' # highlight within an RMD
#' \dontrun{rstudioapi::highlightUi(".rstudio_chunk_setup .rstudio_run_chunk")}
#' 
#' # Optionally provide a callback adjacent to 
#' # the queries that will be executed when the 
#' # highlighted element is clicked on.
#' \dontrun{rstudioapi::highlightUi(
#'   list(
#'     list(
#'       query="#rstudio_workbench_panel_git", 
#'       callback="rstudioapi::highlightUi('')"
#'     )
#'   )
#' )}
highlightUi <- function(queries) {
  
  queries <- lapply(queries, function(data) {
    
    if (is.character(data))
      data <- list(query = data, parent = 0L)
    
    if (is.null(data$query))
      stop("missing 'query' in highlight request")
    
    data$highlight <- as.integer(data$highlight %||% 0)
    data
    
  })
  
  invisible(callFun("highlightUi", queries))
  
}
