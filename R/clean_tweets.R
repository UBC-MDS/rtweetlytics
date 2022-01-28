#' Cleans the text in the tweets and returns as new columns in the dataframe.
#' The cleaning process includes converting into lower case, removal of
#' punctuation, hastags and hastag counts
#'
#' @param file_path
#'        character
#'        File path to csv file containing tweets data
#'
#' @param tokenization
#'        logical
#'        Creates new column containing cleaned tweet word tokens when True
#'        Default is True
#' @param word_count
#'        logical
#'        Creates new column containing word count of cleaned tweets
#'        Default is True
#' @return df_tweets
#'        Dataframe
#'        Dataframe containing data on cleaned tweets
#' .
#' @examples
#' clean_tweets("tweets_response.csv")
#'
#'
clean_tweets <- function(file_path, tokenization=TRUE, word_count=TRUE) {
  # Checking for valid input parameters
  if(!is.character(file_path)){
    stop("'input_file' must be of character type")
  }

  if(!is.logical(tokenization)){
    stop("'tokenization' must be of logical type")
  }

  if(!is.logical(word_count)){
    stop("'word_count' must be of logical type")
  }

  # Reading in the raw dataframe and removing redundant columns
  tweets_df <- read_csv(file_path) |>
    subset(select = -c(public_metrics))

  # Checking for 'df' to be a dataframe
  if(!is.data.frame(tweets_df)){
    stop("'df' must be of non-NULL dataframe type.")
  }

  # Iterating through each row
  for (i in 1:nrow(tweets_df)) {

    # Extracting tweet text from text column
    tweet <- tweets_df$text[i]

    # Cleaning tweet
    clean_tweet <- tweet |>

      # Removing retweet tag 'RT @xx:'
      str_remove_all("RT\\s@.*:\\s") |>

      # Lowercasing
      str_to_lower() |>

      # Cleaning hashtags and mentions in tweet
      str_remove_all("@[A-Za-z0-9_]+") |>
      str_remove_all("#[A-Za-z0-9_]+") |>

      # Cleaning links
      str_remove_all("http\\S+") |>
      str_remove_all("www.\\S+") |>

      # Cleaning punctuations
      str_remove_all("[[:punct:]]")


    # Adding clean_tweets column
    tweets_df$clean_tweets[i] <- clean_tweet

    # Adding clean_tokens column
    if (tokenization) {
      tweets_df$clean_tokens[i] <- clean_tweet |>
        str_replace_all("[ ]",',')
    }

    # Adding word_count column
    if (word_count) {
      tweets_df$word_count[i] <- str_split(clean_tweet, " ") |>
        lengths()
    }
  }
  return(tweets_df)
}
