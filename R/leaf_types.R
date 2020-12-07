#' Split in the middle of a branch
#'
#' Counterpoint to `one_branch` which splits in the middle of the branch instead of the end
#'
#' @param partial_leaf The leaf in progress of being grown
#' @param param The parameters specifying how to grow the leaf
#' @param n_layer Keeps track of the growth
#'
#'
#' @return A one row tibble that represents the new branch
#'
#' @return
#' @export
#'
#'
mid_branch <- function(partial_leaf, param, n_layer) {
  # where to branch
  split_loc <- sample(seq(.3,1,.1),1)
  n_shoots <- nrow(partial_leaf)
  scaled_length <- sample(x = param$scale, size = n_shoots, replace = TRUE)
  angle_adjust <- sample(x = param$angle, size = n_shoots, replace = TRUE)

  partial_leaf <- partial_leaf %>%
    dplyr::mutate(
      x_0 = (1 - split_loc)*x_0 + split_loc * x_1,
      y_0 = (1 - split_loc)*y_0 + split_loc * y_1,
      length = length * scaled_length,
      angle = angle + angle_adjust,
      iter_n = iter_n + 1L,
      x_1 = x_0 + length * cos(radians(angle)) ,
      y_1 = y_0 + length * sin(radians(angle)),
    )
  return(partial_leaf)
}




