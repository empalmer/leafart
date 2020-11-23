
radians <- function(degree) {
  2 * pi * degree / 360
}


#' Initialize a single leaf
#'
#' This function initilizes a single leaf starting at the origin
#' It is basically
#'
#' @return a tibble iwth a basic leaf
#' @export
#'
#' @examples
#'
initialize <- function(){
  leaf <- tibble::tibble(
    # All leafs have a zero location to initialize.
    x_0 = 0,
    y_0 = 0,

    # Random initial orientation of leaf orientation
    # in radians
    # rotation will happen later

    # Leafs are by default vertical, when placed angle will change.
    x_1 = x_0, y_1 = y_0 + .5, # first shoot guide is its midpoint
    #x_2 = 0, y_2 = 1,  # first shoot grow to y = 1
    x_2 = x_0, y_2 = y_0 + 1,
    #angle = pi,
    angle = 90,
    #angle = sample(-180:180,1),
    length = 1L,       # initial segment length is 1
    id_time = 1L
    # first shoot guide is its midpoint
    #x_1 = x_0 + .5 * cos(angle),
    #y_1 = y_0 + .5 * sin(angle),

    #x_2 = x_0 + cos(angle),
    #y_2 = y_0 + sin(angle),


  )
  return(leaf)
}

growth <- function(leaf, param, time) {
  n_shoots <- nrow(leaf)
  scaled_length <- sample(x = param$scale, size = n_shoots, replace = TRUE)
  angle_adjust <- sample(x = param$angle, size = n_shoots, replace = TRUE)

  leaf <- leaf %>%
    dplyr::mutate(
      x_0 = x_2,
      y_0 = y_2,
      length = length * scaled_length,
      x_1 = x_0 + length/2 * cos(radians(angle)),
      y_1 = y_0 + length/2 * sin(radians(angle)),
      angle = angle + angle_adjust,
      id_time = id_time + 1L,
      x_2 = x_0 + length * cos(radians(angle)) ,
      y_2 = y_0 + length * sin(radians(angle)),
    )

  return(leaf)
}

grow_leaf_layers <- function(leaf, param,time) {
  leaf_growth <- purrr::map_dfr(
    .x = 1:param$split,
    .f = growth,
    leaf = leaf,
    param = param
  )
  return(leaf_growth)
}


full_leaf <- function(initial_leaf, param) {
  full_leaf <- purrr::accumulate(
    .x = 1:param$time,
    .f = grow_leaf_layers,
    .init = initial_leaf,
    param = param
  )
  return(full_leaf)
}



rake_leaves <- function(leaf) {
  leaf <- leaf %>%
    dplyr::bind_rows() %>%
    dplyr::mutate(id_path = as.integer(1:dplyr::n())) %>%
    tidyr::pivot_longer(
      cols = x_0:y_2,
      names_to = "id_step",
      values_to = "coord"
    ) %>%
    tidyr::separate(col = id_step, into = c("axis", "id_step")) %>%
    tidyr::pivot_wider(names_from = axis, values_from = coord) %>%
    dplyr::select(x,y) %>%
    dplyr::mutate(color = sample(1:6,1))
  return(leaf)
}

origin_leaf_pile <- function(n_leaf, n_distinct){

}

initial_angle <- function(leaf){
  rot_angle <- sample(-180:180,1)

  leaf <- leaf %>%
    mutate(xnew = x * cos(radian(rot_angle)) - y * sin(radian(rot_angle)),
           ynew = x * sin(radian(rot_angle)) + y * cos(radian(rot_angle))) %>%
    select()
  dplyr::rename(coord_x = x, coord_y = y) %>%
    dplyr::select(
      coord_x, coord_y, seg_deg, seg_len, seg_col, seg_wid,
      id_time, id_path, id_step
    )


}

initial_location <- function(leaf){
  x_loc <- sample(1:50,1)
  y_loc <- sample(1:50,1)

  leaf <- leaf %>%
    mutate(x = x + x_loc,
           y = y + y_loc)
  return(leaf)
}




leaf_location <- function(leaf,x_diff,y_diff){

}


plot_leaves <- function(leaves,
                        pal = c( "#D1CEC5", "#997C67", "#755330",
                                 "#B0703C", "#DBA72E", "#E3CCA1")){
  p <- ggplot(leaves,aes(x = x,y= y,
                         #group= leaf_id,
                         color = factor(color))) +
    geom_path() +
    theme_void() +
    theme(legend.position = "none",
          plot.background = element_rect(fill = "gray74")) +
    scale_color_manual(values = pal)
  return(p)

}
