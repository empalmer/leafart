#' Split the end of a branch
#'
#' This is the one iteration that is repeated to
#'
#' @param leaf
#' @param param
#' @param n_grow_iter
#'
#' @return
#' @export
#'
#' @examples
one_branch <- function(partial_leaf, param, n_grow_iter) {
  n_shoots <- nrow(partial_leaf)
  scaled_length <- sample(x = param$scale, size = n_shoots, replace = TRUE)
  angle_adjust <- sample(x = param$angle, size = n_shoots, replace = TRUE)

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



#' Grow every layer of the leaf
#'
#' At every layer of the leaf, the
#'
#' @param leaf
#' @param param
#' @param n_grow_iter
#'
#' @return
#' @export
#'
#' @examples
grow_leaf_layers <- function(leaf, param, n_grow_iter) {
  leaf_growth <- purrr::map_dfr(
    .x = 1:param$split,
    .f = one_branch,
    partial_leaf = leaf,
    param = param
  )
  return(leaf_growth)
}


#' Grow ONE leaf at a random position and angle
#'
#' @param param
#'
#' @return
#' @export
#'
#' @examples
grow_leaf_random <- function(param) {
  # create a tibble that initializes one leaf
  initialize <- tibble(
    # Choose a random first location, smaller selection for leafs falling
    x_0 = sample(1:50,1),
    y_0 = sample(1:50,1),
    x_1 = x_0,
    y_1 = y_0 + 1,
    angle = sample(-180:180,1), # Random orientation of leaf orientation
    length = 1,       # initial
    iter_n = 1L       # time used for
  )

  tree <- purrr::accumulate(
    .x = 1:param$n_grow_iter,
    .f = grow_leaf_layers,
    .init = initialize,
    param = param
  )
  return(tree)
}



#' Grow ONE leaf at ORIGIN
#'
#' This function is the highest level to create a leaf.
#'
#' It starts with an initial leaf, which is essentially just a stalk
#'
#' It calls growth_leaf_layers and one_branch to recursively grow the tree
#'
#'
#' @param param A list of parameter values that give the leaves their
#' shape
#'
#' @return
#' @export
#'
#' @examples
grow_leaf <- function(param) {

  initial_leaf <- tibble::tibble(
    # All leafs have a zero location to initialize.
    #x_0 = 0,
    #y_0 = 0,
    x_0 = param$x_0,
    y_0 = param$y_0,

    x_1 = x_0 + cos(radians(param$init_angle)),
    y_1 = y_0 + sin(radians(param$init_angle)),

    # Default to vertical
    #angle = pi,
    #angle = 90,
    angle = param$init_angle,
    length = 1L,       # initial segment length is 1
    iter_n = 1L
  )

  full_leaf <- purrr::accumulate(
    .x = 1:param$n_grow_iter,
    .f = grow_leaf_layers,
    .init = initial_leaf,
    param = param
  )
  return(full_leaf)
}
