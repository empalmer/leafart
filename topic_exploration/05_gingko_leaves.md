leaves
================
Emily Palmer
11/13/2020

``` r
param <- list(
    seed = 286,    # seed for the RNG
    time = 6,    # time (iterations) to grow the tree
    scale = c(.8,.9),  # possible values for rescaling at each time
    angle = c(-10,10,20),  # possible values for redirect at each time
    split = 3,  # number of new shoots from each old shoot at each time
    prune = 0  # probability of immediately pruning a new shoot
  )

# Test out some different fall palletes 
pal1 <- c( "#D1CEC5", "#997C67", "#755330", "#B0703C", "#DBA72E", "#E3CCA1")
pal2 <- c("#686724","#CD8E27","#C65729","#993327","#592821","#DBA72E")

forest <- plant_forest_branches(ntrees = 100,param = param)
gingko_plot <- forest %>%
  ggplot(aes(x = coord_x,
             y= coord_y, 
             group= tree_id,
             #size = seg_wid, 
             color = factor(color))) + 
  geom_path() + theme_void() +
  theme(legend.position = "none",
        plot.background = element_rect(fill = "gray74"))


gingko_plot + scale_color_manual(values = pal2) 

filename <- here::here("results",
                       paste0("gingko_plot",lubridate::now(),".png"))
ggsave(filename)
```

![](../images/gingko_plot2020-11-13%2012:35:25.png)
