
<!-- README.md is generated from README.Rmd. Please edit that file -->

# rtweetlytics

This package would retrieve tweets on a required topic and time frame, stores them, performs data cleaning, data analysis, and plotting.

# rtweetlytics

<!-- badges: start -->
<!-- badges: end -->

The goal of rtweetlytics is to …

## Installation

You can install the released version of rtweetlytics from
[CRAN](https://CRAN.R-project.org) with:

``` r
install.packages("rtweetlytics")
```

And the development version from [GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("UBC-MDS/rtweetlytics")
```

## Features

The package tweetytics is a package intended to give insight about a topic on Tweeter through some functions. The intention is that a user with little knowledge about data science can quickly call a function to analyze how the topics and trends are on Twitter. Internally, the package uses the official twitter API, stores the data as a .json and .csv file, performs data cleaning, data analysis and plotting.

There are four main functions planned for development and they are outlined below.  Additional functions may be added if time permits.

### Function 1: get_store

Utilizes the official Twitter API to collect data based on a keyword, date range and number of results the user requires. The data is then stored as a .Json file and a .csv file(optional). The function will also give the user the option to return a pandas data frame based on the stored files.

### Function 2: clean

Takes the created pandas data frame from the get_store() function and clean the data frame based on the required_cols, keep_punctuation, only_words… arguments entered by the user.

### Function 3: perform_analysis

Takes the tidy data frame from the clean() function and returns an analysis dict report including mean_word_count, most used words, mean_likes, most_used_hashtags, word_hashtag_ratio …

### Function 4: plotting

Taking both the cleaned data frame from the clean() function and the returned dict from the perform_analysis() function, a range of plots such as likes_wordcount, likes_hashtags… will be generated and saved as files.

### Note

•As working with the Twitter API requires a personal ‘bearer token’ a user can create their own token and add it as a parameter to the get_store() function.
•The package also include an example .Json and .csv file  based on the keyword ‘omicron’.

## Dependencies

 • TBD

## Usage
 TBD
 
## Documentation

The official documentation is hosted on Read the Docs: https:// tweetytics.readthedocs.io/en/latest/

## Contributing

IWe welcome and recognize all contributions. You can see a list of current contributors in the [contributors tab]( https://github.com/UBC-MDS/tweetlytics/blob/main/CONTRIBUTING.md).

* Amir Shojakhani: @amirshoja
* Shiva Shankar Jena: @shivajena
* Mahmood Rahman: @mahm00d27
* Mahsa Sarafrazi: @mahsasarafrazi

## License

`rtweetlytics` was created by group of students in UBC MDS program. It is licensed under the terms of the MIT license.
