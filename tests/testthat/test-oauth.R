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

test_that("getDelegatedAzureToken validates the 'as' parameter", {
  expect_error(
    getDelegatedAzureToken("https://storage.azure.com", as = "oops"),
    "'arg' should be one of"
  )
})

test_that("normalizeDelegatedAzureToken converts expires_in to expires_at", {
  token <- list(
    access_token = "abc123",
    expires_in = 3600,
    ext_expires_in = 3600
  )

  before <- as.numeric(Sys.time())
  normalized <- normalizeDelegatedAzureToken(token)
  after <- as.numeric(Sys.time())

  expect_null(normalized$expires_in)
  expect_null(normalized$ext_expires_in)
  expect_gte(normalized$expires_at, before + 3600)
  expect_lte(normalized$expires_at, after + 3600)

  # Tokens that already carry expires_at are left alone
  token <- list(access_token = "abc123", expires_at = 42)
  expect_identical(normalizeDelegatedAzureToken(token), token)
})

test_that("asDelegatedAzureToken returns an AzureToken-compatible object", {
  skip_if_not_installed("R6")

  token <- list(
    access_token = "abc123",
    scope = "https://graph.microsoft.com/.default",
    expires_at = as.numeric(Sys.time()) + 3600
  )

  obj <- asDelegatedAzureToken(token, "https://graph.microsoft.com/")

  # AzureAuth::is_azure_token() checks R6-ness and the class name
  expect_true(R6::is.R6(obj))
  expect_s3_class(obj, "AzureToken")

  expect_identical(obj$resource, "https://graph.microsoft.com/")
  expect_identical(obj$version, 1)
  expect_identical(obj$credentials$access_token, "abc123")
  expect_identical(obj$credentials$token_type, "Bearer")
  expect_identical(
    obj$credentials$expires_on,
    as.character(round(token$expires_at))
  )

  expect_true(obj$validate())
  expect_true(obj$can_refresh())
  expect_output(print(obj), "Delegated Azure token")
})

test_that("delegated AzureToken objects fail validation once expired", {
  skip_if_not_installed("R6")

  token <- list(
    access_token = "abc123",
    expires_at = as.numeric(Sys.time()) - 10
  )

  obj <- asDelegatedAzureToken(token, "https://graph.microsoft.com/")
  expect_false(obj$validate())
})

test_that("delegated AzureToken refresh requests a new token", {
  skip_if_not_installed("R6")

  token <- list(
    access_token = "old-token",
    expires_at = as.numeric(Sys.time()) - 10
  )
  obj <- asDelegatedAzureToken(token, "https://graph.microsoft.com/")

  local_mocked_bindings(
    getDelegatedAzureToken = function(resource, as = "list") {
      list(
        access_token = paste0("new-token-for-", resource),
        expires_at = as.numeric(Sys.time()) + 3600
      )
    }
  )

  obj$refresh()
  expect_identical(
    obj$credentials$access_token,
    "new-token-for-https://graph.microsoft.com/"
  )
  expect_true(obj$validate())
})
