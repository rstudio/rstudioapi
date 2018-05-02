#' Preview SQL statement
#'
#' Makes use of 'DBI' and \code{dbGetQuery()} to execute for proview
#' a SQL statement for a given 'DBI' connection.
#'
#' @param conn The 'DBI' connection to be used to execute this statement.
#' @param statement The SQL stament to execute. Either a path to a
#'   file containing a SQL statement or the SQL statement itself.
#' @param ... Additional arguments to be used in \code{dbGetQuery()}.
#'
#' Available from RStudio 1.2.600.
#'
#' @export
previewSql <- function(conn, statement, ...) {
  callFun("getThemeInfo")
}
