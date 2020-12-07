#' Create a pile of leaves
#'
#' @param param A list of parameters specifying how to grow the leaf and how many leaves to grow
#' @param func The function to either branch at midpoint or endpoint
#'
#' @return A data frame containing an x, y, and leaf_id column
#' @export
#'
#' @examples
#' get_ginkgo_params() %>% create_leaf_pile()
#'
create_leaf_pile <- function(param, func = one_branch){
  n_leaves <- param$n_leaves
  purrr::map_dfr(.x = 1:n_leaves,
          .f = ~grow_leaf(param = param, func = func) %>%
            rake_leaves() %>%
            dplyr::mutate(leaf_id = .x))
}






#' A different (slower) method for creating a pile of leaves
#'
#' This method was intended to spead up the process of generating trees. This method creates a smaller number of distinct trees (since they look similar in the end), and then randomly replicates those trees, and then randomly rotates and places them. It ends up being slower in the end
#'
#' @param param A list of parameters specifying how to grow the leaf and how many leaves to grow
#' @param ndistinct The number of distinct trees to create
#'
#' @return A data frame containing an x, y, and leaf_id column
#' @export
#'
spread_leaves <- function(param, ndistinct = 3){
  n_leaves <- param$n_leaves
  leaf_pile <- purrr::map(.x = 1:ndistinct,
                         .f = ~grow_leaf(param = param,
                                         init_location  = "origin") %>%
                           rake_leaves() %>%
                           mutate(leaf_id = .x)) %>%
    sample(n_leaves, replace = T) %>%
    purrr::map2(1:n_leaves, ~ (mutate(.x,leaf_id  = .y))) %>%
    purrr::map(rotate_leaf) %>%
    purrr::map_df(place_leaf)

  return(leaf_pile)
}


