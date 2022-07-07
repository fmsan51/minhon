#' Get access token
#'
#' Get access token from given API key and API secret.
#' Access <https://mt-auto-minhon-mlt.ucri.jgn-x.jp/content/mt/> to get
#' your API key and API secret.
#'
#' @note Access token expires in 60 minutes.
#'
#' @param api_key API key
#' @param api_secret API secret
#'
#' @importFrom httr oauth_app oauth_endpoint oauth2.0_token
#' @export
get_token <- function(api_key = getOption("minhon.api_key"),
                      api_secret = getOption("minhon.api_secret")) {
  endpoint <- oauth_endpoint(NULL, NULL, token_url)
  app <- oauth_app("minhon", api_key, api_secret)
  token <- oauth2.0_token(endpoint, app, client_credentials = T)
  return(token)
}
