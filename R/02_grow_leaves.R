#' Split the end of a branch
#'
#' At each endpoint a leaf is growing from, split/branch depending on the parameters
#' This is the one iteration that is repeated on each endpoint of each leaf layer
#'
#'
#'
#' @param partial_leaf The leaf in progress of being grown
#' @param param The parameters specifying how to grow the leaf
#' @param n_layer Keeps track of the growth
#'
#' @return The leaf with the new growth of splits
#' @export
#'
one_branch <- function(partial_leaf, param, n_layer) {
  n_new_branches <- nrow(partial_leaf)
  # Do some check if the size of the angle vector matches the number of new branches
  scaled_length <- sample(x = param$scale, size = n_new_branches, replace = TRUE)
  angle_adjust <- sample(x = param$angle, size = n_new_branches, replace = TRUE)

  partial_leaf <- partial_leaf %>%
    dplyr::mutate(
      x_0 = x_1,
      y_0 = y_1,
      length = length * scaled_length,
      angle = angle + angle_adjust,
      iter_n = iter_n + 1L,
      x_1 = x_0 + length * cos(radians(angle)) ,
      y_1 = y_0 + length * sin(radians(angle)),
    )

  return(partial_leaf)
}



#' Grow one layer of the leaf
#'
#' Leafs grow outward from the stem in layers. At each layer, we branch at each endpoint
#'
#' Calls `one_branch()` at each of the endpoints in the current layer
#'
#' @param leaf The leaf in process of being grown
#' @param param The parameters specifying how to grow the leaf
#' @param n_layer Keeps track of the growth
#'
#' @return The leaf with a newly grown layer
#' @export
#'

grow_leaf_layers <- function(leaf, param, n_layer) {
  # Add randomness into the split parameter
  splits <- ifelse(length(param$split) == 1,
                   param$split,
                   sample(param$split,1))
  leaf_growth <- purrr::map_dfr(
    .x = 1:splits,
    .f = one_branch,
    partial_leaf = leaf,
    param = param
  )
  return(leaf_growth)
}



#' Grow ONE leaf
#'
#' This function is the highest level to create a leaf.
#'
#' It starts with an initial leaf, which is essentially just a stalk. Depending on the parameter values, this is either grown at the origin or a randomly placed location
#'
#' It calls growth_leaf_layers and one_branch to recursively grow the tree
#'
#'
#' @param param A list of parameter values that give the leaves their
#' shape
#' @param init_location A character of either "random" or "origin"
#'
#' @return
#' @export
#'

grow_leaf <- function(param, init_location = "random") {
  # initialize at a random location or at origin
  if(init_location == "random"){
    x_0 <- sample(1:50,1)
    y_0 <- sample(1:50,1)
    init_angle <- sample(-180:180,1)
  } else{
    x_0 <- 0
    y_0 <- 0
    init_angle <- 90
  }
  # make tree vertical if there is only one
  if(param$n_leaves ==1){
    init_angle <- 90
  }

  initial_leaf <- tibble::tibble(
    x_0 = x_0,
    y_0 = y_0,
    x_1 = x_0 + cos(radians(init_angle)),
    y_1 = y_0 + sin(radians(init_angle)),
    angle = init_angle,
    length = 1L,
    iter_n = 1L
  )

  full_leaf <- purrr::accumulate(
    .x = 1:param$n_layer,
    .f = grow_leaf_layers,
    .init = initial_leaf,
    param = param
  )
  return(full_leaf)
}
