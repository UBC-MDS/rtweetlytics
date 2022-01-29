require(tidyverse)
require(dplyr)
require(sentimentr)
require(testthat)

#' Analyze the clean data frame extracted from twitter website
#'
#' @param input_file A character vector with, at most, one element.
#'
#'
#' @return A tibble including metrics of analytics.
#' @export
#'
#' @examples
#' analytics("output/tweets_response.csv")
analytics <- function(input_file) {
    # 
    # #testing the parameter type
    # test_that("Invalid input type", {
    #   expect_true(is.character(input_file), "Please enter the path of dataset as a string.")
    #   })
    # 
    # reading dataframe
    df <- read.csv(input_file)

    # counting number of like, retweet and comments
    like <-  sum(df$data.public_metrics.like_count)
    comment <- sum(df$data.public_metrics.reply_count)
    retweet <- sum(df$data.public_metrics.retweet_count)

    sentiment = c()
    # findning sentiment of each tweet
    for (i in seq(1, nrow(df), 1)) {
        sent <- sum(sentiment(df$data.text[i])$sentiment)
        if(sent > 0) {
            sentiment[i] = "positive"
        } else if(sent == 0) {
            sentiment[i] = "neutral"
        } else {
            sentiment[i] = "negative"
        }
    }
    # adding sentiment column to the dataframe
    df <- df |> mutate("sentiment"=sentiment)

    # counting the nmber of positive, nuetral and negative sentiments
    pos_sent <- df |>  filter(sentiment == 'positive') |> nrow()
    neut_sent <-  df |>  filter(sentiment == 'neutral') |> nrow()
    neg_sent <- df |>  filter(sentiment == 'negative') |> nrow()

    # tibble of result
    results = tibble("Metrics"=c("Total Number of Likes",
                                 "Total Number of Comments",
                                 "Total Number of Retweets",
                                 "Percentage of Positive Sentiments",
                                 "Percentage of Neutral Sentiments",
                                 "Percentage of Negative Sentiments"),
                     "Analytics"=c(as.integer(like),
                                   comment,
                                   retweet,
                                   round(pos_sent/nrow(df), 2),
                                   round(neut_sent/nrow(df), 2),
                                   round(neg_sent/nrow(df), 2)
                                  )
                     )
    return (results)
}