#rm(list = ls())
library(ape)
library(geiger)
library(nLTT)

GetPhylogenyNlttMatix <- function(phylogeny) {
  xy <- ltt.plot.coords(phylogeny, backward = TRUE, tol = 1e-06)
  xy[, 2] <- xy[, 2]/max(xy[, 2])
  xy[, 1] <- xy[, 1] + abs(min(xy[, 1]))
  xy[, 1] <- xy[, 1]/max(xy[, 1])
  return (xy)
}

# Fill in the timepoints:
#
# t   N
# 0.0 0.2
# 0.4 0.5
# 1.0 1.0
#
# becomes
#
# t   N
# 0.0 0.2
# 0.1 0.2
# 0.2 0.2
# 0.3 0.2
# 0.4 0.5
# 0.5 0.5
# 0.6 0.5
# 0.7 0.5
# 0.8 0.5
# 0.9 0.5
# 1.0 1.0
#
# becomes

StretchMatrix <- function(m,dt) {
  #es <- c(rep(4,x=0.25),rep(3,x=0.5),rep(3,x=0.75),1.0)
  #m <- GetTestMatrix1()
  m
  ns <- as.numeric(m[,2])
  ns
  ts <- as.numeric(m[,1])
  ts

  # Timestep
  #dt <- 0.05
  
  # Number of repeats
  nreps <- ceiling(as.numeric( (ts[-1] - ts[-length(ts)]) / dt ))
  # Move the last repeat to a next category
  #nreps[ length(nreps) ] <- tail(nreps,n=1) - 1
  #nreps <- c(nreps,1)
  #print(paste("nreps:",nreps))
  new_ts <- seq(0,1,dt)
  new_ts <- c(new_ts,0.0)

  new_ns <- NULL
  new_ns <- c(new_ns,ns[1])
  ns <- ns[-1]
  for (i in seq(1,length(ns))) {
    this_n <- ns[i]
    #print(value)
    times <- nreps[i]
    #if (times == 0) next
    #print(times)
    new_n <- rep(x = this_n,times = times)
    #print(to_add)
    new_ns <- c(new_ns,new_n)
  }
  #new_ns
  #print(paste(length(new_ns),length(new_ts),sep=" - "))
  assert(length(new_ts) == length(new_ns))
  #es
  #assert(es == rs)
  n <- matrix(
    data = c(new_ts,new_ns),
    nrow = length(new_ts),
    ncol = 2,
    byrow = FALSE,
  )
  return (n)
}

GetAverageNltt <- function(
  phylogenies, 
  dt,
  xlab = "Normalized Time", 
  ylab = "Normalized Lineages",
  ...
)
{
  sz <- length(phylogenies)

  nltts <- NULL
  for (phylogeny in phylogenies) {
    nltts <- c(nltts,list(GetPhylogenyNlttMatix(phylogeny)))
  }
  nltts
  assert(length(nltts) == length(phylogenies))

  stretch_matrices <- NULL
  for (nltt in nltts) {
    stretch_matrix <- StretchMatrix(nltt,dt = dt)
    #print(stretch_matrix)
    stretch_matrices <- c(stretch_matrices,list(stretch_matrix))
  }
  stretch_matrices
  assert(length(stretch_matrices) == length(nltts))
  
  xy <- stretch_matrices[[1]]
  for (i in seq(2,sz)) {
    xy <- (xy + stretch_matrices[[i]])
  }
  xy <- (xy / sz)
  #print(xy)
  
  plot.default(xy, 
    main = "Average", 
    xlab = "Normalized Time", 
    ylab = "Normalized Lineages", 
    xaxs = "r", 
    yaxs = "r", 
    type = "S",
    xlim=c(0,1),
    ylim=c(0,1)
  )

  for (stretch_matrix in stretch_matrices) {
    lines.default(
      stretch_matrix,
      xaxs = "r", 
      yaxs = "r", 
      type = "S",
      col="grey",
      xlim=c(0,1),
      ylim=c(0,1)
    )
  }
  
}

DemonstrateGetAverageNltt <- function()
{
  # Two different phylogenies
  newick1 <- "((((XD:1,ZD:1):1,CE:2):1,(FE:2,EE:2):1):4,((AE:1,BE:1):1,(WD:1,YD:1):1):5);"
  phylogeny1 <- read.tree(text = newick1)
  #plot(phylogeny1)

  newick2 <- "((A:0.3,B:0.3):0.7,(C:0.6,D:0.6):0.4);"
  phylogeny2 <- read.tree(text = newick2)
  #plot(phylogeny2)
  nLTT.plot(phylogeny1)
  nLTT.lines(phylogeny2,col = "gray")
  
  # Combine these
  phylogenies <- list(phylogeny1,phylogeny2)
  GetAverageNltt(phylogenies,dt = 0.2)
  nLTT.lines(phylogeny1,col="red")
  nLTT.lines(phylogeny2,col="red")
  GetAverageNltt(phylogenies,dt = 0.05)
  nLTT.lines(phylogeny1,col="red")
  nLTT.lines(phylogeny2,col="red")
  GetAverageNltt(phylogenies,dt = 0.001)
  nLTT.lines(phylogeny1,col="red")
  nLTT.lines(phylogeny2,col="red")
}

# Uncomment this to view the function demonstration
DemonstrateGetAverageNltt()
