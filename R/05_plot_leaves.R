
#' Plot leaves
#'
#' Plots leaves using ggplot2, with `geom_path()` connecting each of the growth steps in order to grow leaf/tree objects
#'
#' Another good palette is c("#686724","#CD8E27","#C65729","#993327","#592821","#DBA72E")
#'
#' c( "#997C67", "#755330","#B0703C", "#DBA72E", "#E3CCA1","#D1CEC5")
#'
#' @param leaves A list containing
#' @param pal A color palette for the leaves
#'
#' @return A ggplot object
#' @export
#'
#'

# remove #686724
plot_leaves <- function(leaves,
                        connect = FALSE,
                        pal = c("#CD8E27","#C65729","#993327","#592821","#DBA72E","#D28F33")){
  # Are we plotting multiple leaves?
  #n_colors <- length(unique(leaves$color))
  #if("leaf_id" %in% colnames(leaves) & n_colors > 1){
  if("leaf_id" %in% colnames(leaves)){
    # Add a color variable
    leaves <- leaves %>%
      dplyr::group_by(leaf_id) %>%
      dplyr::mutate(color = sample(1:length(pal),1)) %>%
      tidyr::unite("path_group",c("leaf_id","step"))
    p <- ggplot(leaves,aes(x = x,y= y,
                           #group= leaf_id,
                           group = path_group,
                           color = factor(color))) +
      geom_path(size = 1.1) +
      theme_void() +
      theme(legend.position = "none",
            plot.background = element_rect(fill = "gray74")) +
      scale_color_manual(values = pal)
  }
  # Plot only one leaf (no color)
  else{
    p <- ggplot(leaves,aes(x = x, y= y, group = step)) +
      geom_path() +
      theme_void() +
      theme(legend.position = "none",
            plot.background = element_rect(fill = "gray74"))
  }
  return(p)
}
