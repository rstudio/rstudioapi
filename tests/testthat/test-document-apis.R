context("Document API")

## The tests contained in this file 'pass' if, after sourcing
## in RStudio, the contents don't change. :)

# -- Scratch Space -- #
#
#
#
#
#
#  -- Scratch Space -- #

test_that("various APIs for interacting with an RStudio document work", {
  skip_if_not_rstudio("0.99.796")

  context <- getActiveDocumentContext()
  path <- context$path
  before <- readLines(path)

  scratchRanges <- Map(c, Map(c, 7:11, 1), Map(c, 7:11, Inf))

  # Insert text at position
  insertText(document_position(7, Inf), " Hello")
  insertText(list(
    document_position(8, Inf),
    document_position(9, Inf)
  ), " Hello")

  insertText(list(
    document_position(10, Inf),
    document_position(11, Inf)
  ), c(" First", " Second"))

  # Clean up
  insertText(scratchRanges, "#")

  # Insert text at range
  insertText(c(7, 1, 7, Inf), "# Howdy")
  insertText(document_range(start = c(8, 1), end = c(8, Inf)), "# Hello There")

  # Clean up
  insertText(scratchRanges, "#")

  # Insert text at bottom of document
  insertText(Inf, "# Hello!\n")
  insertText(c(Inf, 1), "# Hello!\n")

  # Add an extra comment to the scratch space
  pos <- Map(c, 7:11, 1)
  insertText(pos, "# ")

  # Remove the aforementioned extra comment
  rng <- Map(c, Map(c, 7:11, 1), Map(c, 7:11, 3))
  insertText(rng, "")

  # Clean up things we appended to the document
  end <- grep("^# -- Final Scratch Space -- #", context$contents)
  insertText(
    document_range(start = c(end + 1, 1), end = c(Inf, 1)),
    ""
  )

  ctx <- getActiveDocumentContext()
  after <- ctx$contents

  # 'readLines' will not include a final newline,
  # so accommodate that
  expect_identical(before, after[-length(after)])

})

# -- Final Scratch Space -- #
