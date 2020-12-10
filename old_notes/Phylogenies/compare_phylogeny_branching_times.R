# Compare the distribution of branching times of phylogenies created by different processes

library(ape)
library(ggplot2)
library(geiger)

create_birth_death_branching_times <- function(
  n_taxa = 10, 
  birth_rate = 1.0, 
  death_rate = 0.0
) {
  # Birth-Death model that stops after a certain number of taxa, with a coelescent species tree
  phylogeny <- sim.bdtree(birth_rate, death_rate, stop="taxa",n=n_taxa)
  phylogeny <- drop.extinct(phylogeny) # Drop extinct

  # Score branch length
  branching_times <- branching.times(phylogeny)
  return (branching_times)
}

create_coalescent_branching_times <- function(
  n_taxa = 10
) {
  # rcoal generates coalescent trees. The algorithms are described in Paradis (2012).
  phylogeny <- rcoal(n_taxa)
  phylogeny <- drop.extinct(phylogeny) # Drop extinct

  # Score branch length
  branching_times <- branching.times(phylogeny)
  return (branching_times)
}

compare_phylogeny_branching_times <- function() {
  
  n_taxa <- 1000
  birth_rate <- 0.2
  death_rate <- 0.01
  model1 <- create_birth_death_branching_times(n_taxa,birth_rate,death_rate)
  model2 <- create_coalescent_branching_times(n_taxa)
  
  svg(filename="ComparePhylogenyBranchLengthsHistograms.svg")
  par(mfrow=c(1,2))
  hist(model1,main="Contant-rate Birth Death Model")
  hist(model2,main="Coalescent Model")
  par(mfrow=c(1,1))
  dev.off()
  
  svg(filename="ComparePhylogenyBranchingTimes.svg")
  p1 <- hist(model1)
  p2 <- hist(model2)
  minx <- 0
  maxx <- max(max(p1$breaks),max(p2$breaks)) * 1.1 # 10 #max(max(model1),max(model2))
  miny <- 0
  # maxy <- max(max(p1$density),max(p2$density)) * (length(model1) + length(model2)) * 2
  maxy <- max(max(p1$counts),max(p2$counts)) * 1.1
  
  plot(0,0,type="n",xlab="Branch length",ylab="Frequency",main="",xlim=c(0,maxx),ylim=c(0,maxy))
  plot(p1,col=rgb(0.0,0.0,1.0,0.25),add=TRUE,xlim=c(0,maxx),ylim=c(0,maxy))
  plot(p2,col=rgb(1.0,0.0,0.0,0.25),add=TRUE,xlim=c(0,maxx),ylim=c(0,maxy))
  dev.off()
}

compare_phylogeny_branching_times()