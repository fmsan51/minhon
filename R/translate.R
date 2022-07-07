#' Translate a text with TexTra
#'
#' Translate a text with TexTra. Access
#' <https://mt-auto-minhon-mlt.ucri.jgn-x.jp/content/mt/> to get URL and
#' get details about the arguments `param` and `field`.
#'
#' @inheritParams get_response
#' @param field Field of response to obtain
#'
#' @inherit get_token note
#'
#' @examples
#' \dontrun{
#' token <- get_token("API_KEY", "API_SECRET")
#' # English to Japanese
#' translate(
#'   "The quick brown fox jumps over the lazy dog",
#'   "https://mt-auto-minhon-mlt.ucri.jgn-x.jp/api/mt/generalNT_en_ja/",
#'   "USER_ID",
#'   token
#'   )
#'
#' # You can store your API key, API secret and User ID as follows:
#' options(
#'   minhon.api_key = "API_KEY",
#'   minhon.api_secret = "API_SECRET",
#'   minhon.user_id = "USER_ID"
#'   )
#'
#' translate(
#'     "The quick brown fox jumps over the lazy dog",
#'     "https://mt-auto-minhon-mlt.ucri.jgn-x.jp/api/mt/generalNT_en_ja/"
#'   )
#' }
#'
#' @importFrom httr content
#' @importFrom rvest html_element html_text
#' @export
translate <- function(text, request_url,
                      user_id = getOption("minhon.user_id"),
                      token = get_token(),
                      field = "/resultset/result/information/text-t") {
  res <- get_response(text, request_url, user_id, token)
  res_html <- html_element(content(res, encoding = "UTF-8"), xpath = field)
  res_text <- html_text(res_html)
  return(res_text)
}

#' Get API response
#'
#' Obtain API response from given API URL. Access
#' <https://mt-auto-minhon-mlt.ucri.jgn-x.jp/content/mt/> to get URL and
#' get details about the argument `param`.
#'
#' @param text Text to translate
#' @param request_url API request URL
#' @param user_id User ID.
#' @param token Access token obtained by [get_token()].
#' @param param Request parameters as named `list`
#'
#' @inherit get_token note
#'
#' @importFrom httr parse_url POST
#' @export
get_response <- function(text, request_url,
                         user_id = getOption("minhon.user_id"),
                         token = get_token(),
                         param = NULL) {
  path <- parse_url(request_url)$path
  api_urls <- strsplit(path, "/")[[1]]
  default_param <- list(
    access_token = token$credentials$access_token,
    key = token$app$key,
    api_name = api_urls[2],
    api_param = api_urls[3],
    name = user_id,
    type = "xml",
    text = text
    )
  combined_param <- c(param, default_param)
  body <- combined_param[!duplicated(names(combined_param))]
  res <- POST(api_url, body = body)
  return(res)
}
