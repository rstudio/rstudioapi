#' OAuth2 Tokens for Delegated Azure Resources
#'
#' When Workbench is using Azure Active Directory for sign-in, this function can
#' return an OAuth2 token for a service Workbench users have delegated access
#' to. This requires configuring delegated permissions in Azure itself.
#'
#' @param resource The name of an Azure resource or service, normally a URL.
#'
#' @examples
#' \dontrun{
#' getDelegatedAzureToken("https://storage.azure.com")
#' }
#' @export
getDelegatedAzureToken <- function(resource) {
  version <- versionInfo()
  if (is.null(version$edition)) {
    stop("Delegated Azure Credentials are not available in the open-source edition of RStudio.")
  }
  callFun("getDelegatedAzureToken", resource)
}


test
