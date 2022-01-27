#' Test various features of the get_store() function.
#'
#'- Check if .csv file is created
#'- Check if the result is a dataframe
#'- Check the column names of the returned dataframe
#'- Check the number of returned rows in the dataframe
#'
#' @return None
#' @export
#'
#' @examples
#' test_get_store()
test_get_store <- function() {
  bearer_token = Sys.getenv("BEARER_TOKEN")
  if (nchar(bearer_token) >= 1) {
    # run the function
    tweets_results_df <- get_store(bearer_token, keyword="vancouver",
                                   start_date="2022-01-23", end_date="2022-01-26")

    # Check if .csv file is created
    test_that('Output file does not exist', {
      expect_true(file.exists("output/tweets_response.csv"))
    })
    # Check if the result is a dataframe
    test_that("tweets_results_df should be a dataframe", {
      expect_true(any("data.frame" %in% class(tweets_results_df)))
    })
    # Check the column names of the returned dataframe
    test_that("Missing columns in the output dataframe", {
      expect_true(all(c(
        "data.source",
        "data.author_id",
        "data.created_at",
        "data.conversation_id",
        "data.lang",
        "data.reply_settings",
        "data.referenced_tweets",
        "data.id",
        "data.text",
        "data.in_reply_to_user_id",
        "data.public_metrics.retweet_count",
        "data.public_metrics.reply_count",
        "data.public_metrics.like_count",
        "data.public_metrics.quote_count"
      ) %in% colnames(tweets_results_df)))
    })
    # Check the number of returned rows in the dataframe
    test_that("tweets_results_df did not return correct number of rows", {
      expect_true(nrow(tweets_results_df) == 25)
    })
  }
}

test_get_store()
