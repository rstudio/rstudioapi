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

  # Comment out the first 5 lines
  pos <- Map(c, 4:8, 1)
  insertText(pos, "# ")

  # Uncomment the first 5 lines
  rng <- Map(c, Map(c, 4:8, 1), Map(c, 4:8, 3))
  insertText(rng, "")

})

# -- Scratch Space -- #
# Hello!
# Hello!
