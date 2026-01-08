# Feature names and their minimum version requirements
.WORKBENCH_FEATURE_DELEGATED_AZURE <- "Delegated Azure tokens"
.WORKBENCH_FEATURE_OAUTH <- "OAuth functionality"

.WORKBENCH_MIN_VERSIONS <- list()
.WORKBENCH_MIN_VERSIONS[[.WORKBENCH_FEATURE_DELEGATED_AZURE]] <- "2024.12.0"
.WORKBENCH_MIN_VERSIONS[[.WORKBENCH_FEATURE_OAUTH]] <- "2026.01.0"

#' OAuth2 Tokens for Delegated Azure Resources
#'
#' When Workbench is using Azure Active Directory for sign-in, this function can
#' return an OAuth2 token for a service Workbench users have delegated access
#' to. This requires configuring delegated permissions in Azure itself.
#'
#' @param resource The name of an Azure resource or service, normally a URL.
#'
#' @return A list containing the OAuth2 token details. Throws an error if unavailable.
#'
#' @examples
#' \dontrun{
#' getDelegatedAzureToken("https://storage.azure.com")
#' }
#' @export
getDelegatedAzureToken <- function(resource) {
  if (missing(resource) || !is.character(resource) || length(resource) != 1 || !nzchar(resource)) {
    stop("resource must be a non-empty character string")
  }

  # Try the internal RStudio API first (works in RStudio IDE)
  if (hasFun("getDelegatedAzureToken")) {
    return(callFun("getDelegatedAzureToken", resource))
  }

  assertWorkbenchSession()
  assertWorkbenchVersion(.WORKBENCH_FEATURE_DELEGATED_AZURE)

  body <- list(
    params = list(jsonlite::unbox(resource))
  )

  response <- callWorkbenchRPC(
    method = "delegated_azure_token",
    body = body,
    error_context = "retrieving delegated Azure token"
  )

  if (is.null(response$token)) {
    stop("Malformed response: missing 'token' field")
  }

  response$token
}

#' Retrieve OAuth Credentials for Integrations
#'
#' Retrieve OAuth credentials for a configured OAuth integration in Posit Workbench.
#' This function exchanges the current session for OAuth credentials that can be used
#' to authenticate with external services. This works in any IDE running within a
#' Posit Workbench session.
#'
#' @param audience The GUID of the OAuth integration configured in Posit Workbench.
#'
#' @return A list containing:
#' \describe{
#'   \item{access_token}{The OAuth access token.}
#'   \item{expiry}{The token expiry time as a POSIXct datetime object.}
#'   \item{audience}{The integration GUID (audience) that was used to retrieve the credentials.}
#' }
#' Throws an error if the credentials cannot be retrieved or the integration is not found.
#'
#' @note This function requires Posit Workbench version 2026.01.0 or later. It works
#' in any IDE running within a Posit Workbench session (not just RStudio).
#'
#' @examples
#' \dontrun{
#' # Retrieve OAuth credentials for an integration
#' creds <- getOAuthCredentials("4c1cfecb-1927-4f19-bc2f-d8ac261364e0")
#' if (!is.null(creds)) {
#'   cat("Access token:", creds$access_token, "\n")
#'   cat("Expires at:", format(creds$expiry), "\n")
#' }
#' }
#' @export
getOAuthCredentials <- function(audience) {
  # Validate input
  if (missing(audience) || !is.character(audience) || length(audience) != 1 || !nzchar(audience)) {
    stop("audience must be a non-empty character string")
  }

  # Validate GUID format
  guid_pattern <- "^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$"
  if (!grepl(guid_pattern, audience)) {
    stop(
      "audience must be a valid GUID (e.g., '4c1cfecb-1927-4f19-bc2f-d8ac261364e0').\n",
      "Use getOAuthIntegrations() to list available integrations and their GUIDs, or\n",
      "use findOAuthIntegration() to search for a specific integration by name."
    )
  }

  assertWorkbenchSession()
  assertWorkbenchVersion(.WORKBENCH_FEATURE_OAUTH)

  body <- list(
    kwparams = list(
      uuid = jsonlite::unbox(audience)
    )
  )

  response <- callWorkbenchRPC(
    method = "oauth_token",
    body = body,
    error_context = "retrieving OAuth credentials"
  )

  if (is.null(response$access_token)) {
    stop("Malformed response: missing 'access_token' field")
  }

  if (!is.null(response$expiry)) {
    response$expiry <- as.POSIXct(response$expiry, format = "%Y-%m-%dT%H:%M:%OS", tz = "UTC")
  }
  response$audience <- audience

  response
}

