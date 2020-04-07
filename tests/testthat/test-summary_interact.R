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
s_abo_p  <- summary_interact(lrm_mod, age, abo, p = TRUE)
s_lev    <- summary_interact(lrm_mod, age, abo, level = c('A', 'AB'))



test_that("expectation class", {
  expect_is(s_sex, 'data.frame')
  expect_is(s_ref, 'data.frame')
  expect_is(s_digits, 'data.frame')
  expect_is(s_abo, 'data.frame')
  expect_is(s_lev, 'data.frame')
  expect_is(s_abo_p, 'data.frame')
})

test_that("expectation throws error if input not an lrm", {
  expect_usethis_error(
    summary_interact(ols_mod, age, sex),
    "model has to inherits to lrm class"
  )
})

test_that("Without refname in datadist it trows an error", {
  expect_usethis_error(summary_interact(lrm_mod, age, sexx), "datadist")
  expect_usethis_error(summary_interact(lrm_mod, agee, sex), "datadist")
})


options(datadist = NULL)

test_that("Without datadist it trows an error", {
  expect_usethis_error(summary_interact(lrm_mod, age, sex), "datadist")
})
