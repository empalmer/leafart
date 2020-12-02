#' Get default parameters for making ginkgo leaves
#'
#' Output parameters:
#' - seed: set.seed() for reproducibility
#' - n_grow_iter: number of times to grow a layer - how 'full' a leaf is
#' - scale : A vector of possible re-scaling for the length of each layer
#' - angle : A vector of possible angles for new branches to go
#' - split : The number of new branches at each branching point
#'
#' @param nleaves The number of leafs to create, defaults to 10
#' @param ndistinct The number (at most) of distinct leaves to create, if using the `spread_leaves()` function
#' @param init_location One of "random" or "origin" Are leaves grown at the origin or grown and rotated randomly?
#' @param color_palette A color palette for plotting the leaves, defaults to a fall aesthetic
#'
#'
#' @return A list of parameter values that make the leaves look like ginkgo
#' leaves.
#'
#' @export
#'
get_ginkgo_params <- function(nleaves = 25,
                              ndistinct = 6,
                              init_location = "random"){
  params <- list(
    nleaves = nleaves,
    ndistinct = ndistinct,
    seed = 286,
    n_grow_iter = 6,
    scale = c(.8,.9),
    angle = c(-10,10,20),
    split = 3,
    init_location = init_location
  )
  return(params)
}



# maybe add a randomness to the scale and angle for a range of values that make it look good?
get_params <- function(nleaves = 10,
                              ndistinct = 6,
                              init_location = "random"){
  params <- list(
    nleaves = nleaves,
    ndistinct = ndistinct,
    seed = 286,
    n_grow_iter = 3,
    scale = c(.4,.5,.9),
    angle = c(-30,10,20),
    split = 1,
    init_location = init_location
  )
  return(params)
}