#' Get OAuth Integrations
#'
#' Retrieve a list of all OAuth integrations configured in Posit Workbench.
#' This returns metadata about each integration including its authentication status,
#' scopes, and configuration details.
#'
#' @return A list of OAuth integrations, where each element contains:
#' \describe{
#'   \item{type}{The integration type (e.g., "custom").}
#'   \item{name}{The integration name.}
#'   \item{display_name}{The display name (may be NULL).}
#'   \item{client_id}{The OAuth client ID.}
#'   \item{auth_url}{The authorization URL.}
#'   \item{token_url}{The token URL.}
#'   \item{scopes}{A character vector of OAuth scopes.}
#'   \item{issuer}{The OAuth issuer URL.}
#'   \item{authenticated}{Boolean indicating if currently authenticated.}
#'   \item{guid}{The globally unique identifier for this integration (useful for \code{getOAuthCredentials()}).}
#' }
#' Returns an empty list if no integrations are configured.
#'
#' @note This function requires Posit Workbench version 2026.01.0 or later. It works
#' in any IDE running within a Posit Workbench session (not just RStudio).
#'
#' @examples
#' \dontrun{
#' # Get all OAuth integrations
#' integrations <- getOAuthIntegrations()
#'
#' # Show all integrations
#' for (int in integrations) {
#'   cat(sprintf("%s (%s): %s\n",
#'               int$name,
#'               int$guid,
#'               if (int$authenticated) "authenticated" else "not authenticated"))
#' }
#'
#' # Filter to authenticated integrations only
#' authenticated <- Filter(function(x) x$authenticated, integrations)
#'
#' # Get credentials for the first authenticated integration
#' if (length(authenticated) > 0) {
#'   creds <- getOAuthCredentials(audience = authenticated[[1]]$guid)
#' }
#' }
#' @export
getOAuthIntegrations <- function() {
  assertWorkbenchSession()
  assertWorkbenchVersion(.WORKBENCH_FEATURE_OAUTH)

  body <- list(
    kwparams = list()
  )

  response <- callWorkbenchRPC(
    method = "oauth_integrations",
    body = body,
    error_context = "retrieving OAuth integrations"
  )

  # Flatten the providers structure and return just the integrations
  if (!is.null(response$providers) && length(response$providers) > 0) {
    all_integrations <- unlist(
      lapply(response$providers, function(provider) {
        if (!is.null(provider$integrations)) {
          provider$integrations
        } else {
          list()
        }
      }),
      recursive = FALSE
    )

    # Rename uid to guid for consistency
    all_integrations <- lapply(all_integrations, function(integration) {
      if (!is.null(integration$uid)) {
        integration$guid <- integration$uid
        integration$uid <- NULL
      }
      integration
    })

    return(all_integrations)
  }

  list()
}

#' Find OAuth Integration by Criteria
#'
#' Search for an OAuth integration that matches the specified criteria. Returns the first
#' integration that matches all provided filter parameters. If no parameters are provided,
#' returns the first available integration.
#'
#' @param name Optional integration name to match. Supports regular expressions.
#'   For exact matches, use anchors like \code{^github-main$}.
#' @param display_name Optional display name to match. Supports regular expressions.
#'   For exact matches, use anchors like \code{^GitHub Production$}.
#' @param guid Optional globally unique identifier (GUID) to match. Exact match only.
#' @param authenticated Optional logical indicating whether to match only authenticated integrations (TRUE),
#'   only unauthenticated integrations (FALSE), or either (NULL, the default). Exact match only.
#'
#' @return A list containing the integration metadata, or \code{NULL} if no matching integration is found.
#'
#' @note This function requires Posit Workbench version 2026.01.0 or later. It works
#' in any IDE running within a Posit Workbench session (not just RStudio).
#'
#' @examples
#' \dontrun{
#' # Find by exact name
#' integration <- findOAuthIntegration(name = "^my-github-integration$")
#'
#' # Find by name pattern (any integration with "github" in the name)
#' integration <- findOAuthIntegration(name = "github")
#'
#' # Find authenticated integration by display name pattern
#' integration <- findOAuthIntegration(display_name = "GitHub.*", authenticated = TRUE)
#'
#' # Find by exact GUID
#' integration <- findOAuthIntegration(guid = "4c1cfecb-1927-4f19-bc2f-d8ac261364e0")
#' }
#' @export
findOAuthIntegration <- function(name = NULL, display_name = NULL, guid = NULL, authenticated = NULL) {
  integrations <- getOAuthIntegrations()

  for (integration in integrations) {
    if (!is.null(name)) {
      if (is.null(integration$name) || !grepl(name, integration$name)) {
        next
      }
    }
    if (!is.null(display_name)) {
      if (is.null(integration$display_name) || !grepl(display_name, integration$display_name)) {
        next
      }
    }
    if (!is.null(guid) && (is.null(integration$guid) || integration$guid != guid)) {
      next
    }
    if (!is.null(authenticated) && (is.null(integration$authenticated) || integration$authenticated != authenticated)) {
      next
    }

    return(integration)
  }

  # No match found
  NULL
}

