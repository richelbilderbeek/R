library(ggplot2)
library(gridExtra)


DemonstratePlotTwoHistogramsOverEachOtherUsingPlot <- function() {
  # Using plot
  # Adapted from http://stackoverflow.com/questions/3541713/how-to-plot-two-histograms-together-in-r
  set.seed(42)
  series1 <- rnorm(n = 100, mean = 4, sd = 1)
  series2 <- rnorm(n = 100, mean = 6, sd = 1)
  p1 <- hist(series1)
  p2 <- hist(series2)
  
  
  plot( p1, col=rgb(0,0,1,1/4), xlim=c(0,10))
  plot( p2, col=rgb(1,0,0,1/4), xlim=c(0,10), add=T)
  
  png(filename="~/PlotTwoHistogramsOverEachOther1.png")
  plot( p1, col=rgb(0,0,1,1/4), xlim=c(0,10))
  plot( p2, col=rgb(1,0,0,1/4), xlim=c(0,10), add=T)
  dev.off()
}

DemonstratePlotTwoHistogramsOverEachOtherUsingGgplot <- function() {

  set.seed(42)
  series1 <- rnorm(n = 100, mean = 4, sd = 1)
  series2 <- rnorm(n = 100, mean = 6, sd = 1)
  data1 <- data.frame(length = series1)
  data2 <- data.frame(length = series2)
  
  data1$description <- 'series1'
  data2$description <- 'series2'
  
  data <- rbind(data1,data2)
  
  myplot <- ggplot(
    data, 
    aes(length, fill = description)) + geom_histogram(alpha = 0.25,aes(y = ..density..), 
    position = 'identity', 
    binwidth = 0.5
  )
  grid.arrange(myplot)
  ggsave("~/PlotTwoHistogramsOverEachOther2.png")
}

DemonstratePlotTwoHistogramsOverEachOtherUsingPlot()
DemonstratePlotTwoHistogramsOverEachOtherUsingGgplot()
