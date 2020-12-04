Timing test
================
Emily Palmer
12/1/2020

# Check which method is faster

``` r
# With default parameters, number of leaves 10, ndistinct 6
bench::mark(
  fewer_distinct = {get_ginkgo_params(init_location = "origin") %>% 
  spread_leaves() },
  more_distinct = {get_ginkgo_params(init_location = "random") %>%
  grow_leaf() %>% 
  rake_leaves()},
  check = FALSE
)
```

    ## Warning: Some expressions had a GC in every iteration; so filtering is disabled.

    ## # A tibble: 2 x 6
    ##   expression          min   median `itr/sec` mem_alloc `gc/sec`
    ##   <bch:expr>     <bch:tm> <bch:tm>     <dbl> <bch:byt>    <dbl>
    ## 1 fewer_distinct    892ms    892ms      1.12     229MB     6.73
    ## 2 more_distinct     102ms    106ms      9.53      36MB     9.53

``` r
bench::mark(
  fewer_distinct = {get_ginkgo_params(init_location = "origin", nleaves = 50, ndistinct = 3) %>% 
  spread_leaves() },
  more_distinct = {get_ginkgo_params(init_location = "random",nleaves = 50) %>%
  grow_leaf() %>% 
  rake_leaves()},
  check = FALSE
)
```

    ## Warning: Some expressions had a GC in every iteration; so filtering is disabled.

    ## # A tibble: 2 x 6
    ##   expression          min   median `itr/sec` mem_alloc `gc/sec`
    ##   <bch:expr>     <bch:tm> <bch:tm>     <dbl> <bch:byt>    <dbl>
    ## 1 fewer_distinct    1.13s    1.13s     0.888     117MB     7.11
    ## 2 more_distinct  100.97ms 105.96ms     9.29       36MB     5.58

We have two methods to create a scatter of leaves. The first, randomly
places the leaves, and has to create more distinct leaves. The second
generates creates fewer distinct trees, and replicates the existing
trees

Even with many leaves, and few distinct leaves, the randomly placing
each new leaf method is much faster.

I would have thought that creating fewer trees and replicating and
moving those leaves would have had a time improvement, but apparently
not.

Still this second method is useful if I ever want to add on to this
project by adding animation for wind, which would need move and rotate
methods to move the leaves.
