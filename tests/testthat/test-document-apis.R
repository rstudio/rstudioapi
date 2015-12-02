context("Document API")

# -- Scratch Space -- #
#
#
#
#
#
#  -- Scratch Space -- #

test_that("various APIs for interacting with an RStudio document work", {

  scratchRanges <- Map(c, Map(c, 4:8, 1), Map(c, 4:8, Inf))

  # Insert text at position
  insertText(makePosition(4, Inf), " Hello")
  insertText(list(
    makePosition(5, Inf),
    makePosition(6, Inf)
  ), " Hello")

  insertText(list(
    makePosition(7, Inf),
    makePosition(8, Inf)
  ), c(" First", " Second"))

  # Clean up
  insertText(scratchRanges, "#")

  # Insert text at range
  insertText(c(4, 1, 4, Inf), "# Howdy")
  insertText(makeRange(start = c(5, 1), end = c(5, Inf)), "# Hello There")

  # Clean up
  insertText(scratchRanges, "#")

  # Insert text at bottom of document
  insertText(Inf, "# Hello!\n")
  insertText(c(Inf, 1), "# Hello!\n")

  # Add an extra comment to the scratch space
  pos <- Map(c, 4:8, 1)
  insertText(pos, "# ")

  # Remove the aforementioned extra comment
  rng <- Map(c, Map(c, 4:8, 1), Map(c, 4:8, 3))
  insertText(rng, "")

  # Clean up things we appended to the document
  context <- getActiveDocumentContext()
  end <- grep("^# -- Final Scratch Space -- #", context$contents)
  insertText(
    makeRange(start = c(end + 1, 1), end = c(Inf, 1)),
    ""
  )

})

# -- Final Scratch Space -- #
