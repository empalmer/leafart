make_the_leaves_fall <- function(param, nleaves = 3){
  map_dfr(.x = 1:nleaves,
          .f = ~grow_leaf(param = param) %>%
            rake_leaves() %>%
            mutate(leaf_id = .x))
}