#' Get a Specific OAuth Integration
#'
#' Retrieve metadata for a specific OAuth integration by its globally unique identifier.
#' This is a convenience function that calls \code{findOAuthIntegration(guid = guid)}.
#'
#' @param guid The globally unique identifier (GUID) of the OAuth integration to retrieve.
#'
#' @return A list containing the integration metadata:
#' \describe{
#'   \item{type}{The integration type (e.g., "custom").}
#'   \item{name}{The integration name.}
#'   \item{display_name}{The display name (may be NULL).}
#'   \item{client_id}{The OAuth client ID.}
#'   \item{auth_url}{The authorization URL.}
#'   \item{token_url}{The token URL.}
#'   \item{scopes}{A character vector of OAuth scopes.}
#'   \item{issuer}{The OAuth issuer URL.}
#'   \item{authenticated}{Boolean indicating if currently authenticated.}
#'   \item{guid}{The globally unique identifier for this integration.}
#' }
#' Returns \code{NULL} if no integration with the specified GUID is found.
#'
#' @note This function requires Posit Workbench version 2026.01.0 or later. It works
#' in any IDE running within a Posit Workbench session (not just RStudio).
#'
#' @examples
#' \dontrun{
#' # Get a specific integration by GUID
#' integration <- getOAuthIntegration("4c1cfecb-1927-4f19-bc2f-d8ac261364e0")
#'
#' if (!is.null(integration)) {
#'   cat("Found integration:", integration$name, "\n")
#'   cat("Authenticated:", integration$authenticated, "\n")
#'
#'   # Get credentials if authenticated
#'   if (integration$authenticated) {
#'     creds <- getOAuthCredentials(audience = integration$guid)
#'   }
#' }
#' }
#' @export
getOAuthIntegration <- function(guid) {
  if (missing(guid) || !is.character(guid) || length(guid) != 1 || !nzchar(guid)) {
    stop("guid must be a non-empty character string")
  }

  findOAuthIntegration(guid = guid)
}

# Internal helper to assert running in Posit Workbench
assertWorkbenchSession <- function() {
  if (Sys.getenv("POSIT_PRODUCT") == "WORKBENCH") {
    return(invisible(NULL))
  }

  # Fall back to RS_SERVER_ADDRESS for older versions
  # TODO: Remove RS_SERVER_ADDRESS check when 2025.09 falls out of support
  if (nzchar(Sys.getenv("RS_SERVER_ADDRESS"))) {
    return(invisible(NULL))
  }

  stop("OAuth functionality is only available within Posit Workbench sessions.")
}

# Internal helper to assert version requirement
assertWorkbenchVersion <- function(feature_name) {
  min_version <- .WORKBENCH_MIN_VERSIONS[[feature_name]]
  if (is.null(min_version)) {
    stop(sprintf("Unknown feature name: %s", feature_name))
  }

  wb_version <- Sys.getenv("RSTUDIO_VERSION")
  version_string <- wb_version  # For error messages

  # RSTUDIO_VERSION is not set in RStudio sessions, but versionInfo() should match the Workbench version
  if (!nzchar(wb_version)) {
    version_info <- tryCatch(
      versionInfo(),
      error = function(e) NULL
    )

    if (!is.null(version_info) && !is.null(version_info$version)) {
      wb_version <- as.character(version_info$version)
      version_string <- version_info$long_version
    }
  }

  if (!nzchar(wb_version)) {
    return(invisible(NULL))
  }

  # Skip version check for dev builds
  if (grepl("dev", wb_version, ignore.case = TRUE)) {
    return(invisible(NULL))
  }

  required_version <- numeric_version(min_version)
  current_version <- tryCatch(
    numeric_version(gsub("[-+].*$", "", wb_version)),
    error = function(e) NULL
  )

  if (!is.null(current_version) && current_version < required_version) {
    stop(sprintf(
      "This API is not available in Posit Workbench version %s. Please upgrade to version %s or later.",
      version_string,
      min_version
    ))
  }

  invisible(NULL)
}

