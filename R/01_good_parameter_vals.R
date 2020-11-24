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
get_gingko_params <- function(location = "random"){
  if(location == "random"){
    x_0 = sample(1:50,1)
    y_0 = sample(1:50,1)
    init_angle = sample(-180:180,1)
  }
  else{
    x_0 = 0
    y_0 = 0
    init_angle = 90
  }

  params <- list(
    seed = 286,
    n_grow_iter = 6,
    scale = c(.8,.9),
    angle = c(-10,10,20),
    split = 3,
    x_0 = x_0,
    y_0 = y_0,
    init_angle = init_angle
  )
  return(params)
}

# maybe add a randomness to the scale and angle for a range of values that make it look good?
