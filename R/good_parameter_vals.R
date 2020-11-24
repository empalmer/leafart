#' Get default parameters for making gingko leaves
#'
#' @return A list of parameter values that make the leaves look like gingko
#' leaves.
#'
#'
#' @export
#'
#' @examples
get_gingko_params <- function(){
  params <- list(
    seed = 286,    # seed for the RNG
    time = 6,    # time (iterations) to grow the tree
    scale = c(.8,.9),  # possible values for rescaling at each time
    angle = c(-10,10,20),  # possible values for redirect at each time
    split = 3,  # number of new shoots from each old shoot at each time
    prune = 0  # probability of immediately pruning a new shoot
  )
  return(params)
}

# maybe add a randomness to the scale and angle for a range of values that make it look good?
