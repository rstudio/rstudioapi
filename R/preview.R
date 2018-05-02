#' Preview SQL statement
#'
#' Makes use of 'DBI' and \code{dbGetQuery()} to preview a SQL statement
#' for a given 'DBI' connection.
#'
#' @param conn The 'DBI' connection to be used to execute this statement.
#' @param statement The SQL statement to execute. Either a path to a
#'   file containing a SQL statement or the SQL statement itself.
#' @param ... Additional arguments to be used in \code{dbGetQuery()}.
#'
#' @note The \code{previewSql} function was introduced in RStudio 1.2.600
#'
#' @export
previewSql <- function(conn, statement, ...) {
  callFun("getThemeInfo")
}
