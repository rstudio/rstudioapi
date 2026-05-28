test_that("getMode() prefers the fast '.rs.isDesktop()' helper when available", {
  local_edition(3)

  rstudio <- new.env(parent = emptyenv())
  rstudio$.rs.isDesktop <- function() TRUE

  local_mocked_bindings(
    hasFun = function(...) FALSE,
    verifyAvailable = function(...) invisible(TRUE),
    toolsEnv = function() rstudio,
    versionInfo = function() stop("versionInfo() should not be called")
  )

  expect_identical(getMode(), "desktop")

  rstudio$.rs.isDesktop <- function() FALSE
  expect_identical(getMode(), "server")
})

test_that("getMode() falls back to versionInfo() when '.rs.isDesktop()' is unavailable (#326)", {
  local_edition(3)

  # an old RStudio that lacks the '.rs.isDesktop()' helper
  rstudio <- new.env(parent = emptyenv())

  local_mocked_bindings(
    hasFun = function(...) FALSE,
    verifyAvailable = function(...) invisible(TRUE),
    toolsEnv = function() rstudio,
    versionInfo = function() list(mode = "server")
  )

  expect_identical(getMode(), "server")
})
