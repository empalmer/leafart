#' Create a pile of leaves
#'
#' @param param A list of parameters specifying how to grow the leaf and how many leaves to grow
#'
#' @return A data frame containing an x, y, and leaf_id column
#' @export
#'
#' @examples
#' get_ginkgo_params() %>% create_leaf_pile()
#'
create_leaf_pile <- function(param){
  nleaves <- param$nleaves
  map_dfr(.x = 1:nleaves,
          .f = ~grow_leaf(param = param) %>%
            rake_leaves() %>%
            mutate(leaf_id = .x))
}






#' A different (slower) method for creating a pile of leaves
#'
#' This method was intended to spead up the process of generating trees. This method creates a smaller number of distinct trees (since they look similar in the end), and then randomly replicates those trees, and then randomly rotates and places them. It ends up being slower in the end
#'
#' @param param A list of parameters specifying how to grow the leaf and how many leaves to grow
#'
#' @return A data frame containing an x, y, and leaf_id column
#' @export
#'
spread_leaves <- function(param){
  nleaves <- param$nleaves
  ndistinct <- param$ndistinct
  leaf_pile <- map(.x = 1:ndistinct,
                         .f = ~grow_leaf(param = param) %>%
                           rake_leaves() %>%
                           mutate(leaf_id = .x)) %>%
    sample(nleaves, replace = T) %>%
    map2(1:nleaves, ~ (mutate(.x,leaf_id  = .y))) %>%
    map(rotate_leaf) %>%
    map_df(place_leaf)

  return(leaf_pile)
}


