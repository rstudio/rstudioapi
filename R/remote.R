
#' Detect RStudio Jobs
#' 
#' Use this function to detect whether RStudio is running an R "job".
#' These jobs are normally used for actions taken in the Jobs tab, as well
#' as within the \R build pane.
#' 
#' `isWorkbenchJob()` is used to detect scripts which have been launched as
#' Workbench jobs, and is only available in RStudio Workbench 2024.04 or newer.
#' These jobs use the RStudio Launcher to run \R scripts on remote clusters, as
#' opposed to `isBackgroundJob()`, which is used to detect background jobs
#' which are run on the local machine.
#' 
#' This function is primarily intended to be used by package authors, who
#' need to customize the behavior of their methods when run within an
#' RStudio job.
#' 
#' @return Boolean; `TRUE` if this is an RStudio job.
#' 
#' @export
isJob <- function() {
  isBackgroundJob() || isWorkbenchJob()
}

#' @name isJob
#' @export
isBackgroundJob <- function() {
  !is.na(Sys.getenv("RSTUDIOAPI_IPC_REQUESTS_FILE", unset = NA))
}

#' @name isJob
#' @export
isWorkbenchJob <- function() {
  identical(Sys.getenv("RSTUDIO_WORKBENCH_JOB"), "1")
}

callRemote <- function(call, frame) {

  # check for active request / response
  requestFile  <- Sys.getenv("RSTUDIOAPI_IPC_REQUESTS_FILE", unset = NA)
  responseFile <- Sys.getenv("RSTUDIOAPI_IPC_RESPONSE_FILE", unset = NA)
  secret   <- Sys.getenv("RSTUDIOAPI_IPC_SHARED_SECRET", unset = NA)
  if (is.na(requestFile) || is.na(responseFile) || is.na(secret))
    stop("internal error: callRemote() called without remote connection")
  
  # clean up on exit
  on.exit(unlink(c(requestFile, responseFile)), add = TRUE)

  # remove srcrefs (un-needed for serialization here)
  attr(call, "srcref") <- NULL

  # ensure rstudioapi functions get appropriate prefix
  if (is.name(call[[1L]])) {
    call_fun <- call("::", as.name("rstudioapi"), call[[1L]])
  } else {
    call_fun <- call[[1L]]
  }
  
  # ensure arguments are evaluated before sending request
  call[[1L]] <- quote(base::list)
  args <- eval(call, envir = frame)
  
  call <- as.call(c(call_fun, args))

  # write to tempfile and rename, to ensure atomicity
  data <- list(secret = secret, call = call)
  tmp <- tempfile(tmpdir = dirname(requestFile))
  saveRDS(data, file = tmp)
  file.rename(tmp, requestFile)

  # loop until response is ready (poll)
  # in theory we'd just do a blocking read but there isn't really a good
  # way to do this in a cross-platform way without additional dependencies
  now <- Sys.time()
  repeat {

    # check for response
    if (file.exists(responseFile))
      break

    # check for lack of response
    diff <- difftime(Sys.time(), now, units = "secs")
    if (diff > 10)
      stop("RStudio did not respond to rstudioapi IPC request")

    # wait a bit
    Sys.sleep(0.1)

  }

  # read response
  response <- readRDS(responseFile)
  if (inherits(response, "error"))
    stop(response)

  response

}
