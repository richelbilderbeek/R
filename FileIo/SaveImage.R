#rm(list = ls())
library(testit)
library(png)

CreatePlot <- function() {
  plot(sin,xlim=c(0,3.14 * 4),main="CreatePlot")
}


DemonstrateSaveImage <- function() {

  filename <- "SaveImage.png"
  
  # Create a plot and save it
  png(filename)
  CreatePlot()
  dev.off()

  # Load the saved image

  
  # Check that the original and loaded image were identical
}


# Uncomment this to view the function demonstration
DemonstrateSaveImage()