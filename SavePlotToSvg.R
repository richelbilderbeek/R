setwd("~/GitHubs/R")

d <- data.frame(
    x = c(1,1,2,3,5, 8,13,21),
    y = c(1,2,3,5,7,11,13,17)
)
d


svg(filename="SavePlotToSvg.svg")
plot(d)
dev.off()
