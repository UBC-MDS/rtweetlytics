require(tidyverse)
require(plyr)
require(dplyr)

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
plotting <- function(tweets_df, text) {
  if (!is.data.frame(tweets_df)) {
    stop("tweets_df should be a data frame")
  }
  if (!is.character(text)) {
    stop("'text' should be character type")
  }
  
  hashtag_pat <- "#[A-Za-z0-9_]+"
  hashtag <- str_extract_all(tweets_df$data.text, hashtag_pat)
  hash_plot <- hashtag %>% unlist() |> as.data.frame() |> 
    count()  %>%
    arrange(desc(freq)) %>%
    top_n(15) %>% mutate(hashtag = hashtag.....unlist.. ) |> 
    ggplot(aes(x = hashtag.....unlist.., y = freq)) +
    geom_col() +
    coord_flip() +
    labs(x = "Count",
         y = "Hashtag",
         title = "Top 15 Popular Hashtags")
  
  return(hash_plot)
}