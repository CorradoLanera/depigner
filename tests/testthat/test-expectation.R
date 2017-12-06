context("Expectation about class of input and output")

old_opt <- options(datadist = 'dd')
on.exit(options(old_opt))

data('transplant', package = 'survival')
transplant <- transplant[transplant[['event']] != 'censored', , drop = FALSE]

# strong assignment because the scope of test <https://goo.gl/LJn9rF>
dd <<- rms::datadist(transplant)

lrm_mod <- rms::lrm(event ~ rms::rcs(age, 3)*(sex + abo) + rms::rcs(year, 3),
                    data = transplant, model = TRUE, x = TRUE, y = TRUE
)

ols_mod <- rms::ols(futime ~ rms::rcs(age, 3)*(sex + abo) + rms::rcs(year, 3),
                    data = transplant, model = TRUE, x = TRUE, y = TRUE
)

s_sex    <- summary_interact(lrm_mod, age, sex)
s_ref    <- summary_interact(lrm_mod, age, sex, ref_min = 60, ref_max = 80)
s_digits <- summary_interact(lrm_mod, age, sex, ref_min = 60, ref_max = 80, digits = 5L)
s_abo    <- summary_interact(lrm_mod, age, abo)
s_lev    <- summary_interact(lrm_mod, age, abo, level = c('A', 'AB'))



test_that("expectation class", {
  expect_is(s_sex, 'data.frame')
  expect_is(s_ref, 'data.frame')
  expect_is(s_digits, 'data.frame')
  expect_is(s_abo, 'data.frame')
  expect_is(s_lev, 'data.frame')
})

test_that("expectation throws error if input not an lrm", {
  expect_error(summary_interact(ols_mod, age, sex), "model has to inherits to lrm class")
})
