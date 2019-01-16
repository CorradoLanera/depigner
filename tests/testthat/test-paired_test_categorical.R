context("test-paired_test_categorical")

data(Arthritis, package = "vcd")

tab_two  <- table(Arthritis$Sex, Arthritis$Treatment)
tab_more <- table(Arthritis$Sex, Arthritis$Improved)

test_that("output class is correct", {
  expect_is(paired_test_categorical(tab_two), "list")
  expect_is(paired_test_categorical(tab_more), "list")
})

test_that("output structure is correct", {
  expect(all(
    c("P", "stat", "df", "testname", "statname", "namefun") %in%
      names(paired_test_categorical(tab_two))
  ))
  expect(all(
    c("P", "stat", "df", "testname", "statname", "namefun") %in%
      names(paired_test_categorical(tab_more))
  ))
})
