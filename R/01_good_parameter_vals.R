#' Get default parameters for making ginkgo leaves
#'
#' Output parameters:
#' - seed: set.seed() for reproducibility
#' - n_layer: number of times to grow a layer - how 'full' a leaf is
#' - scale : A vector of possible re-scaling for the length of each layer
#' - angle : A vector of possible angles for new branches to go
#' - split : The number of new branches at each branching point
#'
#' @param nleaves The number of leafs to create, defaults to 10
#'
#' @return A list of parameter values that make the leaves look like ginkgo
#' leaves.
#'
#' @export
#'
get_ginkgo_params <- function(nleaves = 25){
  params <- list(
    nleaves = nleaves,
    n_layer = 6,
    scale = c(.8,.9),
    angle = c(-10,10,20),
    split = 3
  )
  return(params)
}


#' Create a parameter list
#'
#' @param nleaves The number of leaves to generate
#' @param n_layer How many layers to grow
#' @param scale A single value or vector of scaling length options
#' @param angle A single value or vector of angles to split from
#' @param split A single value or vector of the number of splits at each branch
#'
#' @return
#' @export
#'
get_params <- function(nleaves = 1,
                       n_layer = 3,
                       scale = c(.8,.9),
                       angle = c(-30,10,20),
                       split = 3){
  params <- list(
    nleaves = nleaves,
    n_layer = n_layer,
    scale = scale,
    angle = angle,
    split = split
  )
  return(params)
}
