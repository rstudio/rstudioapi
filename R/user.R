#' Get User Identity
#'
#' Returns the identity (displayed name) of the current user.
#'
#' @export
userIdentity <- function()
{
  callFun("userIdentity")
}

#' Get System Username
#'
#' Returns the system username of the current user.
#'
#' @export
systemUsername <- function()
{
  callFun("systemUsername")
}

