Timing test
================
Emily Palmer
12/1/2020

# Check which method is faster

``` r
# With default parameters, number of leaves 10, ndistinct 6
bench::mark(
  fewer_distinct = {get_ginkgo_params() %>% 
  spread_leaves() },
  more_distinct = {get_ginkgo_params() %>%
  grow_leaf() %>% 
  rake_leaves()},
  check = FALSE
)
```

    ## Warning: Some expressions had a GC in every iteration; so filtering is disabled.

    ## # A tibble: 2 x 6
    ##   expression          min   median `itr/sec` mem_alloc `gc/sec`
    ##   <bch:expr>     <bch:tm> <bch:tm>     <dbl> <bch:byt>    <dbl>
    ## 1 fewer_distinct    638ms    638ms      1.57     121MB     20.4
    ## 2 more_distinct     106ms    124ms      6.79      36MB     15.3

``` r
bench::mark(
  fewer_distinct = {get_ginkgo_params(nleaves = 50) %>% 
  spread_leaves(ndistinct = 3) },
  more_distinct = {get_ginkgo_params(nleaves = 50) %>%
  grow_leaf() %>% 
  rake_leaves()},
  check = FALSE
)
```

    ## Warning: Some expressions had a GC in every iteration; so filtering is disabled.

    ## # A tibble: 2 x 6
    ##   expression          min   median `itr/sec` mem_alloc `gc/sec`
    ##   <bch:expr>     <bch:tm> <bch:tm>     <dbl> <bch:byt>    <dbl>
    ## 1 fewer_distinct    1.05s    1.05s     0.950     117MB    13.3 
    ## 2 more_distinct  110.51ms 115.34ms     7.36       36MB     9.20

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
