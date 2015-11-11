rm(list = ls())
library(testit)

CreatePlot <- function() {
  plot(sin,xlim=c(0,3.14 * 4),main="CreatePlot")
}

DemonstrateSavePlot <- function() {
  # DOES NOT WORK
  print("Warning: cannot save plots! This code will fail. Use code of SaveImage instead")
  
  # From http://r.789695.n4.nabble.com/failure-to-replayPlot-a-recordedplot-object-saved-in-a-previous-session-td4676014.html
  # Reply by Paul Murrell-2 at Sep 25, 2013; 2:35am:
  #
  # Attempting to use a display list snapshot (as created by recordPlot())
  # between R sessions has always been strongly discouraged, but as of about
  # R 3.0.0 it has become impossible (due to internal changes, which was
  # part of the reason for strongly discouraging this in the first place). 
  
  filename <- "SavePlot.Rda"
  
  # Create a plot
  CreatePlot()
  
  # Save it to file
  my_list <- list(recordPlot())
  names(my_list) <- c("the_plot")
  saveRDS(my_list,file=filename)

  # Load the saved list
  my_list_again <- readRDS(filename)
  # Check that the original and loaded data frame were identical
  assert(length(my_list) == length(my_list_again))
  assert(length(my_list$the_plot) == length(my_list_again$the_plot))
  assert(names(my_list) == names(my_list_again))

  replayPlot(my_list$the_plot) # Works as expected
  
  print("Here comes the error: 'Error: NULL value passed as symbol address':")
  replayPlot(my_list_again$the_plot) # Error: NULL value passed as symbol address
}

# Uncomment this to view the function demonstration
#DemonstrateSavePlot()