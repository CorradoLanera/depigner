test_that("output classes are correct", {
  testthat::skip_on_cran()
  my_summary <- Hmisc:::summary.formula(Species ~ .,
                                        data = iris, method = "reverse"
  )

  expect_s3_class(tidy_summary(my_summary), "tbl_df")
  expect_s3_class(tidy_summary(my_summary), "data.frame")
})




old_opt <- options(datadist = "dd")
on.exit(options(old_opt))

n <- 1000
age <- 50 + 12 * rnorm(n)
sex <- factor(sample(c("m", "f"), n, rep = TRUE, prob = c(.6, .4)))

cens <- 15 * runif(n)
h <- .02 * exp(.04 * (age - 50) + .8 * (sex == "f"))
dt <- -log(runif(n)) / h
e <- ifelse(dt <= cens, 1, 0)
dt <- pmin(dt, cens)


test_that("correct class", {
  skip_on_cran()

  dd <- rms::datadist(age, sex)
  options(datadist = "dd")
  s <- survival::Surv(dt, e)
  f <- rms::cph(s ~ rms::rcs(age, 4) + sex)

  my_summary <- summary(f)

  expect_s3_class(tidy_summary(my_summary), "data.frame")
})









test_that("tidy_summary return var names too (#17)", {

  result <- tidy_summary(
    summary(Species ~ ., data = iris, method = "reverse")
  )

  expect_equal(
    result[[1]],
    c("Sepal.Length", "Sepal.Width", "Petal.Length", "Petal.Width")
  )

})
