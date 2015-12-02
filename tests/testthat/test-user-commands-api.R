context("Command API")

test_that("Custom commands (bound to R functions) can be defined", {
  skip_if_not_rstudio("0.99.800")

  # Type 'Ctrl + Alt + Shift + K', and you should see 'Hello, World!'
  # printed to the console.
  registerCommand("hello", "Ctrl+Alt+Shift+K", function(...) {
    print("Hello, world!")
  })

  # Type 'Ctrl + Alt + Shift + F' and 'formatR::tidy_source()' will be used
  # to reformat the current document.
  registerCommand("format", "Ctrl+Alt+Shift+F", function(...) {
    if (!requireNamespace("formatR", quietly = TRUE))
      return()

    context <- getActiveDocumentContext()
    capture.output(tidy <- formatR::tidy_source(text = context$contents))
    insertText(makeRange(c(1, 1, Inf, 1)), paste(tidy$text.tidy, collapse = "\n"))
  })

})
