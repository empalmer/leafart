## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup--------------------------------------------------------------------
#devtools::install()
library(tibble)
library(leafart) 
# To actually show the knitted vignette document, I had to use devtools::build_vignettes() and then remove the doc file from the .gitignore. 

## -----------------------------------------------------------------------------
get_params(nleaves = 1,
           split = 3,
           angle = c(-150,0,0,150),
           scale = c(.8,.9),
           n_layer = 5) %>% 
  create_leaf_pile() %>% 
  plot_leaves()


## -----------------------------------------------------------------------------
(initial_leaf <- tibble::tibble(
    x_0 = 0,
    y_0 = 0,
    x_1 = 0,
    y_1 = 1
  ))

## -----------------------------------------------------------------------------
(rake_leaves(initial_leaf))

rake_leaves(initial_leaf) %>% 
  plot_leaves()

## -----------------------------------------------------------------------------
params <- get_params(n_layer = 1,
                     scale = .5,
                     angle = 90,
                     split = 2)

## -----------------------------------------------------------------------------
initial_leaf <- tibble::tibble(
    x_0 = 0,
    y_0 = 0,
    x_1 = x_0,
    y_1 = y_0 + 1,
    angle = 90,
    length = 1L,
    iter_n = 1L
  )

one_branch(initial_leaf, params)


## -----------------------------------------------------------------------------
grow_leaf_layers(initial_leaf,params)

## -----------------------------------------------------------------------------
small_leaf <- get_params(n_layer = 1,
                     scale = .5,
                     angle = 90,
                     split = 2) %>% 
  grow_leaf()



## -----------------------------------------------------------------------------
get_params(n_layer = 1,
                     scale = .5,
                     angle = 90,
                     split = 2) %>% 
  grow_leaf() %>% 
  rake_leaves()


get_params(nleaves = 1,
           n_layer = 2,
           scale = .5,
           angle = 90,
           split = 2) %>% 
  grow_leaf() %>% 
  rake_leaves() %>% 
  plot_leaves()

