require(httr)
require(jsonlite)
require(dplyr)

#' Retrieves all tweets of a keyword provided by the user through the Twitter API.
#' Alternatively the user can directly read from a structured Json response based
#' on the Twitter API.
#' If the user plans to access to the Twitter API they must have a personal bearer
#' token and store it as an environment variable to access it.
#'
#' @param bearer_token The user's personal twitter API dev bearer token.
#' It is recommended to add the token from an environment variable.
#' @param keyword The keyword to search Twitter and retrieve tweets.
#' @param start_date Starting date to collect tweets from. Dates should be
#' entered in string format: YYYY-MM-DD
#' @param end_date Ending date (Included) to collect tweets from.
#' Dates should be entered in string format: YYYY-MM-DD
#' @param max_results The maximum number of tweets to return.
#' Default is 25.Must be between 10 and 100.
#' @param store_path The string path to store the retrieved tweets in
#' Json format. Default is working directory.
#' @param store_csv Create .csv file with response data or not. Default is False.
#' @param include_public_metrics Should public metrics regarding each tweet such as
#' impression_count, like_count, reply_count, retweet_count,
#' url_link_clicks and user_profile_clicks be downloaded
#' and stored. Default is True.
#' @param api_access_lvl The twitter API access level of the user's bearer token.
#' Options are 'essential' or 'academic'. Default is 'essential'
#'
#' @return dataframe
#' A dataframe of retrieved tweets based on user's selected parameters.
#' (Data will be stored as a Json file)
#' @export
#'
#' @examples
#' bearer_token <- Sys.getenv("BEARER_TOKEN")
#' tweets <- get_store(bearer_token,keyword="vancouver",start_date="2022-01-12",
#' end_date="2022-01-17")
#' tweets
get_store <- function(
  bearer_token,
  keyword,
  start_date,
  end_date,
  max_results=25,
  store_path="output/",
  store_csv=False,
  include_public_metrics=TRUE,
  api_access_lvl="essential") {

  headers <- c(`Authorization` = sprintf('Bearer %s', bearer_token))

  params <- list("start_time"= paste0(start_date, "T00:00:00.000Z"),
                 "end_time"= paste0(end_date, "T00:00:00.000Z"),
                 "max_results"= paste0(max_results),
                 "expansions"= "author_id,in_reply_to_user_id",
                 "tweet.fields"= "id,text,author_id,in_reply_to_user_id,conversation_id,created_at,lang,public_metrics,referenced_tweets,reply_settings,source",
                 "user.fields"= "id,name,username,created_at,description,public_metrics,verified,entities",
                 "place.fields"= "full_name,id,country,country_code,name,place_type",
                 "next_token"= {})

  url_handle <-
    paste0('https://api.twitter.com/2/tweets/search/recent?query=', keyword)

  response <-
    httr::GET(url = url_handle,
              httr::add_headers(.headers = headers),
              query = params)
  obj <- httr::content(response, as = "text")
  print(obj)

}

bearer_token <- Sys.getenv("BEARER_TOKEN")
get_store(
  bearer_token = bearer_token,
  keyword = "omicron lang:en",
  start_date = "2022-01-20",
  end_date = "2022-01-23"
  )


