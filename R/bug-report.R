#' File an RStudio Bug Report
#' 
#' A utility function to assist with the filing of an RStudio bug report. This
#' function will pre-populate a template with information useful in
#' understanding your reported bug.
#' 
#' 
#' @export bugReport
bugReport <- function() {

  verifyAvailable()

  rstudioInfo <- versionInfo()
  rstudioVersion <- format(rstudioInfo$version)

  rstudioEdition <- sprintf(
    "%s [%s]",
    if (rstudioInfo$mode == "desktop") "Desktop" else "Server",
    if (is.null(rstudioInfo$edition)) "Open Source" else toupper(rstudioInfo$edition)
  )

  rInfo <- utils::sessionInfo()
  rVersion <- rInfo$R.version$version.string
  rVersion <- sub("^R version", "", rVersion, fixed = TRUE)
  osVersion <- rInfo$running

  templateFile <- system.file("resources/bug-report.md", package = "rstudioapi")
  template <- readLines(templateFile)
  rendered <- renderTemplate(template, list(
    RSTUDIO_VERSION = rstudioVersion,
    RSTUDIO_EDITION = rstudioEdition,
    OS_VERSION      = osVersion,
    R_VERSION       = rVersion
  ))

  if (rstudioInfo$mode == "desktop" && requireNamespace("clipr", quietly = TRUE)) {
    clipr::write_clip(rendered)
    writeLines("* The bug report template has been written to the clipboard.")
    writeLines("* Please paste the clipboard contents into the issue comment section,")
    writeLines("* and then fill out the rest of the issue details.")
  } else {
    header <- "<!-- Please copy and paste this text to the GitHub issue page. -->"
    text <- c(header, rendered)
    file <- tempfile("rstudio-bug-report-", fileext = ".html")
    on.exit(unlink(file), add = TRUE)
    writeLines(text, con = file)
    utils::file.edit(file)
  }

  url <- "https://github.com/rstudio/rstudio/issues/new"
  utils::browseURL(url)

}
