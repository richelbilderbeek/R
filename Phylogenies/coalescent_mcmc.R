# Demonstration of ???

coalescent_mcmc <- function() {
  library(coalescentMCMC)
  data(woodmouse)
  class(woodmouse)
  
  system.time(out <- coalescentMCMC(woodmouse)) # circa 12 sec.
  plot(out)
  plot(getMCMCtrees()) # returns 3000 trees
}