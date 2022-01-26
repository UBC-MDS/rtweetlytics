test_that("analytics() total likes", {
  expect_equal(analytics("df.csv")$Analytics[1], 266)
})
