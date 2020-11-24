
origin_leaf_pile <- function(n_leaf, n_distinct){

}

initial_angle <- function(leaf){
  rot_angle <- sample(-180:180,1)

  leaf <- leaf %>%
    mutate(xnew = x * cos(radian(rot_angle)) - y * sin(radian(rot_angle)),
           ynew = x * sin(radian(rot_angle)) + y * cos(radian(rot_angle))) %>%
    select()
  dplyr::rename(coord_x = x, coord_y = y) %>%
    dplyr::select(
      coord_x, coord_y, seg_deg, seg_len, seg_col, seg_wid,
      iter_n, id_path, id_step
    )


}

initial_location <- function(leaf){
  x_loc <- sample(1:50,1)
  y_loc <- sample(1:50,1)

  leaf <- leaf %>%
    mutate(x = x + x_loc,
           y = y + y_loc)
  return(leaf)
}




leaf_location <- function(leaf,x_diff,y_diff){

}



