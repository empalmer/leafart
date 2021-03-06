Different parameter values
================
Emily Palmer
12/1/2020

## Parameters that work for ginkgo leaves

``` r
get_ginkgo_params(nleaves = 150) %>% 
  create_leaf_pile() %>% 
  plot_leaves()
```

![](08_Exploring_Parameters_files/figure-gfm/unnamed-chunk-1-1.png)<!-- -->

``` r
filename <- here::here("images","ginkgo_plot_colors.png")
ggsave(filename)
```

    ## Saving 7 x 5 in image

## Change n\_grow\_iter

The number of “layers” the leaf has

``` r
list(nleaves = 1,
    ndistinct = 1,
    seed = 286,
    n_grow_iter = 1,
    scale = c(.8,.9),
    angle = c(-10,10,20),
    split = 3,
    init_location = "random") %>% 
  create_leaf_pile() %>% 
  plot_leaves()
```

![](08_Exploring_Parameters_files/figure-gfm/unnamed-chunk-2-1.png)<!-- -->

``` r
filename <- here::here("images","n_grow_iter_1.png")
ggsave(filename)
```

    ## Saving 7 x 5 in image

``` r
list(nleaves = 1,
    ndistinct = 1,
    seed = 286,
    n_grow_iter = 12,
    scale = c(.8,.9),
    angle = c(-10,10,20),
    split = 3,
    init_location = "random") %>% 
  create_leaf_pile() %>% 
  plot_leaves()
```

![](08_Exploring_Parameters_files/figure-gfm/unnamed-chunk-2-2.png)<!-- -->

``` r
filename <- here::here("images","n_grow_iter_12.png")
ggsave(filename)
```

    ## Saving 7 x 5 in image

## Change the scale

The scale is responsible for the length of each successive branch after
splitting.

Values close to 1 seem to create the most realistic looking trees

Varried

``` r
list(nleaves = 1,
    ndistinct = 1,
    seed = 286,
    n_grow_iter = 6,
    scale = c(.4,.5),
    angle = c(-10,10,20),
    split = 3,
    init_location = "random") %>% 
  create_leaf_pile() %>% 
  plot_leaves()
```

![](08_Exploring_Parameters_files/figure-gfm/unnamed-chunk-3-1.png)<!-- -->

``` r
filename <- here::here("images","scale_low.png")
ggsave(filename)
```

    ## Saving 7 x 5 in image

``` r
list(nleaves = 1,
    ndistinct = 1,
    seed = 286,
    n_grow_iter = 6,
    scale = c(3,4),
    angle = c(-10,10,20),
    split = 3,
    init_location = "random") %>% 
  create_leaf_pile() %>% 
  plot_leaves()
```

![](08_Exploring_Parameters_files/figure-gfm/unnamed-chunk-3-2.png)<!-- -->

``` r
filename <- here::here("images","scale_high.png")
ggsave(filename)
```

    ## Saving 7 x 5 in image

## Splits - Doesnt change much

``` r
list(nleaves = 1,
    ndistinct = 1,
    seed = 286,
    n_grow_iter = 6,
    scale = c(.8,.9),
    angle = c(-10,10,20),
    split = 5,
    init_location = "random") %>% 
  create_leaf_pile() %>% 
  plot_leaves()
```

![](08_Exploring_Parameters_files/figure-gfm/unnamed-chunk-4-1.png)<!-- -->

``` r
filename <- here::here("images","high_split.png")
ggsave(filename)
```

    ## Saving 7 x 5 in image

## Angle

``` r
list(nleaves = 1,
    ndistinct = 1,
    seed = 286,
    n_grow_iter = 6,
    scale = c(.8,.9),
    angle = c(-90,0),
    split = 3,
    init_location = "random") %>% 
  create_leaf_pile() %>% 
  plot_leaves()
```

![](08_Exploring_Parameters_files/figure-gfm/unnamed-chunk-5-1.png)<!-- -->

``` r
filename <- here::here("images","extreme_unbalanced_angle.png")
ggsave(filename)
```

    ## Saving 7 x 5 in image

``` r
list(nleaves = 1,
    ndistinct = 1,
    seed = 286,
    n_grow_iter = 6,
    scale = c(.8,.9),
    angle = seq(-50,10,1),
    split = 3,
    init_location = "random") %>% 
  create_leaf_pile() %>% 
  plot_leaves()
```

![](08_Exploring_Parameters_files/figure-gfm/unnamed-chunk-5-2.png)<!-- -->

``` r
filename <- here::here("images","unbalanced_angle.png")
ggsave(filename)
```

    ## Saving 7 x 5 in image

``` r
list(nleaves = 1,
    ndistinct = 1,
    seed = 286,
    n_grow_iter = 6,
    scale = c(.8,.9),
    angle = seq(-60,60,1),
    split = 3,
    init_location = "random") %>% 
  create_leaf_pile() %>% 
  plot_leaves()
```

![](08_Exploring_Parameters_files/figure-gfm/unnamed-chunk-5-3.png)<!-- -->

``` r
filename <- here::here("images","unbalanced_angle.png")
ggsave(filename)
```

    ## Saving 7 x 5 in image
