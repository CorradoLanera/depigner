context("test-paired_test_continuous")

iris <- dplyr::group_by(iris, Species) %>%
  dplyr::mutate(id = dplyr::row_number()) %>%
  dplyr::ungroup() %>%
  dplyr::arrange(id)

which_selected <- iris$Species != "setosa"
two_obs <- iris$Sepal.Length[which_selected]
two_groups <- iris$Species[which_selected] %>% droplevels()

obs <- iris$Sepal.Length
many_groups <- iris$Species

test_that("output class is correct", {
  skip_on_cran()

  expect_is(paired_test_continuous(two_groups, two_obs), "list")
  expect_is(paired_test_continuous(many_groups, obs), "list")
})

test_that("output structure is correct", {
  skip_on_cran()

  expect_true(all(
    c("P", "stat", "df", "testname", "statname", "namefun") %in%
      names(paired_test_continuous(two_groups, two_obs))
  ))
  expect_true(all(
    c("P", "stat", "df", "testname", "statname", "namefun") %in%
      names(paired_test_continuous(many_groups, obs))
  ))
})


test_that("wrong input are managed", {
  skip_on_cran()

  expect_usethis_error(
    paired_test_continuous(factor(c(1, 2)), 1),
    "length"
  )
  expect_warning(paired_test_continuous(c(1, 2), c(1, 2)), "factor")
})


test_that("data by groups are managed", {
  skip_on_cran()

  ord <- order(two_groups)

  expect_is(
    paired_test_continuous(two_groups[ord], two_obs[ord]),
    "list"
  )

  expect_warning(
    paired_test_continuous(two_groups[ord][-1], two_obs[ord][-1]),
    "incomplete"
  )

  expect_gte(
    suppressWarnings(
      paired_test_continuous(two_groups[ord][-1], two_obs[ord][-1])
    )[["P"]],
    9
  )
})



test_that("one group is managed", {
  skip_on_cran()

  expect_warning(
    paired_test_continuous(factor(c("a", "a", "a")), c(1, 2, 3)),
    "Only one group with data, no paired test is done"
  )
})
