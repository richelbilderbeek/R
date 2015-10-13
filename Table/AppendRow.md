
DemonstrateDataFrameWithFactors <- function() {

  distances_m <- c(1600,1970,1800)
  soil_types <- c("Bare_ground","Bare_ground","Bare_ground")
  cover_percentages <- c(100,100,100)
  
  my_table <- data.frame(distances_m,soil_types,cover_percentages)
  rownames(my_table) <- c("Here","There","Somewhere")
  my_table
  
  # Create a new row
  new_row <- c(2000,"Bare_ground",70)
  
  # Append it
  my_new_table <-rbind(new_row,my_table)
  
  # Also add the row name
  rownames(my_new_table)[1] <- "Furthest"
}

# Uncomment this to view the function demonstration
#DemonstrateDataFrameWithFactors()