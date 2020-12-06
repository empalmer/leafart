test_that("parameters include everything nescesary", {
  expect_length(get_params(),5)
  expect_length(get_ginkgo_params(),5)
})
