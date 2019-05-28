context("test-paired_test_categorical")

data(Arthritis)

tab_two  <- table(Arthritis$Sex, Arthritis$Treatment)
tab_more <- table(Arthritis$Sex, Arthritis$Improved)

test_that("output class is correct", {
  expect_is(paired_test_categorical(tab_two), "list")
  expect_is(paired_test_categorical(tab_more), "list")
})

test_that("output structure is correct", {
  expect_true(all(
    c("P", "stat", "df", "testname", "statname", "namefun") %in%
      names(paired_test_categorical(tab_two))
  ))
  expect_true(all(
    c("P", "stat", "df", "testname", "statname", "namefun") %in%
      names(paired_test_categorical(tab_more))
  ))
})

test_that("wrong input return NA list", {
  expect_is(paired_test_categorical(c(1, 2)), "list")
  expect_true(is.na(paired_test_categorical(c(1, 2))[["P"]]))

  expect_is(paired_test_categorical(matrix(c(1, 2))), "list")
  expect_true(is.na(paired_test_categorical(matrix(c(1, 2)))[["P"]]))

  expect_is(
    paired_test_categorical(matrix(c(1, 2), ncol = 2)),
    "list"
  )
  expect_true(
    is.na(paired_test_categorical(matrix(c(1, 2), ncol = 2))[["P"]])
  )

})


test_that("singular matrix were managed", {
  expect_warning(
    paired_test_categorical(matrix(c(1, 0, 2, 0), ncol = 2))
  )

  expect_is(
    suppressWarnings(
      paired_test_categorical(matrix(c(1, 0, 2, 0), ncol = 2))
    ),
    "list"
  )
  expect_true(is.na(
    suppressWarnings(
      paired_test_categorical(matrix(c(1, 0, 2, 0), ncol = 2))[["P"]]
    )
  ))

})
