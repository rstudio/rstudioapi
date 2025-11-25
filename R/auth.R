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

#' Retrieve OAuth Credentials for Integrations
#'
#' Retrieve OAuth credentials for a configured OAuth integration in Posit Workbench.
#' This function exchanges the current session for OAuth credentials that can be used
#' to authenticate with external services. This works in any IDE running within a
#' Posit Workbench session.
#'
#' @param integration_id The ID of the OAuth integration configured in Posit Workbench.
#'
#' @return A list containing:
#' \describe{
#'   \item{access_token}{The OAuth access token.}
#'   \item{expiry}{The token expiry time as a POSIXct datetime object.}
#'   \item{integration_id}{The integration ID that was used to retrieve the credentials.}
#' }
#' Returns \code{NULL} if the credentials cannot be retrieved or the integration is not found.
#'
#' @note This function requires Posit Workbench version 2025.11.0 or later. It works
#' in any IDE running within a Posit Workbench session (not just RStudio).
#'
#' @examples
#' \dontrun{
#' # Retrieve OAuth credentials for an integration
#' creds <- getOAuthCredentials("my-oauth-integration-id")
#' if (!is.null(creds)) {
#'   cat("Access token:", creds$access_token, "\n")
#'   cat("Expires at:", format(creds$expiry), "\n")
#' }
#' }
#' @export
getOAuthCredentials <- function(integration_id) {
  # Check if we're in a Workbench session
  if (Sys.getenv("POSIT_PRODUCT") != "WORKBENCH") {
    stop("OAuth credentials are only available within Posit Workbench sessions.")
  }

  # Check version requirement (2025.11.0+)
  wb_version <- Sys.getenv("RSTUDIO_VERSION")
  if (nzchar(wb_version)) {
    required_version <- numeric_version("2025.11.0")
    current_version <- tryCatch(
      numeric_version(gsub("[-+].*$", "", wb_version)),
      error = function(e) NULL
    )

    if (!is.null(current_version) && current_version < required_version) {
      stop(sprintf(
        "OAuth credentials require Posit Workbench version 2025.11.0 or later. Current version: %s",
        wb_version
      ))
    }
  }

  # Get the RPC cookie for authentication
  rpc_cookie <- .getRPCCookie()

  # Get the server address
  server_url <- Sys.getenv("RS_SERVER_ADDRESS")
  if (!nzchar(server_url)) {
    stop("RS_SERVER_ADDRESS environment variable not set. Cannot determine Posit Workbench server address.")
  }

  # Make the API request
  endpoint <- paste0(server_url, "/oauth_token")

  # Prepare request body (matching Python implementation exactly)
  body <- list(
    method = "/oauth_token",
    kwparams = list(
      uuid = integration_id
    )
  )

  # Make HTTP request (POST with JSON body)
  response <- .workbenchRequest(
    url = endpoint,
    method = "POST",
    body = body,
    rpc_cookie = rpc_cookie
  )

  # Check for errors in response
  if (!is.null(response$error)) {
    error_msg <- if (is.list(response$error)) {
      paste(response$error$message, response$error$description, sep = ": ")
    } else {
      as.character(response$error)
    }
    stop(sprintf("Error retrieving OAuth credentials: %s", error_msg))
  }

  # Check if result is false (unsuccessful)
  if (!is.null(response$result) && !isTRUE(response$result)) {
    return(NULL)
  }

  # Return credentials if found
  if (!is.null(response$access_token)) {
    return(list(
      access_token = response$access_token,
      expiry = as.POSIXct(response$expiry, format = "%Y-%m-%dT%H:%M:%OS", tz = "UTC"),
      integration_id = integration_id
    ))
  }

  return(NULL)
}

# Internal helper to get RPC cookie
.getRPCCookie <- function() {
  # Try to read from environment variable first
  cookie <- Sys.getenv("RS_SESSION_RPC_COOKIE")
  if (nzchar(cookie)) {
    return(cookie)
  }

  # Try to read from file
  runtime_dir <- Sys.getenv("PWB_SESSION_RUNTIME_DIR")
  if (nzchar(runtime_dir)) {
    cookie_file <- file.path(runtime_dir, "rpc_cookie")
    if (file.exists(cookie_file)) {
      cookie <- tryCatch(
        readLines(cookie_file, n = 1, warn = FALSE),
        error = function(e) NULL
      )
      if (!is.null(cookie) && nzchar(cookie)) {
        return(cookie)
      }
    }
  }

  stop("RPC cookie not found. Ensure either PWB_SESSION_RUNTIME_DIR is set with a valid cookie file, or RS_SESSION_RPC_COOKIE environment variable is defined.")
}

# Internal helper to make authenticated requests to Workbench
.workbenchRequest <- function(url, method = "GET", body = NULL, rpc_cookie = NULL) {
  # Check if httr is available
  if (!requireNamespace("httr", quietly = TRUE)) {
    stop("Package 'httr' is required for OAuth functionality. Please install it with: install.packages('httr')")
  }

  # Prepare headers
  headers <- httr::add_headers(
    "Content-Type" = "application/json"
  )

  if (!is.null(rpc_cookie)) {
    headers <- httr::add_headers(
      "Content-Type" = "application/json",
      "X-RS-Session-Server-RPC-Cookie" = rpc_cookie
    )
  }

  # Determine SSL verification settings
  verify_ssl <- TRUE
  ca_bundle <- Sys.getenv("REQUESTS_CA_BUNDLE")
  if (!nzchar(ca_bundle)) {
    ca_bundle <- Sys.getenv("CURL_CA_BUNDLE")
  }

  ssl_config <- if (nzchar(ca_bundle)) {
    httr::config(cainfo = ca_bundle)
  } else {
    httr::config(ssl_verifypeer = verify_ssl)
  }

  # Make request
  response <- if (method == "POST") {
    httr::POST(
      url,
      body = body,
      encode = "json",
      headers,
      ssl_config
    )
  } else if (method == "GET" && !is.null(body)) {
    # For GET with body, use POST-style request
    httr::GET(
      url,
      body = body,
      encode = "json",
      headers,
      ssl_config
    )
  } else {
    httr::GET(url, headers, ssl_config)
  }

  # Check HTTP status
  if (httr::http_error(response)) {
    stop(sprintf(
      "HTTP request failed with status %s: %s",
      httr::status_code(response),
      httr::content(response, "text", encoding = "UTF-8")
    ))
  }

  # Parse JSON response
  content <- httr::content(response, "text", encoding = "UTF-8")
  jsonlite::fromJSON(content, simplifyVector = FALSE)
}
