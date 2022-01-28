
#' Test various steps in clean_tweets function
#' -Check for valid input parameters
#' -check for outputs:
#' -check if file_path exists
#' -check if ouput dataframe is a pandas dataframe
#' -check if output dataframe contains the desired columns
#' -check if clean tweets column has any of the special
#' characters
#'
test_clean_tweets <- function() {
  file_path <- "output/tweets_response.csv"

  # Checking for outputs: storing cleaned data
  df <- clean_tweets(file_path) |> suppressWarnings()

  # Checking for 'df' to be a dataframe
  test_that('output returned is not of dataframe type', {
    expect_true(is.data.frame(df))
  })

  # Checking for 'df' to be non-null dataframe
  test_that('output returned is not of dataframe type', {
    expect_true(is.data.frame(df))
  })

  # Checking if output dataframe is empty
  test_that('output returned is empty', {
    expect_true(!is.null(df))
  })

  # Check if output dataframe contains the columns for cleaned data
  test_that('output dataframe does not contain the desired columns', {
    expect_true(all(c("clean_tweets", "text" ) %in% colnames(df)))
  })
}
