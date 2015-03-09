rm(list=ls());
library(ape);
library(geiger);
setwd("~/")

# Birth-Death model that stops after a certain number of taxa
birth_rate <- 0.2
death_rate <- 0.1
n_taxa <- 100
phylogeny <- sim.bdtree(birth_rate, death_rate, stop="taxa",n=n_taxa)
phylogeny <- drop.extinct(phylogeny) # Drop extinct

# Score branch length
branching_times <- branching.times(phylogeny)

par(mfrow=c(1,2))
plot(phylogeny)
hist(branching_times,main="Branching times",xlab="Branching time",ylab="Frequency")
par(mfrow=c(1,1))

svg(filename="CreateRandomPhylogenyBranchLengthHistogram.svg")
par(mfrow=c(1,2))
plot(phylogeny)
hist(branching_times,main="Branching times",xlab="Branching time",ylab="Frequency")
par(mfrow=c(1,1))
dev.off()


