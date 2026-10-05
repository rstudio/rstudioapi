
# Simulates the RStudio side of the IPC transport in a separate R process:
# waits for a request, answers it with 'responder', and exits. Returns the
# path to a file the server writes its own diagnostics to.
startFakeServer <- function(requestFile, responseFile, secret, version, error = FALSE) {

  script <- tempfile("rstudioapi-fake-server-", fileext = ".R")
  log <- tempfile("rstudioapi-fake-server-", fileext = ".log")

  code <- substitute({

    deadline <- Sys.time() + 20
    while (!file.exists(requestFile) && Sys.time() < deadline)
      Sys.sleep(0.05)

    if (version >= 2) {
      ticket <- readLines(requestFile)
      fields <- strsplit(ticket[-1], "=", fixed = TRUE)
      ticket <- setNames(
        vapply(fields, `[[`, 2L, FUN.VALUE = ""),
        vapply(fields, `[[`, 1L, FUN.VALUE = "")
      )
      call <- readRDS(paste(requestFile, "payload", sep = "."))
      ok <- identical(ticket[["secret"]], secret)
      response <- if (error)
        list(id = ticket[["id"]], error = simpleError("boom"))
      else
        list(id = ticket[["id"]], value = list(ok = ok, call = call))
    } else {
      data <- readRDS(requestFile)
      ok <- identical(data[["secret"]], secret)
      response <- list(ok = ok, call = data[["call"]])
    }

    # write in place (not atomically), as older RStudio versions do, so the
    # client must tolerate reading a partially-written file
    saveRDS(response, file = responseFile)
    writeLines("done", log)

  }, list(
    requestFile = requestFile,
    responseFile = responseFile,
    secret = secret,
    version = version,
    error = error,
    log = log
  ))

  writeLines(deparse(code), script)
  rscript <- file.path(R.home("bin"), "Rscript")
  system2(rscript, shQuote(script), wait = FALSE, stdout = FALSE, stderr = FALSE)

  log

}

withIpcEnvironment <- function(version, secret, expr) {

  dir <- tempfile("rstudioapi-ipc-")
  dir.create(dir)
  on.exit(unlink(dir, recursive = TRUE), add = TRUE)

  requestFile <- file.path(dir, "requests.rds")
  responseFile <- file.path(dir, "response.rds")

  old <- Sys.getenv(
    c("RSTUDIOAPI_IPC_REQUESTS_FILE", "RSTUDIOAPI_IPC_RESPONSE_FILE", "RSTUDIOAPI_IPC_VERSION"),
    unset = NA
  )
  on.exit({
    for (name in names(old)) {
      if (is.na(old[[name]])) Sys.unsetenv(name) else do.call(Sys.setenv, as.list(old[name]))
    }
  }, add = TRUE)

  Sys.setenv(
    RSTUDIOAPI_IPC_REQUESTS_FILE = requestFile,
    RSTUDIOAPI_IPC_RESPONSE_FILE = responseFile
  )
  if (version >= 2) Sys.setenv(RSTUDIOAPI_IPC_VERSION = version) else Sys.unsetenv("RSTUDIOAPI_IPC_VERSION")

  oldOptions <- options(rstudioapi.ipc.secret = secret, rstudioapi.remote.timeout = 15)
  on.exit(options(oldOptions), add = TRUE)

  expr(requestFile, responseFile)

}

test_that("version 2 requests are written as a ticket plus payload and matched by id", {

  withIpcEnvironment(2L, "s3cret", function(requestFile, responseFile) {

    startFakeServer(requestFile, responseFile, "s3cret", 2L)

    # a stale response from an earlier request must be ignored, not returned
    saveRDS(list(id = "stale", value = "stale"), responseFile)

    result <- callRemote(quote(versionInfo(1, x = "two")), environment())
    expect_true(result$ok)
    expect_identical(result$call, quote(rstudioapi::versionInfo(1, x = "two")))

    # the transport cleans up after itself
    expect_false(file.exists(requestFile))
    expect_false(file.exists(paste(requestFile, "payload", sep = ".")))
    expect_false(file.exists(responseFile))

  })

})

test_that("version 1 requests are used when RStudio doesn't advertise a newer protocol", {

  withIpcEnvironment(1L, "s3cret", function(requestFile, responseFile) {

    startFakeServer(requestFile, responseFile, "s3cret", 1L)

    result <- callRemote(quote(rstudioapi::versionInfo()), environment())
    expect_true(result$ok)
    expect_identical(result$call, quote(rstudioapi::versionInfo()))
    expect_false(file.exists(requestFile))
    expect_false(file.exists(responseFile))

  })

})

test_that("version 2 errors from RStudio are re-raised in the client", {

  withIpcEnvironment(2L, "s3cret", function(requestFile, responseFile) {
    startFakeServer(requestFile, responseFile, "s3cret", 2L, error = TRUE)
    expect_error(callRemote(quote(versionInfo()), environment()), "boom")
  })

})

test_that("callRemote() times out when RStudio doesn't answer", {

  withIpcEnvironment(2L, "s3cret", function(requestFile, responseFile) {
    options(rstudioapi.remote.timeout = 0.5)
    expect_error(
      callRemote(quote(versionInfo()), environment()),
      "did not respond"
    )
  })

})

test_that("callRemote() refuses to run without a secret", {

  withIpcEnvironment(2L, NA, function(requestFile, responseFile) {
    old <- Sys.getenv("RSTUDIOAPI_IPC_SHARED_SECRET", unset = NA)
    on.exit(if (is.na(old)) Sys.unsetenv("RSTUDIOAPI_IPC_SHARED_SECRET") else Sys.setenv(RSTUDIOAPI_IPC_SHARED_SECRET = old))
    Sys.unsetenv("RSTUDIOAPI_IPC_SHARED_SECRET")

    expect_error(
      callRemote(quote(versionInfo()), environment()),
      "no rstudioapi IPC credentials"
    )
  })

})

test_that(".onLoad() moves the IPC secret out of the environment", {

  old <- Sys.getenv("RSTUDIOAPI_IPC_SHARED_SECRET", unset = NA)
  oldOptions <- options(rstudioapi.ipc.secret = NULL)
  on.exit({
    options(oldOptions)
    if (is.na(old)) Sys.unsetenv("RSTUDIOAPI_IPC_SHARED_SECRET") else Sys.setenv(RSTUDIOAPI_IPC_SHARED_SECRET = old)
  }, add = TRUE)

  Sys.setenv(RSTUDIOAPI_IPC_SHARED_SECRET = "s3cret")
  .onLoad(NULL, "rstudioapi")

  expect_identical(Sys.getenv("RSTUDIOAPI_IPC_SHARED_SECRET", unset = NA), NA_character_)
  expect_identical(getOption("rstudioapi.ipc.secret"), "s3cret")
  expect_identical(ipcSecret(), "s3cret")

})
