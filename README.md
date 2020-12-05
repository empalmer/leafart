# Fall leaf art based on genearted trees

This package uses the process of creating generated trees in order to produce pretty leaf pictures. Note the tidyverse must be installed to use this package. 

![Ginkgo plot](/images/default_ginkgo_plot.png)

### Helpful links 

[Presentation slides](/presentation/presentation_slides.html)

[Shiny app](https://emilypalmer.shinyapps.io/empalmer-project-leafart/)

[Project report as a vignette](/doc/project-report-vignette.pdf)

### How the plots are created 

The plots are created by making multiple leaves, or trees (Trees look like leaves when we are zoomed out). We build the leaf/tree in layers, earlier layers are smaller. Each layer is composed of a set of branches. To grow the leaf/tree, at the end point of each branch in the layer, several new branches are grown from the endpoint, the number is determined by how many 'splits' there are. These grow off the old branch at a randomly selected angle from the parameter inputs, and the length is randomly scaled from the old branch length. 

![explanation](/images/leaf_explanation.png)

Each new branch is grown with the `one_branch()` function. The `grow_leaf_layers()` function grows one layer, by iterating over all the endpoints of the previous layer, calling `one_branch()` function on each endpoint. The `grow_leaf()` function maps the `grow_leaf_layers()` function to grow 

### Example code 

The following code will create an image similar to above 

```
get_ginkgo_params() %>% 
  create_leaf_pile() %>% 
  plot_leaves()
```

### Shiny app

The shiny app can be accessed here: and allows the user to examine how different parameter values change the 

### Included in this project

- The R folder contains functions I have coded for this project
- The images folder contains images of plots I have created throughout this project
- The shiny app is in the top level due to some publishing troubles, so the app.R file and the rsconnect file are a result of that. 
- The topic_exploration folder contains work I've done to understand the existing state of generative art packages in R that might be relevant. Note the .Rmd files are not intended to be re-run, more of a insight of my thought process in developing the project. 

