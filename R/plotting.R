require(tidyverse)
require(plyr)

#' Plot the most frequently occurring hash tags
#'
#' `plotting` creates a horizontal bar chart using `ggplot2` syntax.
#'
#' @param tweets_df
#'        a data frame or tibble
#'
#' @param text
#'        column containing text
#'
#' @return hash_plot
#'         A `ggplo2` plot
#'
#' @examples
#'hash_plot <- plotting(tweets_df, text)
#'

# The `plotting` function
plotting <- function(tweets_df, text) {
  if (!is.data.frame(tweets_df)) {
    stop("x should be a data frame")
  }
  if (!is.character(text)) {
    astop("column should contain text")
  }

  hashtag_pat <- "#[a-zA-Z0-9_-ー\\.]+"
  hashtag <- str_extract_all(tweets_df$text, hashtag_pat)
  hashtag_word <- unlist(hashtag)
  hash_plot <- as.data.frame(hashtag_word) %>%
    count(hashtag_word, sort = TRUE) %>%
    mutate(hashtag_word = reorder(hashtag_word, n)) %>%
    top_n(15) %>%
    ggplot(aes(x = hashtag_word, y = n)) +
    geom_col() +
    coord_flip() +
    labs(x = "Count",
         y = "Hashtag",
         title = "Top 15 Popular Hashtags")

  return(hash_plot)
}
