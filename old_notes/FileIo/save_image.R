# Demonstration how to save and load an image
# FAILS

library(testit)
library(png)

create_plot <- function() {
  plot(sin,xlim=c(0,3.14 * 4),main="CreatePlot")
}


save_image_test <- function() {

  filename <- "SaveImage.png"
  
  # Create a plot and save it
  png(filename)
  create_plot()
  dev.off()

  # Load the saved image

  
  # Check that the original and loaded image were identical
}


save_image_test()