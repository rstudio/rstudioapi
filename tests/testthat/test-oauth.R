test_that("OAuth functions fail gracefully outside Workbench", {
  withr::local_envvar(
    POSIT_PRODUCT = NA,
    RS_SERVER_ADDRESS = NA
  )

  expect_error(
    getOAuthCredentials("4c1cfecb-1927-4f19-bc2f-d8ac261364e0"),
    "This functionality is only available within Posit Workbench sessions"
  )

  expect_error(
    getOAuthIntegrations(),
    "This functionality is only available within Posit Workbench sessions"
  )

  expect_error(
    getOAuthIntegration("test-guid"),
    "This functionality is only available within Posit Workbench sessions"
  )
})

test_that("OAuth functions require minimum version", {
  withr::local_envvar(
    RS_SERVER_ADDRESS = "http://localhost:8787",
    RSTUDIO_VERSION = "2024.01.0"
  )

  expect_error(
    getOAuthCredentials("4c1cfecb-1927-4f19-bc2f-d8ac261364e0"),
    "This API is not available in Posit Workbench version 2024.01.0\\. Please upgrade to version 2026\\.01\\.0 or later\\."
  )

  expect_error(
    getOAuthIntegrations(),
    "This API is not available in Posit Workbench version 2024.01.0\\. Please upgrade to version 2026\\.01\\.0 or later\\."
  )
})

test_that("OAuth functions handle missing RPC cookie", {
  withr::local_envvar(
    RS_SERVER_ADDRESS = "http://localhost:8787",
    RSTUDIO_VERSION = "2026.01.0",
    RS_SESSION_RPC_COOKIE = NA,
    PWB_SESSION_RUNTIME_DIR = NA
  )

  expect_error(
    getOAuthCredentials("4c1cfecb-1927-4f19-bc2f-d8ac261364e0"),
    "RPC cookie not found"
  )

  expect_error(
    getOAuthIntegrations(),
    "RPC cookie not found"
  )
})

test_that("OAuth functions allow dev versions", {
  withr::local_envvar(
    RS_SERVER_ADDRESS = "http://localhost:8787",
    RSTUDIO_VERSION = "2024.01.0-dev",
    RS_SESSION_RPC_COOKIE = "test-cookie"
  )

  # Should not error about version requirement (will error about connection, but that's OK)
  # Error message may vary: "HTTP request failed", "Could not resolve host", "Failed to connect", etc.
  expect_error(
    getOAuthCredentials("4c1cfecb-1927-4f19-bc2f-d8ac261364e0"),
    class = "error"
  )
})

test_that("getOAuthIntegration validates guid parameter", {
  expect_error(
    getOAuthIntegration(),
    "guid must be a non-empty character string"
  )

  expect_error(
    getOAuthIntegration(""),
    "guid must be a non-empty character string"
  )

  expect_error(
    getOAuthIntegration(123),
    "guid must be a non-empty character string"
  )

  expect_error(
    getOAuthIntegration(c("guid1", "guid2")),
    "guid must be a non-empty character string"
  )
})

test_that("getOAuthCredentials validates GUID format", {
  expect_error(
    getOAuthCredentials("not-a-guid"),
    "audience must be a valid GUID"
  )

  expect_error(
    getOAuthCredentials("4c1cfecb19274f19bc2fd8ac261364e0"),
    "audience must be a valid GUID"
  )

  expect_error(
    getOAuthCredentials("4c1cfecb-1927-4f19-bc2f-d8ac26136"),
    "audience must be a valid GUID"
  )
})

test_that("getIdentityToken fails gracefully outside Workbench", {
  withr::local_envvar(
    POSIT_PRODUCT = NA,
    RS_SERVER_ADDRESS = NA
  )

  expect_error(
    getIdentityToken(),
    "This functionality is only available within Posit Workbench sessions"
  )
})

test_that("getIdentityToken handles missing RPC cookie", {
  withr::local_envvar(
    RS_SERVER_ADDRESS = "http://localhost:8787",
    RS_SESSION_RPC_COOKIE = NA,
    PWB_SESSION_RUNTIME_DIR = NA
  )

  expect_error(
    getIdentityToken(),
    "RPC cookie not found"
  )
})
