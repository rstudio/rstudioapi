
`%||%` <- function(x, y) {
  if (is.null(x)) y else x
}

renderTemplate <- function(template, data) {

  rendered <- template

  for (i in seq_along(data)) {
    key <- names(data)[[i]]
    val <- data[[i]]
    fkey <- sprintf("${%s}", key)
    rendered <- gsub(fkey, val, rendered, fixed = TRUE)
  }

  rendered

}

checkApiArguments <- function(fname, f, args) {

  # check for arguments supplied by the user that aren't available
  # in the current version of RStudio
  unsupportedArgNames <- setdiff(names(args), names(formals(f)))
  if (length(unsupportedArgNames) == 0L)
    return(args)

  # check which of these arguments is NULL; if all arguments are NULL,
  # then we accept the call
  isNullArg <- vapply(args[unsupportedArgNames], is.null, FUN.VALUE = logical(1))
  badArgNames <- names(isNullArg)[!isNullArg]
  if (length(badArgNames) == 0L) {
    args[unsupportedArgNames] <- NULL
    return(args)
  }

  # if we get here, the user tried to supply a value for a parameter that isn't
  # supported in this version of RStudio; emit an error
  fmt <- ifelse(
    length(badArgNames) == 1L,
    "Parameter %s is not supported by %s in this version of RStudio.",
    "Parameters %s are not supported by %s in this version of RStudio."
  )

  msg <- sprintf(fmt, paste(shQuote(badArgNames), collapse = ", "), shQuote(fname))
  stop(msg, call. = FALSE)

}
