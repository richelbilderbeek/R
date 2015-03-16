rm(list=ls());
setwd("~/")

svg(filename="PlotTwoPlots.svg")
n_cols <- 1
n_rows <- 2
par(mfrow=c(n_rows,n_cols))
plot(sin, -pi, 2*pi,main="Sine")
hist(runif(100),main="Histogram of 100 random values",xlab="Random value [0,1]",ylab="Frequency")
par(mfrow=c(1,1))
dev.off()