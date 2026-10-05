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

# IPC with the parent RStudio session
#
# When RStudio launches an R process (e.g. a background job), it hands the
# process a request path, a response path and a shared secret via environment
# variables. rstudioapi calls made from that process are serialized into a
# request file; RStudio picks the request up while polling the job, evaluates
# the call, and writes a response file.
#
# RStudio advertises the newest request format it accepts through the
# RSTUDIOAPI_IPC_VERSION environment variable:
#
# - Version 1 (unset): the request is a single RDS payload containing both the
#   secret and the call, and the response is the bare result.
#
# - Version 2: the request is a plain-text ticket (magic line, then
#   'key=value' lines for version, secret and id) and the call is written to a
#   sibling '<request>.payload' file. RStudio checks the secret before
#   deserializing anything, and the response is list(id, value) or
#   list(id, error), so a stale response can be told apart from the real one.
#
# The shared secret is moved out of the environment into an R option when the
# package loads (see .onLoad), so processes spawned by the job can't use it to
# call back into the IDE. The request and response paths stay put, since they
# only identify the job and other packages use them to detect jobs.

ipcSecret <- function() {
  secret <- getOption("rstudioapi.ipc.secret", default = NA)
  if (is.na(secret))
    secret <- Sys.getenv("RSTUDIOAPI_IPC_SHARED_SECRET", unset = NA)
  secret
}

ipcVersion <- function() {
  version <- Sys.getenv("RSTUDIOAPI_IPC_VERSION", unset = "1")
  version <- suppressWarnings(as.integer(version))
  if (is.na(version)) 1L else version
}

ipcRequestId <- function() {
  # tempfile() gives us a unique token without touching the user's RNG
  basename(tempfile(paste0("rstudioapi-", Sys.getpid(), "-")))
}

# Write 'writer(path)' output into a sibling temporary file, then rename it
# into place, so the reader never observes a partially-written file.
ipcWriteAtomic <- function(path, writer) {
  tmp <- tempfile(tmpdir = dirname(path))
  on.exit(unlink(tmp), add = TRUE)
  writer(tmp)
  if (!file.rename(tmp, path))
    stop("failed to write rstudioapi IPC file '", path, "'")
  invisible(path)
}

# Poll until 'responseFile' holds a response that 'accept' is happy with, or
# the timeout elapses. Unreadable or rejected responses are discarded and the
# poll continues, so a half-written or stale file never masquerades as ours.
ipcAwaitResponse <- function(responseFile, accept) {

  # in theory we'd just do a blocking read but there isn't really a good
  # way to do this in a cross-platform way without additional dependencies
  now <- Sys.time()
  timeout <- getOption("rstudioapi.remote.timeout", default = 10)
  repeat {

    if (file.exists(responseFile)) {
      response <- tryCatch(readRDS(responseFile), error = function(e) NULL)
      if (!is.null(response) && accept(response))
        return(response)
      if (!is.null(response))
        unlink(responseFile)
    }

    diff <- difftime(Sys.time(), now, units = "secs")
    if (diff > timeout)
      stop("RStudio did not respond to rstudioapi IPC request")

    Sys.sleep(0.1)

  }

}

callRemote <- function(call, frame) {

  # check for active request / response
  requestFile  <- Sys.getenv("RSTUDIOAPI_IPC_REQUESTS_FILE", unset = NA)
  responseFile <- Sys.getenv("RSTUDIOAPI_IPC_RESPONSE_FILE", unset = NA)
  if (is.na(requestFile) || is.na(responseFile))
    stop("internal error: callRemote() called without remote connection")

  secret <- ipcSecret()
  if (is.na(secret)) {
    stop("this R process has no rstudioapi IPC credentials; only the R ",
         "process launched by RStudio itself can call back into the IDE")
  }

  # remove srcrefs (un-needed for serialization here)
  attr(call, "srcref") <- NULL

  # ensure rstudioapi functions get appropriate prefix
  callFun <- if (is.name(call[[1L]])) {
     call("::", as.name("rstudioapi"), call[[1L]])
  } else {
    call[[1L]]
  }
  
  # ensure arguments are evaluated before sending request
  call[[1L]] <- quote(base::list)
  args <- eval(call, envir = frame)
  
  call <- as.call(c(callFun, args))

  if (ipcVersion() >= 2L)
    callRemoteV2(call, requestFile, responseFile, secret)
  else
    callRemoteV1(call, requestFile, responseFile, secret)

}

callRemoteV2 <- function(call, requestFile, responseFile, secret) {

  id <- ipcRequestId()
  payloadFile <- paste(requestFile, "payload", sep = ".")
  on.exit(unlink(c(requestFile, payloadFile, responseFile)), add = TRUE)

  # the payload goes first and the ticket last: RStudio only looks for the
  # ticket, so a complete ticket implies a complete payload
  ipcWriteAtomic(payloadFile, function(path) {
    saveRDS(call, file = path)
  })

  ticket <- c(
    "rstudioapi-ipc",
    "version=2",
    paste0("secret=", secret),
    paste0("id=", id)
  )

  ipcWriteAtomic(requestFile, function(path) {
    writeLines(ticket, con = path)
  })

  response <- ipcAwaitResponse(responseFile, function(response) {
    is.list(response) && identical(response$id, id)
  })

  if ("error" %in% names(response))
    stop(response$error)

  response$value

}

callRemoteV1 <- function(call, requestFile, responseFile, secret) {

  on.exit(unlink(c(requestFile, responseFile)), add = TRUE)

  data <- list(secret = secret, call = call)
  ipcWriteAtomic(requestFile, function(path) {
    saveRDS(data, file = path)
  })

  # older RStudio versions write the response in place, so accept whatever
  # readRDS() manages to read and retry while the file is being written
  response <- ipcAwaitResponse(responseFile, function(response) TRUE)
  if (inherits(response, "error"))
    stop(response)

  response

}
