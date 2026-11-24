test_that("the public jobRunScript name resolves to the IDE job function", {
  local_edition(3)

  rstudio <- new.env(parent = emptyenv())
  rstudio$.rs.api.versionInfo <- function() list()
  rstudio$.rs.api.runScriptJob <- function(...) NULL
  local_mocked_bindings(
    isAvailable = function(...) TRUE,
    toolsEnv = function() rstudio
  )

  expect_true(hasFun("jobRunScript", mode = "function"))
  expect_true(hasFun("runScriptJob", mode = "function"))
  expect_identical(findFun("jobRunScript", mode = "function"), rstudio$.rs.api.runScriptJob)

  rm(".rs.api.runScriptJob", envir = rstudio)
  expect_false(hasFun("jobRunScript"))
})

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
