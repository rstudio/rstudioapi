context("OAuth API")

test_that("getOAuthCredentials fails gracefully outside Workbench", {
  # Save current environment
  old_posit_product <- Sys.getenv("POSIT_PRODUCT")

  # Temporarily unset POSIT_PRODUCT
  Sys.unsetenv("POSIT_PRODUCT")

  expect_error(
    getOAuthCredentials("test-integration"),
    "OAuth functionality is only available within Posit Workbench sessions"
  )

  # Restore environment
  if (nzchar(old_posit_product)) {
    Sys.setenv(POSIT_PRODUCT = old_posit_product)
  }
})

test_that("getOAuthCredentials requires minimum version", {
  # Save current environment
  old_posit_product <- Sys.getenv("POSIT_PRODUCT")
  old_rstudio_version <- Sys.getenv("RSTUDIO_VERSION")

  # Set environment to simulate Workbench with old version
  Sys.setenv(POSIT_PRODUCT = "WORKBENCH")
  Sys.setenv(RSTUDIO_VERSION = "2024.01.0")

  # Expect error about version requirement
  expect_error(
    getOAuthCredentials("test-integration"),
    "OAuth functionality require Posit Workbench version 2026.01.0 or later"
  )

  # Restore environment
  if (nzchar(old_posit_product)) {
    Sys.setenv(POSIT_PRODUCT = old_posit_product)
  } else {
    Sys.unsetenv("POSIT_PRODUCT")
  }

  if (nzchar(old_rstudio_version)) {
    Sys.setenv(RSTUDIO_VERSION = old_rstudio_version)
  } else {
    Sys.unsetenv("RSTUDIO_VERSION")
  }
})

test_that("getOAuthCredentials handles missing RPC cookie", {
  # Save current environment
  old_posit_product <- Sys.getenv("POSIT_PRODUCT")
  old_rstudio_version <- Sys.getenv("RSTUDIO_VERSION")
  old_rpc_cookie <- Sys.getenv("RS_SESSION_RPC_COOKIE")
  old_runtime_dir <- Sys.getenv("PWB_SESSION_RUNTIME_DIR")

  # Set environment to simulate Workbench with correct version but no cookie
  Sys.setenv(POSIT_PRODUCT = "WORKBENCH")
  Sys.setenv(RSTUDIO_VERSION = "2026.01.0")
  Sys.unsetenv("RS_SESSION_RPC_COOKIE")
  Sys.unsetenv("PWB_SESSION_RUNTIME_DIR")

  # Expect error about missing RPC cookie
  expect_error(
    getOAuthCredentials("test-integration"),
    "RPC cookie not found"
  )

  # Restore environment
  if (nzchar(old_posit_product)) {
    Sys.setenv(POSIT_PRODUCT = old_posit_product)
  } else {
    Sys.unsetenv("POSIT_PRODUCT")
  }

  if (nzchar(old_rstudio_version)) {
    Sys.setenv(RSTUDIO_VERSION = old_rstudio_version)
  } else {
    Sys.unsetenv("RSTUDIO_VERSION")
  }

  if (nzchar(old_rpc_cookie)) {
    Sys.setenv(RS_SESSION_RPC_COOKIE = old_rpc_cookie)
  }

  if (nzchar(old_runtime_dir)) {
    Sys.setenv(PWB_SESSION_RUNTIME_DIR = old_runtime_dir)
  }
})

test_that("getOAuthIntegrations fails gracefully outside Workbench", {
  # Save current environment
  old_posit_product <- Sys.getenv("POSIT_PRODUCT")

  # Temporarily unset POSIT_PRODUCT
  Sys.unsetenv("POSIT_PRODUCT")

  expect_error(
    getOAuthIntegrations(),
    "OAuth functionality is only available within Posit Workbench sessions"
  )

  # Restore environment
  if (nzchar(old_posit_product)) {
    Sys.setenv(POSIT_PRODUCT = old_posit_product)
  }
})

test_that("getOAuthIntegrations requires minimum version", {
  # Save current environment
  old_posit_product <- Sys.getenv("POSIT_PRODUCT")
  old_rstudio_version <- Sys.getenv("RSTUDIO_VERSION")

  # Set environment to simulate Workbench with old version
  Sys.setenv(POSIT_PRODUCT = "WORKBENCH")
  Sys.setenv(RSTUDIO_VERSION = "2024.01.0")

  # Expect error about version requirement
  expect_error(
    getOAuthIntegrations(),
    "OAuth functionality require Posit Workbench version 2026.01.0 or later"
  )

  # Restore environment
  if (nzchar(old_posit_product)) {
    Sys.setenv(POSIT_PRODUCT = old_posit_product)
  } else {
    Sys.unsetenv("POSIT_PRODUCT")
  }

  if (nzchar(old_rstudio_version)) {
    Sys.setenv(RSTUDIO_VERSION = old_rstudio_version)
  } else {
    Sys.unsetenv("RSTUDIO_VERSION")
  }
})

