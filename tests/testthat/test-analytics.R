test_that("analytics() total likes", {
  expect_equal(analytics("output/tweets_response.csv")$Analytics[1], 13)
})

test_that("analytics() total comments", {
  expect_equal(analytics("output/tweets_response.csv")$Analytics[2], 4)
})

test_that("analytics() total comments", {
  expect_equal(analytics("output/tweets_response.csv")$Analytics[3], 2657)
})