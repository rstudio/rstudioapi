
#' Interact with RStudio's Dictionaries
#'
#' Interact with the [hunspell](https://hunspell.github.io/) dictionaries
#' used by RStudio for spell checking.
#'
#' `dictionariesPath()` gives a path to the dictionaries installed and
#' distributed with RStudio.
#'
#' `userDictionariesPath()` gives the path where users can provide their
#' own custom `hunspell` dictionaries.
#'
#' @note The `dictionariesPath()` and `userDictionariesPath()` functions were
#'   introduced with RStudio 1.2.1202.
#'
#' @name dictionaries
NULL

#' @name dictionaries
#' @export
dictionariesPath <- function() {
  callFun("dictionariesPath")
}

#' @name dictionaries
#' @export
userDictionariesPath <- function() {
  callFun("userDictionariesPath")
}