test_that("getOAuthIntegrations handles missing RPC cookie", {
  # Save current environment
  old_posit_product <- Sys.getenv("POSIT_PRODUCT")
  old_rstudio_version <- Sys.getenv("RSTUDIO_VERSION")
  old_rpc_cookie <- Sys.getenv("RS_SESSION_RPC_COOKIE")
  old_runtime_dir <- Sys.getenv("PWB_SESSION_RUNTIME_DIR")

  # Set environment to simulate Workbench with correct version but no cookie
  Sys.setenv(POSIT_PRODUCT = "WORKBENCH")
  Sys.setenv(RSTUDIO_VERSION = "2026.01.0")
  Sys.unsetenv("RS_SESSION_RPC_COOKIE")
  Sys.unsetenv("PWB_SESSION_RUNTIME_DIR")

  # Expect error about missing RPC cookie
  expect_error(
    getOAuthIntegrations(),
    "RPC cookie not found"
  )

  # Restore environment
  if (nzchar(old_posit_product)) {
    Sys.setenv(POSIT_PRODUCT = old_posit_product)
  } else {
    Sys.unsetenv("POSIT_PRODUCT")
  }

  if (nzchar(old_rstudio_version)) {
    Sys.setenv(RSTUDIO_VERSION = old_rstudio_version)
  } else {
    Sys.unsetenv("RSTUDIO_VERSION")
  }

  if (nzchar(old_rpc_cookie)) {
    Sys.setenv(RS_SESSION_RPC_COOKIE = old_rpc_cookie)
  }

  if (nzchar(old_runtime_dir)) {
    Sys.setenv(PWB_SESSION_RUNTIME_DIR = old_runtime_dir)
  }
})

test_that("getOAuthCredentials allows dev versions", {
  # Save current environment
  old_posit_product <- Sys.getenv("POSIT_PRODUCT")
  old_rstudio_version <- Sys.getenv("RSTUDIO_VERSION")
  old_rpc_cookie <- Sys.getenv("RS_SESSION_RPC_COOKIE")
  old_server_address <- Sys.getenv("RS_SERVER_ADDRESS")

  # Set environment to simulate Workbench with dev version (even if old)
  Sys.setenv(POSIT_PRODUCT = "WORKBENCH")
  Sys.setenv(RSTUDIO_VERSION = "2024.01.0-dev")
  Sys.setenv(RS_SESSION_RPC_COOKIE = "test-cookie")
  Sys.setenv(RS_SERVER_ADDRESS = "http://localhost:8787")

  # Should not error about version requirement (will error about connection, but that's OK)
  expect_error(
    getOAuthCredentials("test-integration"),
    "HTTP request failed",
    class = "error"
  )

  # Restore environment
  if (nzchar(old_posit_product)) {
    Sys.setenv(POSIT_PRODUCT = old_posit_product)
  } else {
    Sys.unsetenv("POSIT_PRODUCT")
  }

  if (nzchar(old_rstudio_version)) {
    Sys.setenv(RSTUDIO_VERSION = old_rstudio_version)
  } else {
    Sys.unsetenv("RSTUDIO_VERSION")
  }

  if (nzchar(old_rpc_cookie)) {
    Sys.setenv(RS_SESSION_RPC_COOKIE = old_rpc_cookie)
  } else {
    Sys.unsetenv("RS_SESSION_RPC_COOKIE")
  }

  if (nzchar(old_server_address)) {
    Sys.setenv(RS_SERVER_ADDRESS = old_server_address)
  } else {
    Sys.unsetenv("RS_SERVER_ADDRESS")
  }
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

test_that("getOAuthIntegration fails gracefully outside Workbench", {
  # Save current environment
  old_posit_product <- Sys.getenv("POSIT_PRODUCT")

  # Temporarily unset POSIT_PRODUCT
  Sys.unsetenv("POSIT_PRODUCT")

  expect_error(
    getOAuthIntegration("test-guid"),
    "OAuth functionality is only available within Posit Workbench sessions"
  )

  # Restore environment
  if (nzchar(old_posit_product)) {
    Sys.setenv(POSIT_PRODUCT = old_posit_product)
  }
})
