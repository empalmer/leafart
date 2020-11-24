Examples
================
Emily Palmer
10/29/2020

## Flametrees

I won’t include output for this because it takes so long to run.

``` r
#devtools::install_github("djnavarro/flametree")
library(flametree)
```

### Example directly from github:

``` r
dat <- flametree_grow(seed = 4, time = 13) # data structure
img <- flametree_plot(tree = dat)          # ggplot object
plot(img)
# I just want to read a book under this tree
```

### Looking into those two functions:

``` r
?flametree_grow()
# See how different values change the trees (I'm not including all the ones i've tried)
dat <- flametree_grow(time = 10, scale = c(.5,.6),split = 3, prune = .2)
flametree_plot(tree = dat)
```

Arguments:

  - seed - Integer-valued seed for the random number generator
  - time - Number of generations to run the iterative process
  - scale - Vector of possible values for the “size rescaling” at each
    iteration
  - angle - Vector of possible angle changes (in degrees) at each
    iteration
  - split - Maximum number of shoots to generate from each tip at each
    iteration
  - prune - Probability with which a generated shoot is pruned

Outputs: A tibble with the following columns: coord\_x, coord\_y,
seg\_deg, seg\_len, seg\_col, seg\_wid, id\_time, id\_path, id\_step,
id\_leaf

### Dig into code

4 files: exports.R, helpers.R, workers.R, zzz.R.

`flametree_grow` and in exports.R

It calls `grow_sampling()` which pipes into `grow_tree()` which pipes
into `shape_tree()`

Includes a “leaf indicator”

`grow_sampling()` is in the workers.R file. It initializes a sapling
(tibble) at initial values.

`grow_tree()` uses the initial sapling using `purrr::accumulate()` (look
into this) which calls `grow_layer`

`grow_layer()` continues to make new shoots (based of parameter values)
and calls `grow_shoots`

`grow_shoots()` Seems to be where a lot of the randomization for growing
goes on.

Finally shape tree converts the tree result into an easier data format
for plotting.

`flametree_plot` uses ggforce: `geom_bezier2()` - I haven’t seen this
before.

## generative art

Load package

``` r
#devtools::install_github("cutterkom/generativeart")
library(generativeart)
```

    ## Loading required package: magrittr

    ## 
    ## Attaching package: 'magrittr'

    ## The following object is masked from 'package:purrr':
    ## 
    ##     set_names

    ## The following object is masked from 'package:tidyr':
    ## 
    ##     extract

## Things to continue to look into:

Fractal landscapes <https://en.wikipedia.org/wiki/Fractal_landscape>

<https://fronkonstin.com/tag/fractals/>

rayshader

Make a fractal landscape into raster data, load with rayshader?

ggforce

## Thoughts

How realistic will this look? A lot of examples I have seen look more
abstract.

## Citations

Danielle Navarro (2020). flametree: Generate random tree-like images. R
package version 0.0.0.9000. <https://github.com/djnavarro/flametree>

Thomas Lin Pedersen (2020). ggforce: Accelerating ‘ggplot2’. R package
version 0.3.2. <https://CRAN.R-project.org/package=ggforce>

Katharina Brunner (2020). generativeart: Create Generative Art with R. R
package version 1.0.
