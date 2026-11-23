test_that("navigateToFile() rejects local directory paths before calling the IDE", {
  local_edition(3)
  local_mocked_bindings(
    isJob = function() FALSE,
    callFun = function(fname, file, ...) file
  )

  expect_error(navigateToFile(tempdir()), "filesPaneNavigate()", fixed = TRUE)
  expect_identical(navigateToFile(), character(0))
  path <- tempfile(fileext = ".R")
  expect_identical(navigateToFile(path), path)
})

test_that("navigateToFile() resolves job paths in the IDE session", {
  local_edition(3)
  local_mocked_bindings(
    isJob = function() TRUE,
    callRemote = function(call, frame) {
      expect_identical(call[[1L]], quote(navigateToFile))
      lapply(as.list(call)[-1L], eval, envir = frame)
    }
  )

  open_file <- navigateToFile
  expect_identical(
    open_file("relative/path.R"),
    list("relative/path.R", -1L, -1L, TRUE)
  )
  expect_identical(
    open_file("relative/path.R", line = 8, column = "3", moveCursor = 0),
    list("relative/path.R", 8L, 3L, FALSE)
  )
})
