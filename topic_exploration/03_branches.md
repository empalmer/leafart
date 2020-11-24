branches
================
Emily Palmer
11/11/2020

## Test the branches

Added functions grow\_layer and grow\_tree - these should add branches
to the stalks or “saplings” from last week

``` r
param <- list(
    seed = 286,    # seed for the RNG
    time = 6,    # time (iterations) to grow the tree
    scale = c(.8,.9),  # possible values for rescaling at each time
    angle = c(-10,10,-20),  # possible values for redirect at each time
    split = 3,  # number of new shoots from each old shoot at each time
    prune = 0  # probability of immediately pruning a new shoot
  )
# one tree
stalk() %>% 
  grow_tree(. , param = param) %>% 
  arborist_call() %>%
  ggplot(aes(x = coord_x,
             y= coord_y, 
             group= id_path),
         color = "green")+
             #size = seg_wid, 
             #color = seg_col) + 
  geom_path(color = "green") + 
  #xlim(c(0,100)) + ylim(c(0,100)) + 
  theme_void() + theme(legend.position = "none")
```

![](branches_files/figure-gfm/unnamed-chunk-1-1.png)<!-- -->

``` r
# multiple trees 
plant_forest_branches(ntrees = 10,param = param) %>%
  ggplot(aes(x = coord_x,
             y= coord_y, 
             group= tree_id))+
             #size = seg_wid, 
             #color = seg_col) + 
  geom_path(color = "forestgreen") + 
  #xlim(c(0,100)) + ylim(c(0,100)) + 
  theme_void() + theme(legend.position = "none")
```

![](branches_files/figure-gfm/unnamed-chunk-1-2.png)<!-- -->