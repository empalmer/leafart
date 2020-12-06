test_that("raked leaves correct dimensions", {
  raked_leaves <- get_params() %>% grow_leaf() %>% rake_leaves()
  expect_true("x" %in% colnames(raked_leaves))
  expect_true("y" %in% colnames(raked_leaves))
  expect_true("step" %in% colnames(raked_leaves))
})
