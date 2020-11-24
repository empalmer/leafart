make_the_leaves_fall <- function(nleaves = 3, param){
  map_dfr(.x = 1:nleaves,
          .f = ~grow_leaf(leaf_stalk(), param = param) %>%
            rake_neatly() %>%
            mutate(leaf_id = .x))
}
