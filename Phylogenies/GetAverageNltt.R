rm(list = ls())
library(ape)
library(geiger)
library(nLTT)

GetTestMatrix1 <- function() {
  #       time    N
  # [1,]  0.0 0.25
  # [2,]  0.4 0.50
  # [3,]  0.7 0.75
  # [4,]  1.0 1.00
  m <- matrix(
    data = c(0.0,0.4,0.7,1.0,0.25,0.50,0.75,1.0),
    nrow = 4,
    ncol = 2,
    byrow = FALSE,
  )
  colnames(m) <- c("time","N")
  return (m);
}

GetTestMatrix2 <- function() {
  #       time    N
  # [1,]  0.0 0.25
  # [2,]  0.2 0.50
  # [3,]  0.5 0.75
  # [4,]  0.8 1.00
  n <- matrix(
    data = c(0.0,0.2,0.5,0.8,0.25,0.50,0.75,1.0),
    nrow = 4,
    ncol = 2,
    byrow = FALSE,
  )
  colnames(m) <- c("time","N")
  return (m);
}

GetTestMatrix3 <- function() {
  #       time    N
  # [1,]  0.0 0.25
  # [2,]  0.2 0.375
  # [3,]  0.4 0.50
  # [4,]  0.5 0.625
  # [5,]  0.7 0.75
  # [6,]  0.8 0.875
  # [7,]  1.0 1.00
  m <- matrix(
    data = c(0.0,0.2,0.4,0.5,0.7,0.8,1.0,0.25,0.375,0.50,0.625,0.75,0.875,1.0),
    nrow = 7,
    ncol = 2,
    byrow = FALSE,
  )
  colnames(m) <- c("time","N")
  return (m);
}


MergeMatrices <- function(m,n) {
  assert(colnames(m) == c("time","N"))
  assert(colnames(n) == c("time","N"))
  # Collect all times
  times <- c(m[,1],n[,1])
  times <- sort(times)
  #Score how many Ns are at each time
  ns <- c(m[,2],n[,2])
  ns <- seq(min(ns),max(ns),(max(ns)-min(ns))/(length(ns)-1))
  assert(length(ns) == length(times))
  m <- matrix(
    data = c(times,ns),
    nrow = length(ns),
    ncol = 2,
    byrow = FALSE,
  )
  colnames(m) <- c("time","N")
  return (m);
}
  
GetPhylogenyNlttMatix <- function(phylogeny) {
  xy <- ltt.plot.coords(phylogeny, backward = TRUE, tol = 1e-06)
  xy[, 2] <- xy[, 2]/max(xy[, 2])
  xy[, 1] <- xy[, 1] + abs(min(xy[, 1]))
  xy[, 1] <- xy[, 1]/max(xy[, 1])
  return (xy)
}

StretchMatrix <- function(m) {
  #es <- c(rep(4,x=0.25),rep(3,x=0.5),rep(3,x=0.75),1.0)
  #m <- GetTestMatrix1()
  m
  ns <- as.numeric(m[,2])
  ns
  ts <- as.numeric(m[,1])
  ts

  # Timestep
  dt <- 0.001 
  
  # Number of repeats
  nreps <- ceiling(as.numeric( (ts[-1] - ts[-length(ts)]) / dt ))
  # Move the last repeat to a next category
  nreps[ length(nreps) ] <- tail(nreps,n=1) - 1
  nreps <- c(nreps,1)
  nreps
  new_ts <- seq(0,1,dt)
  new_ts

  new_ns <- NULL
  for (i in seq(1,length(ns))) {
    this_n <- ns[i]
    #print(value)
    times <- nreps[i]
    if (times == 0) next
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
  phylogeny1, 
  phylogeny2, 
  xlab = "Normalized Time", 
  ylab = "Normalized Lineages", 
  ...
)
{
  m <- GetPhylogenyNlttMatix(phylogeny1)
  m <- StretchMatrix(m)
  
  n <- GetPhylogenyNlttMatix(phylogeny2)
  n <- StretchMatrix(n)

  xy <- (n + m) / 2
  
  plot.default(xy, 
    main = "Average", 
    xlab = "Normalized Time", 
    ylab = "Normalized Lineages", xaxs = "r", yaxs = "r", type = "S"
  )

  lines.default(m,xaxs = "r", yaxs = "r", type = "S",col="grey")
  lines.default(n,xaxs = "r", yaxs = "r", type = "S",col="grey")
}

DemonstrateGetAverageNltt <- function()
{
  # Two different phylogenies
  newick1 <- "((((XD:1,ZD:1):1,CE:2):1,(FE:2,EE:2):1):4,((AE:1,BE:1):1,(WD:1,YD:1):1):5);"
  phylogeny1 <- read.tree(text = newick1)
  plot(phylogeny1)
  nLTT.plot(phylogeny1)
  #nLTT.plot
  

  newick2 <- "((A:0.3,B:0.3):0.7,(C:0.6,D:0.6):0.4);"
  phylogeny2 <- read.tree(text = newick2)
  plot(phylogeny2)
  nLTT.plot(phylogeny2)
  
  # Combine these
  GetAverageNltt(phylogeny1,phylogeny2)
}

# Uncomment this to view the function demonstration
DemonstrateGetAverageNltt()
