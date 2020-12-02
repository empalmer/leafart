
#' Plot leaves
#'
#' Plots leaves using ggplot2, with `geom_path()` connecting each of the growth steps in order to grow leaf/tree objects
#'
#' @param leaves A list containing
#' @param pal A color palette for the leaves
#'
#' @return A ggplot object
#' @export
#'

plot_leaves <- function(leaves, pal = c( "#997C67", "#755330","#B0703C",
                                         "#DBA72E", "#E3CCA1","#D1CEC5")){
  # Add a color variable
  leaves <- leaves %>%
    group_by(leaf_id) %>%
    mutate(color = sample(1:length(pal),1))

  # Are we plotting multiple leaves?
  n_colors <- length(unique(leaves$color))
  if("leaf_id" %in% colnames(leaves) & n_colors > 1){
    p <- ggplot(leaves,aes(x = x,y= y,
                           group= leaf_id,
                           color = factor(color))) +
      geom_path() +
      theme_void() +
      theme(legend.position = "none",
            plot.background = element_rect(fill = "gray74")) +
      scale_color_manual(values = pal)
  }
  # Plot only one leaf (no color)
  else{
    p <- ggplot(leaves,aes(x = x, y= y)) +
      geom_path() +
      theme_void() +
      theme(legend.position = "none",
            plot.background = element_rect(fill = "gray74"))
  }
  return(p)
}
