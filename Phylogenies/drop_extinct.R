#rm(list = ls())
library(ape)
library(geiger)
library(testit)

source("~/GitHubs/R/Phylogenies/CanDropExtinct.R")

DropExtinct <- function(newick)
{
  # Using drop.Extinct
  #newick <- "(L:1,(((((XD:1,ZD:1):1,CE:2):1,(FE:2,EE:2):1):1,(GD:1,ID:1):1,BD:1):3,(AC:1,EC:1):1,(((TC:1,FD:2):1,QC:1,RC:1):1,((((AE:1,BE:1):1,(WD:1,YD:1):1):1,HD:1):2,MC:1):1):1):3);"
  phylogeny <- read.tree(text = newick)
  assert(CanDropExtinct(phylogeny))
  phylogeny <- drop.extinct(phylogeny)
  return (phylogeny)
}

DemonstrateCrashDropExtinct <- function()
{
  # Using drop.Extinct
  newick <- "((s1:4.406520938,s2:0.2169422332):9.117964779,s3:3.063930512);"
  phylogeny_complete <- read.tree(text = newick)
  n_cols <- 1
  n_rows <- 2
  par(mfrow=c(n_rows,n_cols))
  plot(phylogeny_complete)
  assert(!CanDropExtinct(phylogeny_complete))
  
  # CRASH HERE:
  # Error in xmat[, 1] : incorrect number of dimensions 
  phylogeny_reconstructed <- drop.extinct(phylogeny_complete) 
  plot(phylogeny_reconstructed)
  par(mfrow=c(1,1))
}

DemonstrateDropExtinct <- function() {
  n_cols <- 1
  n_rows <- 2
  par(mfrow=c(n_rows,n_cols))

  newick <- "(L:1,(((((XD:1,ZD:1):1,CE:2):1,(FE:2,EE:2):1):1,(GD:1,ID:1):1,BD:1):3,(AC:1,EC:1):1,(((TC:1,FD:2):1,QC:1,RC:1):1,((((AE:1,BE:1):1,(WD:1,YD:1):1):1,HD:1):2,MC:1):1):1):3);"
  plot(read.tree(text = newick),main="Before")
  phylogeny <- DropExtinct(newick)
  plot(phylogeny,main="After")

  par(mfrow=c(1,1))
}

#DemonstrateDropExtinct()
#DemonstrateCrashDropExtinct()
