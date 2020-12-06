test_that("leaf collection", {
  params <- get_params(n_leaves = 10)
  leaves <- create_leaf_pile(params)
  expect_true("x" %in% colnames(leaves))
  expect_true("y" %in% colnames(leaves))
  expect_true("step" %in% colnames(leaves))
  expect_true("leaf_id" %in% colnames(leaves))

  expect_equal(max(leaves$leaf_id),10)


})
