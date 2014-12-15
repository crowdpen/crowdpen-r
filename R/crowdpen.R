#' @import httr
#' @import RCurl
#' @import jsonlite

library(httr)
library(RCurl)
library(jsonlite)

#' Crowdpen API base URL
#'
#' @param crowdpen_api_url Crowdpen API base url, default is 'https://api.crowdpen.com/api/rest/v1/results'
#' @export
crowdpen_api_url <- 'https://api.crowdpen.com/api/rest/v1/results'
#' Crowdpen API username
#'
#' @param crowdpen_email Crowdpen API username - required, no default
#' @export
crowdpen_email   <- ''
#' Crowdpen API base URL
#'
#' @param crowdpen_token Crowdpen API access token, required, no default
#' @export
crowdpen_token   <- ''

#' Fetch crowdpen data
#'
#' This function allows you to fetch data from the crowdpen.com api.
#' @param qid Searchquery ID, required.
#' @param sortDir, sort direction, String, default='desc'
#' @param sortBy, sort direction, String, default='raised'
#' @param page, page number, Number, default='1'
#' @param pageSize, elements in page, Number, default='100'
#' @keywords crowdfunding
#' @export
#' @examples
#' fetch_cp_data(qid)

build_auth_header <- function() {
  print("crowdpen::build_auth_header")
  paste('Token token="', crowdpen_token,  '", user_email="', crowdpen_email, '"', sep="")
}

build_headers <- function() {
  print("crowdpen::build_headers")
  add_headers(
    "Content-Type" = "application/json",
    "Accept" = "application/json",
    "Accept-Version" = "1.0",
    "Authorization"=build_auth_header()
  )
}

fetch_cp_data <- function(qid,
                          sortDir='desc',
                          sortBy='raised',
                          page=1,
                          pageSize=100
) {

  query_params <- list("searchquery_id"=qid,
                       "sortBy"=sortBy,
                       "sortDir"=sortDir,
                       "page"=page,
                       "pageSize"=pageSize
  )

  print("crowdpen::fetch_cp_data, running GET with_config")
  resp <- with_config(build_headers(), GET(crowdpen_api_url, query=query_params))
  warn_for_status(resp)

  result = fromJSON(content(resp, "text"))$results

  result$startdate <- as.Date(result$startdate)
  result$enddate   <- as.Date(result$enddate)

  result
}
