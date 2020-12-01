#' Get default parameters for making gingko leaves
#'
#' Output parameters:
#' - seed: set.seed() for reproducibility
#' - n_grow_iter: number of times to grow a layer - how 'full' a leaf is
#' - scale : A vector of possible rescaling for the length of each layer
#' - angle : A vector of possible angles for new branches to go
#' - split : The number of new branches at each branching point
#'
#' @param location One of "random" or "origin"
#'
#' @return A list of parameter values that make the leaves look like gingko
#' leaves.
#'
#' @export
#'
get_gingko_params <- function(init_location = "random",
                              nleaves = 10,
                              ndistinct = 6,
                              color_pallete = c( "#D1CEC5", "#997C67", "#755330",
                                                       "#B0703C", "#DBA72E", "#E3CCA1")){
  params <- list(
    nleaves = nleaves,
    ndistinct = ndistinct,
    seed = 286,
    n_grow_iter = 6,
    scale = c(.8,.9),
    angle = c(-10,10,20),
    split = 3,
    init_location = init_location,
    color_pallete = color_pallete
  )
  return(params)
}

# maybe add a randomness to the scale and angle for a range of values that make it look good?
