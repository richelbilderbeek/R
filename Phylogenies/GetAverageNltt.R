#rm(list = ls())
library(ape)
library(geiger)
library(nLTT)
library(testit)

GetPhylogenyNlttMatrix <- function(phylogeny) {
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
# I need to reverse the timepoints
StretchMatrix <- function(m,dt) {
  # If the matrix has multiple Ns for the same t, take the lowest 
  m<-aggregate(
    x=m,
    by=list(factor(m[,1])),
    FUN="min"
  )

  ns <- as.numeric(m[,3])
  ts <- 1.0 - as.numeric(m[,2])
  
  
  assert(ns[1] != ns[2])
  assert(ts[1] != ts[2])
  a <- approx(ts, ns, method = "constant", n = 1 / dt)
  ?approx
  new_ts <- 1.0 - a$x
  new_ns <- a$y
  assert(length(new_ts) == length(new_ns))
  n <- matrix(
    data = c(new_ts,new_ns),
    nrow = length(new_ts),
    ncol = 2,
    byrow = FALSE,
  )
  return (n)
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
StretchMatrixPrevious <- function(m,dt) {
  ns <- as.numeric(m[,2])
  ts <- as.numeric(m[,1])
  
  # Number of repeats
  nreps <- ceiling(as.numeric( (ts[-1] - ts[-length(ts)]) / dt ))
  # Move the last repeat to a next category
  new_ts <- seq(0,1,dt)
  new_ts <- c(0.0,new_ts)

  new_ns <- NULL
  new_ns <- c(new_ns,ns[1])
  ns <- ns[-1]
  for (i in seq(1,length(ns))) {
    this_n <- ns[i]
    times <- nreps[i]
    new_n <- rep(x = this_n,times = times)
    new_ns <- c(new_ns,new_n)
  }

  #Workaround
  if(length(new_ts) != length(new_ns))
  {
    print("Warning: workaround #1") 
    length(new_ns) <- length(new_ts)
  }
  if(tail(new_ts,n=1) != 1.0) {
    print("Warning: workaround #2") 
    new_ts[ length(new_ts) ] = 1.0
  }
  if(tail(new_ns,n=1) != 1.0) {
    print("Warning: workaround #3") 
    new_ns[ length(new_ns) ] = 1.0
  }
  
  assert(tail(new_ts,n=1) == 1.0)
  
  assert(length(new_ts) == length(new_ns))
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
  plot_nltts = FALSE,
  xlab = "Normalized Time", 
  ylab = "Normalized Lineages",
  ...
)
{
  sz <- length(phylogenies)

  nltts <- NULL
  for (phylogeny in phylogenies) {
    nltts <- c(nltts,list(GetPhylogenyNlttMatrix(phylogeny)))
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
  
  # Set the shape of the plot
  plot.default(
    xy, 
    xlab = "Normalized Time", 
    ylab = "Normalized Lineages", 
    xaxs = "r", 
    yaxs = "r", 
    type = "S",
    xlim=c(0,1),
    ylim=c(0,1),
    ...
  )

  # Draw the nLTTS plots used
  if (plot_nltts == TRUE) {
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

  # Redraw the average nLTT plot
  lines.default(
    xy,
    xaxs = "r", 
    yaxs = "r", 
    type = "S",
    col="black",
    xlim=c(0,1),
    ylim=c(0,1)
  )
}

DemonstrateGetPhylogenyNlttMatrix <- function() {
  newick <- "((((XD:1,ZD:1):1,CE:2):1,(FE:2,EE:2):1):4,((AE:1,BE:1):1,(WD:1,YD:1):1):5);"
  phylogeny <- read.tree(text = newick)
  plot(phylogeny)
  add.scale.bar()

  # Create nLTT plot
  nLTT.plot(phylogeny)
  
  # Demonstrate the GetPhylogenyNlttMatrix function
  nltt <- GetPhylogenyNlttMatrix(phylogeny)
  points(nltt, pch = 19,col="red")

  # Demonstrate the StretchMatrix function
  stretch_matrix <- StretchMatrix(nltt,dt = 0.05)
  points(stretch_matrix, pch = 19,col="blue")

  
}

DemonstrateGetAverageNltt <- function()
{
  # Two different phylogenies
  newick1 <- "((((XD:1,ZD:1):1,CE:2):1,(FE:2,EE:2):1):4,((AE:1,BE:1):1,(WD:1,YD:1):1):5);"
  phylogeny1 <- read.tree(text = newick1)
  
  newick2 <- "((A:0.3,B:0.3):0.7,(C:0.6,D:0.6):0.4);"
  phylogeny2 <- read.tree(text = newick2)

  plot(phylogeny1)
  plot(phylogeny2)
  nLTT.plot(phylogeny1)
  nLTT.lines(phylogeny2,col = "gray")
  
  # Combine these at different resolutions
  phylogenies <- list(phylogeny1,phylogeny2)
  for (dt in c(0.2,0.05,0.01)) {
    GetAverageNltt(phylogenies,dt = dt,main=paste("dt:",dt))
    nLTT.lines(phylogeny1,col="red")
    nLTT.lines(phylogeny2,col="blue")
  }
  
  
#   # Now random trees
#   phylogenies <- NULL
#   for (i in seq(1,20)) {
#     phylogeny <- rcoal(n = 10)
#     phylogenies <- c(phylogenies,list(phylogeny))
#   }
#   
#   GetAverageNltt(
#     phylogenies,
#     dt = 0.01,
#     plot_nltts = TRUE,
#     main = "Average LTT of 20 coalescent trees"
#     
#   )
}

# Uncomment this to view the function demonstration
DemonstrateGetPhylogenyNlttMatrix()
DemonstrateGetAverageNltt()
