context("Command API")

test_that("Custom commands (bound to R functions) can be defined", {
  skip_if_not_rstudio("0.99.800")

  registerCommand("hello", "Ctrl+Alt+Shift+K", function(...) {
    print("Hello, world!")
  })

  # Type 'Ctrl + Alt + Shift + K', and you should see 'Hello, World!'
  # printed to the console.

})
