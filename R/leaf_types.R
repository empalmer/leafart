#
# param <- get_params()
#
# init_angle = 90
# (initialize <- tibble::tibble(
#   # Choose a random first location, smaller selection for leafs falling
#   x_0 = 0,
#   y_0 = 0,
#   x_1 = x_0 + cos(radians(init_angle)),
#   y_1 = y_0 + sin(radians(init_angle)),
#   angle = 90, # Random orientation of leaf orientation
#   length = 1,       # initial
#   iter_n = 1L       # time used for
# ))
#
#
# mid_branch <- function(partial_leaf, param, n_grow_iter) {
#   split_loc <- sample(1:10,1)
#   n_shoots <- nrow(partial_leaf)
#   scaled_length <- sample(x = param$scale, size = n_shoots, replace = TRUE)
#   angle_adjust <- sample(x = param$angle, size = n_shoots, replace = TRUE)
#
#   partial_leaf <- partial_leaf %>%
#     dplyr::mutate(
#       x_0 = (x_0 + x_1)/split_loc,
#       y_0 = (y_0 + y_1)/split_loc,
#       length = length * scaled_length,
#       angle = angle + angle_adjust,
#       iter_n = iter_n + 1L,
#       x_1 = x_0 + length * cos(radians(angle)) ,
#       y_1 = y_0 + length * sin(radians(angle)),
#     )
#
#   return(partial_leaf)
# }
#
# stem_branches <- function(partial_leaf, param,n_grow_iter){
#   purrr::map_dfr(.x = 1:param$split,
#       .f = mid_branch,
#       partial_leaf = partial_leaf,
#       param = param)
# }
#
# (multiple_stems <- stem_branches(initialize, param))
#
#
# (full_leaf <- purrr::accumulate(
#   .x = 1:2,
#   .f = stem_branches,
#   .init = initialize,
#   param = param
# ))
#
#
#
# (raked <- rake_leaves(full_leaf))
# plot_leaves(raked)
#
# plot_leaves(rake_leaves(multiple_stems))
