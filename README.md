# Using generated trees to create leaf art
## A package by Emily Palmer

This package uses the process of creating randomly generated trees to produce pretty leaf pictures as shown below. Leaves/trees are grown by growing branches in layers, determined by initial parameter inputs.  Zooming out on a plot with many trees looks like a pile of leaves.

![Ginkgo plot](/images/final_ginkgo_plot.png)

### Helpful links 

Report [markdown](/report/report.md) and [pdf](/report/report.pdf)
Charlotte: I ended up including both a pdf report as well as a vignette. The only way I was able to have a viewable version on GitHub was to use `devtools::build_vignettes`, which creates a doc file with the knitted files. However, each time I ran this or knitted the vignette, all of the knitted files were moved to the .gitignore and I had to manually remove them every time if I wanted the document to appear. I didn't want to have to edit the .gitignore every time I checked if my report would knit, so I left the report folder to serve as my report for this project. Also the links in the preview of the pdf report did not seem to work, so I also included a .md version.


[Presentation slides](/presentation/presentation_slides.pdf)

[Shiny app to explore how parameters affect tree shape](https://emilypalmer.shinyapps.io/empalmer-project-leafart/)



### How to use this package and examples 

Since this package is currently hosted in a private repo, it is difficult to use the standard `devtools::install_github()` and `library()` call. Instead clone/download this repo, and load in the packages using `devtools::load_all()`. 

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

![example image](/images/blue_tree.png)

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


