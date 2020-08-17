
isChildProcess <- function() {
  !is.na(Sys.getenv("RSTUDIOAPI_IPC_REQUESTS_FILE", unset = NA))
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
  if (is.name(call[[1L]]))
    call[[1L]] <- call("::", as.name("rstudioapi"), call[[1L]])

  # ensure arguments are evaluated before sending request
  for (i in seq_along(call)[-1L])
    call[[i]] <- eval(call[[i]], envir = frame)

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
