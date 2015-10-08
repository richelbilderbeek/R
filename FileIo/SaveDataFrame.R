library(testit)

CreateDataFrame <- function() {
  my_table <- data.frame( row.names = c("Unit","Value"))
  my_table[, "g"] <- c("m/s^2",9.81)
  my_table[, "v"] <- c("m/s",300000)
  return (my_table)
}

DemonstrateSaveDataFrame <- function() {

  filename <- "SaveDataFrame.Rda"
  
  # Create a data fram
  my_data_frame <- CreateDataFrame()
  
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

DemonstrateSaveDataFrame()