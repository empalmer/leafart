

#' Rake leaves - Convert leaf to tidy data format
#'
#' The data format needed to grow the leaf using purrr's accumulate is not conducive to plotting the leaves, this function cleans up the data so it is more easily plotted
#'
#' @param leaf The data frame that stores the generated leaf
#'
#' @return A data frame representation that is easier to be passed to ggplot to plot, with an x and y column
#' @export
#'
rake_leaves <- function(leaf) {
  leaf <- leaf %>%
    dplyr::bind_rows() %>%
    dplyr::mutate(id_path = as.integer(1:dplyr::n())) %>%
    tidyr::pivot_longer(
      cols = x_0:y_1,
      names_to = "id_step",
      values_to = "coord"
    ) %>%
    tidyr::separate(col = id_step, into = c("axis", "id_step")) %>%
    tidyr::pivot_wider(names_from = axis, values_from = coord) %>%
    dplyr::select(x,y)
  return(leaf)
}




