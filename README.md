# Using generated trees to create leaf art
## A package by Emily Palmer
### Created for Probability, Computation, and Simulation ST541 final project

This package uses the process of creating randomly generated trees to produce pretty leaf pictures as shown below. Leaves/trees are grown by growing branches in layers, determined by initial parameter inputs.  Zooming out on a plot with many trees looks like a pile of leaves.

![Ginkgo plot](/images/final_ginkgo_plot.png)

### Helpful links 

Report [markdown](/report/report.md) and [pdf](/report/report.pdf)

[Presentation slides](/presentation/presentation_slides.pdf)

[Shiny app to explore how parameters affect tree shape](https://emilypalmer.shinyapps.io/empalmer-project-leafart/)



### How to use this package and examples 

Install using `devtools::install_github(empalmer/leafart)` then `library(leafart)`

This package consists of three main functions. The first gets the parameter values for the leaves. `get_ginkgo_params()` has default parameters to produce plots like the above, and the user specifies the number of leafs wanted. `get_params()` has more general settings, defaulting to one tree so the user can explore how different parameters influence the growth of the tree. `create_leaf_pile()` takes the parameter values as an argument and fully grows the specified trees/leaves and tidies the data. `plot_leaves()` is the function that generates the images using `ggplot2`. It includes an optional palette argument so the user can specify the colors of the leaves. To learn more about these functions, see associated help pages, or read through the code in the R folder.

Here are some examples of the package in use. The first example generates the first image in this README 

```
get_ginkgo_params() %>% 
  create_leaf_pile() %>% 
  plot_leaves()
```

The following will generate one tree, with new branches having random scaled lengths between .3 and 1, and it will be a blue tree.

```
get_params(scale = seq(.3,1,.1)) %>% 
  create_leaf_pile() %>% 
  plot_leaves(pal = "blue")
```

![](/images/blue_tree.png)

We can also change the method of branching, instead growing a new branch from the middle of the branch instead of the endpoint.

```
get_params(split = 5, angle = c(-30,30), scale = c(.4,.5)) %>%
  create_leaf_pile(func = mid_branch) %>% 
  plot_leaves()
```


![](/images/midbranch.png)

The trees are created by making multiple leaves. We build the leaf/tree in layers. Each layer is composed of a set of branches. To grow the leaf/tree, at the end point of each branch in the layer, several new branches are grown from the endpoint, the number is determined by how many 'splits' there are. These grow off the old branch at a randomly selected angle from the parameter inputs, and the length is randomly scaled from the old branch length. 
This process is further explained in the [report.](/report/report.pdf)

### Included in this project

- The R folder contains functions I have coded for this project
- The images folder contains images of plots I have created throughout this project
- The report folder contains a copy of the vignette used as the report for this project
- The topic_exploration folder contains work I've done to understand the existing state of generative art packages in R that might be relevant as well as worked examples of getting this package to work. Note the .Rmd files are not intended to be re-run, more of a insight of my thought process in developing the project. 
- The presentation folder contains the presentation slides for ST541
- The tests folder contains tests for the leafart package
- The shiny app (app.R file) is in the top level due to some publishing troubles


