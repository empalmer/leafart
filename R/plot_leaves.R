
plot_leaves <- function(leaves,
                        pal = c( "#D1CEC5", "#997C67", "#755330",
                                 "#B0703C", "#DBA72E", "#E3CCA1")){


  p <- ggplot(leaves,aes(x = x,y= y,
                         #group= leaf_id,
                         color = factor(color))) +
    geom_path() +
    theme_void() +
    theme(legend.position = "none",
          plot.background = element_rect(fill = "gray74")) +
    scale_color_manual(values = pal)
  return(p)

}
