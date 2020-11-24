
#' Helper function to convert degrees into radians
#'
#' R's cos() and sin() functions take radian parameter values,
#' but personally its easier for me to think in degrees
#'
#'
#' @param degree
#'
#' @return The radian equivalent of the degree parameter
#'
radians <- function(degree) {
  2 * pi * degree / 360
}
