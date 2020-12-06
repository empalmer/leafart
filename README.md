# Fall leaf art based on genearted trees
## A package by Emily Palmer

This package uses the process of creating randomly generated trees to produce pretty leaf pictures. 

![Ginkgo plot](/images/default_ginkgo_plot.png)

### Helpful links 

[Report](/report/report.pdf)

[Presentation slides](/presentation/presentation_slides.pdf)

[Shiny app](https://emilypalmer.shinyapps.io/empalmer-project-leafart/)


### How to use this package and examples 

This package consists of three main functions. The first gets the parameter values for the plot. `get_ginkgo_params()` has default parameters to produce plots like the above, and the user specifies the number of leafs wanted. `get_params()` has more general settings, defaulting to one tree so the user can explore how different parameters influence the 

```
get_ginkgo_params(n) %>% 
  create_leaf_pile() %>% 
  plot_leaves()
```


The plots are created by making multiple leaves, or trees (Trees look like leaves when we are zoomed out). We build the leaf/tree in layers, earlier layers are smaller. Each layer is composed of a set of branches. To grow the leaf/tree, at the end point of each branch in the layer, several new branches are grown from the endpoint, the number is determined by how many 'splits' there are. These grow off the old branch at a randomly selected angle from the parameter inputs, and the length is randomly scaled from the old branch length. 
To understand the process of how these leaves/trees are created, see the (report)

### Included in this project

- The R folder contains functions I have coded for this project
- The images folder contains images of plots I have created throughout this project
- The shiny app is in the top level due to some publishing troubles, so the app.R file is a result of that. 
- The topic_exploration folder contains work I've done to understand the existing state of generative art packages in R that might be relevant. Note the .Rmd files are not intended to be re-run, more of a insight of my thought process in developing the project. 
- The doc folder contains the knitted results of the vignette use as the report for this project

