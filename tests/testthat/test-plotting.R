#' Test various steps in plotting function
#' -Check for valid input parameters
#' -check for outputs:
#' -check if plot prints
#'
#'

test_plotting <- function() {
  tweets_df <- read_csv(tests/testthat/output/clean_tweets.csv)
  hash_plot <- clean_tweets(tweets_df, 'data.text') |> suppressWarnings()
  test_that("Printing ggplot object actually works",{
    expect_error(print(hash_plot), NA)
  })
}
