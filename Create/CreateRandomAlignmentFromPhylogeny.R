rm(list=ls());
library(ape);
library(geiger);
library(phangorn);

# Birth-Death model that stops after a certain number of taxa, with a coelescent species tree
birth_rate <- 0.2
death_rate <- 0.1
n_taxa <- 5
phylogeny <- sim.bdtree(birth_rate, death_rate, stop="taxa",n=n_taxa)
phylogeny <- drop.extinct(phylogeny) # Drop extinct
plot(phylogeny)

sequence_length <- 10
data <- simSeq(phylogeny,l=sequence_length)

write.phyDat(data, file="CreateRandomAlignment.fasta", format="fasta")
write.phyDat(data, file="CreateRandomAlignment.nexus", format="nexus")
