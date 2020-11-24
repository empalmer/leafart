
# for each existing shoot on the tree, grow an additional shoot that
# extends it; then prune some of them away
one_branch_random <- function(time, partial_leaf, param) {
  n_shoots <- nrow(partial_leaf)
  n_pruned <- stats::rbinom(n = 1, size = n_shoots - 1, prob = param$prune)

  ch_seg_len <- sample(x = param$scale, size = n_shoots, replace = TRUE)
  ch_seg_deg <- sample(x = param$angle, size = n_shoots, replace = TRUE)


  partial_leaf <- partial_leaf %>%
    dplyr::mutate(
      x_0 = x_2,
      y_0 = y_2,
      seg_len = seg_len * ch_seg_len,
      x_1 = x_0 + seg_len/2 * cos(radians(seg_deg)),
      y_1 = y_0 + seg_len/2 * sin(radians(seg_deg)),
      seg_deg = seg_deg + ch_seg_deg,
      id_time = id_time + 1L,
      x_2 = x_0 + seg_len * cos(radians(seg_deg)) ,
      y_2 = y_0 + seg_len * sin(radians(seg_deg)),
    ) %>%
    dplyr::sample_n(size = n_shoots - n_pruned)

  return(partial_leaf)
}

grow_leaf_layers_random <- function(leaf, param,time) {
  leaf_growth <- purrr::map_dfr(
    .x = 1:param$split,
    .f = one_branch_random,
    partial_leaf = leaf,
    param = param
  )
  return(leaf_growth)
}


grow_leaf_random <- function(param) {
  # create a tibble that initializes one leaf
  initialize <- tibble(
    # Choose a random first location, smaller selection for leafs falling
    x_0 = sample(1:50,1),
    y_0 = sample(1:50,1),
    x_1 = x_0, y_1 = y_0 + .5, # first shoot guide is its midpoint
    x_2 = x_0, y_2 = y_0 + 1,
    seg_deg = sample(-180:180,1), # Random orientation of leaf orientation
    seg_len = 1,       # initial
    id_time = 1L       # time used for
  )

  tree <- purrr::accumulate(
    .x = 1:param$time,
    .f = grow_leaf_layers_random,
    .init = initialize,
    param = param
  )
  return(tree)
}





