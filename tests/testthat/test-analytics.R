

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