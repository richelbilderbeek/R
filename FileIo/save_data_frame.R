#Demonstration how to save a data frame to file

create_data_frame <- function() {
  my_table <- data.frame( row.names = c("Unit","Value"))
  my_table[, "g"] <- c("m/s^2",9.81)
  my_table[, "v"] <- c("m/s",300000)
  return (my_table)
}

library(testit)

save_data_frame_test <- function() {

  filename <- "save_data_frame_test.RDA"
  
  # Create a data fram
  my_data_frame <- create_data_frame()
  
  # Save it to file
  saveRDS(my_data_frame,file=filename)
  
  # Load the saved data frame
  my_data_frame_again <- readRDS(filename)
  
  # Check that the original and loaded data frame were identical
  assert(my_data_frame == my_data_frame_again)
  
  # This will fail:
  #save(my_data_frame,file=filename)
  #my_data_frame_again <- load(filename)
  #assert(my_data_frame == my_data_frame_again)
}

save_data_frame_test()