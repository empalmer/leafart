
stalk <- function() {
  sapling <- tibble::tibble(
    #x_0 = 0, y_0 = 0,  # first shoot starts at origin
    # Need to edit this so i can place a tree anywhere
    # Choose a random first location
    x_0 = sample(1:100,1),
    y_0 = sample(1:100,1),

    x_1 = x_0, y_1 = y_0 + .5, # first shoot guide is its midpoint
    #x_2 = 0, y_2 = 1,  # first shoot grow to y = 1
    x_2 = x_0, y_2 = y_0 + 1,
    seg_deg = 90,      # segment orientation is vertical
    seg_len = 1,       # segment length is 1
    id_time = 1L       # the acorn grows at "time 1"
  )
  return(sapling)
}

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


plant_forest <- function(ntrees = 60){
   map(.x = 1:ntrees, .f = ~stalk())
}
