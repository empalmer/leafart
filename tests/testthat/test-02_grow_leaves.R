test_that("Number of layers correct", {
  param <- get_params(n_leaves = 1,
                      n_layer = 3,
                      scale = c(.8,.9),
                      angle = c(-30,10,20),
                      split = 3)
  expect_length(grow_leaf(param), param$n_layer +1)
})

test_that("number of branches correct",{
  param <- get_params(n_layer = 3,split = 3)
  leaf <- grow_leaf(param)
  expect_equal(map_dbl(leaf,nrow),rep(param$split)^(0:param$n_layer))

  param <- get_params(n_layer = 6,split = 5)
  leaf <- grow_leaf(param)
  expect_equal(map_dbl(leaf,nrow),rep(param$split)^(0:param$n_layer))

})

