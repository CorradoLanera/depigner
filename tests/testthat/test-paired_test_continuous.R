context("test-paired_test_continuous")

which_selected <- iris$Species != "setosa"
two_obs    <- iris$Sepal.Length[which_selected]
two_groups <- iris$Species[which_selected] %>% droplevels()

obs <- iris$Sepal.Length
many_groups <- iris$Species

test_that("output class is correct", {
  expect_is(paired_test_continuous(two_groups, two_obs), "list")
  expect_is(paired_test_continuous(many_groups, obs), "list")
})

test_that("output structure is correct", {
  expect(all(
    c("P", "stat", "df", "testname", "statname", "namefun") %in%
    names(paired_test_continuous(two_groups, two_obs))
  ))
  expect(all(
    c("P", "stat", "df", "testname", "statname", "namefun") %in%
    names(paired_test_continuous(many_groups, obs))
  ))
})
