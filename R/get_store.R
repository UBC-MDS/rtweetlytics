require(httr)
require(jsonlite)
require(dplyr)
require(testthat)
require(lubridate)

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
get_store <- function(
  bearer_token,
  keyword,
  start_date,
  end_date,
  max_results=25,
  store_path="/output/",
  store_csv=TRUE,
  include_public_metrics=TRUE,
  api_access_lvl="essential") {

  # # parameter tests
  testthat::test_that("Invalid parameter input type:", {
    testthat::expect_true(is.character(bearer_token), "bearer_token must be entered as a string")
    testthat::expect_true(is.character(keyword), "keyword must be entered as a string")
    testthat::expect_true(is.character(start_date), "start_date must be entered as a string")
    testthat::expect_true(is.character(end_date), "end_date must be entered as a string")
    testthat::expect_true(is.numeric(max_results), "Invalid parameter input type: max_results must be entered as an integer")
    testthat::expect_true(is.character(store_path), "Invalid parameter input type: store_path must be entered as a string")
    testthat::expect_true(is.logical(store_csv), "Invalid parameter input type: store_csv must be entered as a boolean")
  })
   
  testthat::test_that("Invalid parameter input value:", {
    testthat::expect_true(
      (as.Date(start_date) %within% interval((today() - 7), as.Date(end_date)) & (api_access_lvl == "essential")),
                "api access level of essential can only search for tweets in the past 7 days")
    testthat::expect_true(
      (as.Date(end_date) %within% interval(as.Date(start_date), today())),
      "end date must be in the range of the start date and today")
    testthat::expect_true(api_access_lvl %in% c("essential", "academic"),
      "Invalid parameter input value: api_access_lvl must be of either string essential or academic")
  })

  # set authorization header for API
  headers <- c(`Authorization` = sprintf('Bearer %s', bearer_token))

  # check access level and switch url accordingly. recent will can only search the past 7 days.
  if (api_access_lvl == "essential") {
    search_url = "https://api.twitter.com/2/tweets/search/recent?query="
  } else if (api_access_lvl == "academic") {
    search_url = "https://api.twitter.com/2/tweets/search/all"
  }

  # set request parameters
  query_params <- list("start_time"= paste0(start_date, "T00:00:00.000Z"),
                 "end_time"= paste0(end_date, "T00:00:00.000Z"),
                 "max_results"= paste0(max_results),
                 "expansions"= "author_id,in_reply_to_user_id",
                 "tweet.fields"= "id,text,author_id,in_reply_to_user_id,conversation_id,created_at,lang,public_metrics,referenced_tweets,reply_settings,source",
                 "user.fields"= "id,name,username,created_at,description,public_metrics,verified,entities",
                 "place.fields"= "full_name,id,country,country_code,name,place_type",
                 "next_token"= {})

  url_handle <-
    paste0(search_url, keyword)

  tweet_response <-
    httr::GET(url = url_handle,
              httr::add_headers(.headers = headers),
              query = query_params)
  tweet_text <- httr::content(tweet_response, as = "text")
  tweets_df <- fromJSON(tweet_text, flatten = TRUE)
  tweets_df <- as.data.frame(tweets_df["data"])

  if (store_csv == TRUE) {
    dir.create("output")
    tweets_df = data.frame(lapply(tweets_df, as.character), stringsAsFactors=FALSE)
    write.csv(tweets_df, paste0(getwd(), store_path, "tweets_response.csv"), row.names = FALSE)
  }

  return(tweets_df)
}
