#' Test analytics function
#' -checking the number of likes
#' -check the number of comments
#' -check the number of retweets
#' -check the output of the function to be a tibble
test_analytics <- function() {
  # file_input <- "output/tweets_response.csv"
    
  #testing number of likes
  test_that("analytics() total likes", {
    expect_equal(analytics("output/tweets_response.csv")$Analytics[1], 13)
  })

  #testing number of comments
  test_that("analytics() total comments", {
    expect_equal(analytics("output/tweets_response.csv")$Analytics[2], 4)
  })

  #testing number of retweets
  test_that("analytics() total retweets", {
    expect_equal(analytics("output/tweets_response.csv")$Analytics[3], 2657)
  })
  
  # Checking the output is dataframe
  test_that('output returned is not of dataframe type', {
    expect_true(is.data.frame(analytics("output/tweets_response.csv")))
  })

}
test_analytics()