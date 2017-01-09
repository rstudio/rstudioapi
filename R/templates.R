#' Create a Project Template
#'
#' Create a project template. See
#' \url{https://rstudio.github.io/rstudio-extensions/rstudio_project_templates.html}
#' for more information.
#'
#' @param package The path to an \R package sources.
#' @param binding The \R skeleton function to associate with this project
#'   template. This is the name of the function that will be used to initialize
#'   the project.
#' @param title The title to be shown within the \strong{New Project...} wizard.
#' @param subtitle (optional) The subtitle to be shown within the \strong{New Project...} wizard.
#' @param caption (optional) The caption to be shown on the landing page for this template.
#' @param icon (optional) The path to an icon, on disk, to be used in the dialog. Must be an
#'   \code{.png} of size less than 64KB.
#' @param open_files (optional) Files that should be opened by RStudio when the project is
#'   generated. Shell-style globs can be used to indicate when multiple files
#'   matching some pattern should be opened – for example,  OpenFiles: R/*.R
#'   would indicate that RStudio should open all .R files within the R folder of
#'   the generated project.
#' @param overwrite Boolean; overwrite a pre-existing template file if one exists?
#' @param edit Boolean; open the file for editting after creation?
#' @export
createProjectTemplate <- function(package = ".",
                                  binding,
                                  title,
                                  subtitle = paste("Create a new", title),
                                  caption = paste("Create", title),
                                  icon = NULL,
                                  open_files = NULL,
                                  overwrite = FALSE,
                                  edit = TRUE)
{
  package <- normalizePath(package, winslash = "/", mustWork = TRUE)

  # construct metadata
  metadata <- list(
    Binding   = binding,
    Title     = title,
    Subtitle  = subtitle,
    Caption   = caption,
    Icon      = icon,
    OpenFiles = open_files
  )

  # drop nulls
  metadata <-
    metadata[vapply(metadata, Negate(is.null), FUN.VALUE = logical(1))]

  # create templates directory
  templates_dir <- file.path(package, "inst/rstudio/templates/project")
  if (!dir.create(templates_dir, recursive = TRUE))
    stop(sprintf("failed to create '%s' directory", templates_dir))

  # construct DCF metadata contents
  dcf <- paste(names(metadata), ": ", metadata, sep = "")

  # construct path to file
  name <- gsub("[^a-zA-Z0-9_]", "_", binding)
  path <- file.path(templates_dir, paste(name, "dcf", sep = "."))
  if (file.exists(path) && !overwrite)
    stop(sprintf("a skeleton function already exists at path '%s'", path))

  # write out
  writeLines(dcf, con = path)
  if (edit) file.edit(path)

  TRUE
}
