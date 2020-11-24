# This function is what initializes each tree - basically just the stalk
leaf_stalk <- function() {
  sapling <-
  return(sapling)
}

# for each existing shoot on the tree, grow an additional shoot that
# extends it; then prune some of them away
grow_leaf_veins <- function(time, shoots, param) {
  n_shoots <- nrow(shoots)
  n_pruned <- stats::rbinom(n = 1, size = n_shoots - 1, prob = param$prune)

  ch_seg_len <- sample(x = param$scale, size = n_shoots, replace = TRUE)
  ch_seg_deg <- sample(x = param$angle, size = n_shoots, replace = TRUE)

  shoots <- shoots %>%
    dplyr::mutate(
      x_0 = x_2,
      y_0 = y_2,
      seg_len = seg_len * ch_seg_len,
      x_1 = x_0 + extend_x(seg_len/2, seg_deg),
      y_1 = y_0 + extend_y(seg_len/2, seg_deg),
      seg_deg = seg_deg + ch_seg_deg,
      id_time = id_time + 1L,
      x_2 = x_0 + extend_x(seg_len, seg_deg) ,
      y_2 = y_0 + extend_y(seg_len, seg_deg),
    ) %>%
    dplyr::sample_n(size = n_shoots - n_pruned)

  return(shoots)
}


grow_leaf_random <- function(sapling, param) {
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
    .f = grow_leaf_layer,
    .init = initialize,
    param = param
  )
  return(tree)
}





