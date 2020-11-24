# This function is what initializes each tree - basically just the stalk
stalk <- function() {
  sapling <- tibble::tibble(
    # Choose a random first location
    x_0 = sample(1:50,1),
    y_0 = sample(1:50,1),

    x_1 = x_0, y_1 = y_0 + .5, # first shoot guide is its midpoint
    #x_2 = 0, y_2 = 1,  # first shoot grow to y = 1
    x_2 = x_0, y_2 = y_0 + 1,
    seg_deg = 90,      # segment orientation is vertical
    seg_len = 1,       # segment length is 1
    id_time = 1L       # the acorn grows at "time 1"
  )
  return(sapling)
}

# for each existing shoot on the tree, grow an additional shoot that
# extends it; then prune some of them away
grow_shoots <- function(time, shoots, param) {

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


# to grow a "layer" of the shrub, we extend (and possibly prune) each
# existing shoot multiple times
grow_layer <- function(shoots, time, param) {

  new_shoots <- purrr::map_dfr(
    .x = 1:param$split,
    .f = grow_shoots,
    shoots = shoots,
    param = param
  )
  return(new_shoots)
}


# to grow the whole tree we need to "accumulate" the growth: starting with
# the sapling (a single shoot) we grow the second layer; the set of shoots
# that make the second layer are then used to grow the third later; and so on
grow_tree <- function(sapling, param) {

  tree <- purrr::accumulate(
    .x = 1:param$time,
    .f = grow_layer,
    .init = sapling,
    param = param
  )
  return(tree)
}


shape_tree <- function(tree) {

  tree <- tree %>%
    dplyr::bind_rows() %>%
    dplyr::mutate(id_path = as.integer(1:dplyr::n())) %>%
    tidyr::pivot_longer(
      cols = x_0:y_2,
      names_to = "id_step",
      values_to = "coord"
    ) %>%
    tidyr::separate(col = id_step, into = c("axis", "id_step")) %>%
    tidyr::pivot_wider(names_from = axis, values_from = coord) %>%
    dplyr::mutate(
      id_step = as.integer(id_step),
      seg_col = sqrt(x ^ 2 + y ^ 2) + (seg_deg - 90) / 10,
      seg_wid = exp(-id_time^2 / 10)
    ) %>%
    dplyr::rename(coord_x = x, coord_y = y) %>%
    dplyr::select(
      coord_x, coord_y, seg_deg, seg_len, seg_col, seg_wid,
      id_time, id_path, id_step
    )

  return(tree)
}

# This function rearanges the data in a neat way for it to plot - no tree growing here
arborist_call <- function(tree) {
  tree <- tree %>%
    dplyr::bind_rows() %>%
    dplyr::mutate(id_path = as.integer(1:dplyr::n())) %>%
    tidyr::pivot_longer(
      cols = x_0:y_2,
      names_to = "id_step",
      values_to = "coord"
    ) %>%
    tidyr::separate(col = id_step, into = c("axis", "id_step")) %>%
    tidyr::pivot_wider(names_from = axis, values_from = coord) %>%
    dplyr::mutate(
      id_step = as.integer(id_step),
      seg_col = sqrt(x ^ 2 + y ^ 2) + (seg_deg - 90) / 10,
      seg_wid = exp(-id_time^2 / 10)
    ) %>%
    dplyr::rename(coord_x = x, coord_y = y) %>%
    dplyr::select(
      coord_x, coord_y, seg_deg, seg_len, seg_col, seg_wid,
      id_time, id_path, id_step
    ) %>%
    dplyr::mutate(
      color = sample(1:6,1)
    )
  return(tree)
}


plot_trees <- function(tree,
                                background = "antiquewhite4",
                                palette = "viridis::inferno") {
  # specify the mapping
  mapping <- ggplot2::aes(
    x = coord_x,      # x-coordinate
    y = coord_y,      # y-coordinate
    group = id_path,  # each segment/path is a single bezier curve
    size = seg_wid,   # the seg_wid variable is used to set line width
    color = seg_col   # the seg_col variable is used to set line colour
  )
  # build the ggplot
  picture <- ggplot2::ggplot(data = tree, mapping = mapping) +
    geom_path()+
    theme_void() +
    #ggplot2::theme(
    #  panel.background = ggplot2::element_rect(
    #    fill = "white",
    #    colour = "black"
    #  )) +
    #ggforce::geom_bezier2(show.legend = FALSE, lineend = "round") +
    paletteer::scale_color_paletteer_c(palette = palette) #+
  #theme_mono(color = background)

  return(picture)
}


plant_forest_stalks <- function(ntrees = 60){
   map(.x = 1:ntrees, .f = ~stalk())
}


plant_forest_branches <- function(ntrees = 3, param){
  map_dfr(.x = 1:ntrees,
      .f = ~grow_tree(stalk(), param = param) %>%
        arborist_call() %>% mutate(tree_id = .x))
}

# old version, with extra stuff I dont use
rake_neatly_old <- function(tree) {
  tree <- tree %>%
    dplyr::bind_rows() %>%
    dplyr::mutate(id_path = as.integer(1:dplyr::n())) %>%
    tidyr::pivot_longer(
      cols = x_0:y_2,
      names_to = "id_step",
      values_to = "coord"
    ) %>%
    tidyr::separate(col = id_step, into = c("axis", "id_step")) %>%
    tidyr::pivot_wider(names_from = axis, values_from = coord) %>%
    dplyr::mutate(
      id_step = as.integer(id_step),
      seg_col = sqrt(x ^ 2 + y ^ 2) + (seg_deg - 90) / 10,
      seg_wid = exp(-id_time^2 / 10)
    ) %>%
    dplyr::rename(coord_x = x, coord_y = y) %>%
    dplyr::select(
      coord_x, coord_y, seg_deg, seg_len, seg_col, seg_wid,
      id_time, id_path, id_step
    ) %>%
    dplyr::mutate(
      color = sample(1:6,1)
    )
  return(tree)
}
