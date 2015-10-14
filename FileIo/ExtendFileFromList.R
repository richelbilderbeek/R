# Setup:
# * Create file with parameters
# * Close the file
# * Open the file, check parameters are present and add results
# * Close the file
# * Open the file, check parameters and results are present and do nothing

library(testit)

CreateParametersDataFrame <- function() {
  my_table <- data.frame( row.names = c("Unit","Value"))
  my_table[, "g"] <- c("m/s^2",9.81)
  my_table[, "v"] <- c("m/s",300000)
  return (my_table)
}

CreateResultsDataFrame <- function() {
  my_table <- data.frame( row.names = c("Description","Value"))
  my_table[, "mean_v"] <- c("Average speed (m/s)",1.1)
  my_table[, "stddev_v"] <- c("Standard deviation is speed (m/s)",2.2)
  my_table[, "mean_x"] <- c("Average distance from start (m)",3.3)
  return (my_table)
}

CreateInitialList <- function() {
  my_list <- list(
    CreateParametersDataFrame()
  )
  names(my_list) <- c("parameters")
  assert(my_list$parameters == CreateParametersDataFrame())
  return (my_list)
}


DemonstrateSaveList <- function() {

  filename <- "SaveList.Rda"
  
  # Create a list
  my_list <- CreateInitialList()
  assert(my_list$parameters == my_list$parameters)
  assert(is.null(my_list$results))
  
  # Save it to file
  saveRDS(my_list,file=filename)
  
  # Load the saved list
  my_list_again <- readRDS(filename)
  assert(my_list_again$parameters == my_list_again$parameters)
  
  # Check that the original and loaded data frame were identical
  assert(length(my_list) == length(my_list_again))
  assert(my_list$parameters == my_list_again$parameters)
  
  # Add results. Note: append using 'c' instead of 'list'
  my_list <- c(my_list,CreateResultsDataFrame()) 
  names(my_list) <- c("parameters","results")
  assert(my_list$parameters == my_list$parameters)
  assert(my_list$parameters == my_list$parameters)

  # Save it to file
  saveRDS(my_list,file=filename)
  
  # Load the saved list
  my_list_again <- readRDS(filename)
  
  # Check that the original and loaded data frame were identical
  assert(length(my_list) == length(my_list_again))
  assert(my_list$parameters == my_list_again$parameters)
  assert(my_list$results == my_list_again$results)

  # This will fail:
  #save(my_list,file=filename)
  #my_list_again <- load(filename)
  #assert(length(my_list) == length(my_list_again))
  #assert(my_list$parameters == my_list_again$parameters)
  #assert(my_list$results == my_list_again$results)
}

# Uncomment this to view the function demonstration
#DemonstrateSaveList()
