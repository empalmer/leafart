

#' Rotate leaves grown from the origin
#'
#' Since the timing of this method is slower than randomly placing leaves, it is discouraged to use this function
#'
#' @param leaf A single leaf grown from the origin
#'
#' @return A single leaf that is randomly rotated around the origin
#' @export
#'
rotate_leaf <- function(leaf){
  rot_angle <- sample(-180:180,1)

  leaf <- leaf %>%
    dplyr::mutate(xnew = x * cos(radians(rot_angle)) - y * sin(radians(rot_angle)),
           ynew = x * sin(radians(rot_angle)) + y * cos(radians(rot_angle))) %>%
    dplyr::select(xnew,ynew,leaf_id) %>%
    dplyr::rename(x = xnew, y = ynew)
  return(leaf)
}



#' Randomly place a leaf
#'
#' Since the timing of this method is slower than randomly placing leaves, it is discouraged to use this function
#'
#' @param leaf A single leaf grown from the origin
#'
#' @return A single leaf randomly placed
#' @export
#'
place_leaf <- function(leaf){
  x_loc <- sample(1:50,1)
  y_loc <- sample(1:50,1)

  leaf <- leaf %>%
    mutate(x = x + x_loc,
           y = y + y_loc)
  return(leaf)
}