# Internal helper to call Workbench RPC endpoints
# Handles: server URL, RPC cookie, error checking, result validation
callWorkbenchRPC <- function(method, body, error_context = "RPC call") {
  # Get the RPC cookie for authentication
  rpc_cookie <- getRPCCookie()

  server_url <- Sys.getenv("RS_SERVER_ADDRESS")
  if (!nzchar(server_url)) {
    stop("RS_SERVER_ADDRESS environment variable not set. Cannot determine Posit Workbench server address.")
  }

  endpoint <- paste0(server_url, "/", method)

  body$method <- jsonlite::unbox(method)

  response <- workbenchRequest(
    url = endpoint,
    method = "POST",
    body = body,
    rpc_cookie = rpc_cookie
  )

  # Check for JSON-RPC error field
  if (!is.null(response$error)) {
    error_msg <- if (is.list(response$error)) {
      paste(response$error$message, response$error$description, sep = ": ")
    } else {
      as.character(response$error)
    }
    stop(sprintf("Error %s: %s", error_context, error_msg))
  }

  if (!is.null(response$result) && !isTRUE(response$result)) {
    if (!is.null(response$detail)) {
      stop(sprintf("Error %s: %s", error_context, response$detail))
    }

    # Check for OAuth2-specific errors
    if (!is.null(response$oauth2_error)) {
      oauth_err <- response$oauth2_error
      error_code <- if (!is.null(oauth_err$error)) oauth_err$error else "unknown"
      error_desc <- if (!is.null(oauth_err$error_description)) oauth_err$error_description else "no description"
      stop(sprintf("OAuth2 error %s: %s - %s", error_context, error_code, error_desc))
    }

    stop(sprintf("Error %s: request failed with result=false", error_context))
  }

  response
}

# Internal helper to get RPC cookie
getRPCCookie <- function() {
  # Try to read from environment variable first
  cookie <- Sys.getenv("RS_SESSION_RPC_COOKIE")
  if (nzchar(cookie)) {
    return(cookie)
  }

  runtime_dir <- Sys.getenv("PWB_SESSION_RUNTIME_DIR")
  if (nzchar(runtime_dir)) {
    cookie_file <- file.path(runtime_dir, "rpc_cookie")
    if (file.exists(cookie_file)) {
      cookie <- tryCatch(
        readLines(cookie_file, n = 1, warn = FALSE),
        error = function(e) {
          stop(sprintf("RPC cookie file exists at '%s' but could not be read: %s", cookie_file, e$message))
        }
      )
      if (is.null(cookie) || !nzchar(cookie)) {
        stop(sprintf("RPC cookie file exists at '%s' but is empty", cookie_file))
      }
      return(cookie)
    }
  }

  stop("RPC cookie not found. Ensure either PWB_SESSION_RUNTIME_DIR is set with a valid cookie file, or RS_SESSION_RPC_COOKIE environment variable is defined.")
}

# Internal helper to make authenticated requests to Workbench
workbenchRequest <- function(url, method = "GET", body = NULL, rpc_cookie = NULL) {
  if (!requireNamespace("curl", quietly = TRUE)) {
    stop("Package 'curl' is required for OAuth functionality. Please install it with: install.packages('curl')")
  }

  if (!requireNamespace("jsonlite", quietly = TRUE)) {
    stop("Package 'jsonlite' is required for OAuth functionality. Please install it with: install.packages('jsonlite')")
  }

  handle <- curl::new_handle()

  headers <- list("Content-Type" = "application/json")
  if (!is.null(rpc_cookie)) {
    headers[["X-RS-Session-Server-RPC-Cookie"]] <- rpc_cookie
  }
  curl::handle_setheaders(handle, .list = headers)

  # Configure SSL certificate bundle if available
  ca_bundle <- Sys.getenv("REQUESTS_CA_BUNDLE")
  if (!nzchar(ca_bundle)) {
    ca_bundle <- Sys.getenv("CURL_CA_BUNDLE")
  }
  if (nzchar(ca_bundle)) {
    curl::handle_setopt(handle, cainfo = ca_bundle)
  }

  # Set POST options if needed
  if (method == "POST") {
    json <- jsonlite::toJSON(body)
    curl::handle_setopt(
      handle = handle,
      post = TRUE,
      postfields = json
    )
  }

  # Make request
  response <- tryCatch(
    curl::curl_fetch_memory(url, handle = handle),
    error = function(e) {
      stop(sprintf("HTTP request failed: %s", e$message))
    }
  )

  if (response$status_code >= 400) {
    content <- enc2utf8(rawToChar(response$content))
    stop(sprintf(
      "HTTP request failed with status %s: %s",
      response$status_code,
      content
    ))
  }

  content <- enc2utf8(rawToChar(response$content))
  jsonlite::fromJSON(content, simplifyVector = FALSE)
}
