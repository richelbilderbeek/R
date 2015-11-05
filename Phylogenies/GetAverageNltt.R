library(ape)
library(geiger)
library(nLTT)

GetAverageNltt1 <- function(
  phy, 
  xlab = "Normalized Time", 
  ylab = "Normalized Lineages", 
  ...
)
{
  xy <- ltt.plot.coords(phy, backward = TRUE, tol = 1e-06)
  xy[, 2] <- xy[, 2]/max(xy[, 2])
  xy[, 1] <- xy[, 1] + abs(min(xy[, 1]))
  xy[, 1] <- xy[, 1]/max(xy[, 1])
  plot.default(xy, xlab = xlab, ylab = ylab, xaxs = "r", yaxs = "r", type = "S", ...)
}

GetAverageNltt <- function(
  phy, 
  xlab = "Normalized Time", 
  ylab = "Normalized Lineages", 
  ...
)
{
  newick <- "((A:0.3,B:0.3):0.7,(C:0.6,D:0.6):0.4);"
  phy <- read.tree(text = newick)
  xys <- NULL
  
  xy <- ltt.plot.coords(phy, backward = TRUE, tol = 1e-06)
  xy[, 2] <- xy[, 2]/max(xy[, 2])
  xy[, 1] <- xy[, 1] + abs(min(xy[, 1]))
  xy[, 1] <- xy[, 1]/max(xy[, 1])

#       time    N
# [1,]  0.0 0.25
# [2,]  0.4 0.50
# [3,]  0.7 0.75
# [4,]  1.0 1.00
  
  assert(class(xy) == "matrix")
  xys <- c(xys,xy)
  xy
  xys
  plot.default(xy, xlab = "Normalized Time", ylab = "Normalized Lineages", xaxs = "r", yaxs = "r", type = "S")
#  plot.default(xy, xlab = xlab, ylab = ylab, xaxs = "r", yaxs = "r", type = "S", ...)
}

DemonstrateGetAverageNltt <- function()
{
  # Two different phylogenies
  newick1 <- "((((XD:1,ZD:1):1,CE:2):1,(FE:2,EE:2):1):4,((AE:1,BE:1):1,(WD:1,YD:1):1):5);"
  phylogeny1 <- read.tree(text = newick1)
  plot(phylogeny1)
  nLTT.plot(phylogeny1)
  nLTT.plot
  

  newick2 <- "((A:0.3,B:0.3):0.7,(C:0.6,D:0.6):0.4);"
  phylogeny2 <- read.tree(text = newick2)
  plot(phylogeny2)
  nLTT.plot(phylogeny2)
  
  # Combine these
  GetAverageNltt(phylogeny1)

  nLTT.plot
}

# Uncomment this to view the function demonstration
DemonstrateGetAverageNltt()
