

# Rotate around the origin (before leafs are moved )
rotate_leaf <- function(leaf){
  rot_angle <- sample(-180:180,1)

  leaf <- leaf %>%
    mutate(xnew = x * cos(radians(rot_angle)) - y * sin(radians(rot_angle)),
           ynew = x * sin(radians(rot_angle)) + y * cos(radians(rot_angle))) %>%
    select(xnew,ynew,color,leaf_id) %>%
    rename(x = xnew, y = ynew)

    #dplyr::rename(x = xnew, coord_y = y) %>%
    #dplyr::select(
    #  coord_x, coord_y, seg_deg, seg_len, seg_col, seg_wid,
    #  iter_n, id_path, id_step
    #)
  return(leaf)
}

place_leaf <- function(leaf){
  x_loc <- sample(1:50,1)
  y_loc <- sample(1:50,1)

  leaf <- leaf %>%
    mutate(x = x + x_loc,
           y = y + y_loc)
  return(leaf)
}





