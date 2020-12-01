create_leaf_pile <- function(param){
  nleaves <- param$nleaves
  map_dfr(.x = 1:nleaves,
          .f = ~grow_leaf(param = param) %>%
            rake_leaves() %>%
            mutate(leaf_id = .x))
}


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


  # to ensure that there are at least ndistinct leaves:
  #repeated_leaves <- sample(distinct_leaves, size = nleaves - ndistinct, replace = T)
  #all_leaves <- c(distinct_leaves, repeatd_leaves)


  # Change the id on the leafs, each leaf should have its own id
  #re_id_leaves <- map(1:nleaves, ~ (mutate(sampled_leaves[[.x]],leaf_id  = .x)))

  return(leaf_pile)
}


