
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
