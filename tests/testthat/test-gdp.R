context("test-gdp")

test_that("time is correct", {
  tmp <- tempfile()
  sink(tmp)
  running_time <- system.time(res <- gdp(0.5))[[3]]
  sink()
  unlink(tmp)

  expect_gt(running_time, 0.49)
  expect_equal(res, "You are the power!")
})
