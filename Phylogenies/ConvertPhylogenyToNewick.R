rm(list=ls())
library(ape)
library(phangorn)
library(phytools)
library(testit)

# Create a random tree
phylogeny <- rcoal(10)
plot(phylogeny)

# Convert to newick
newick <- write.tree(phylogeny,file="")
print(newick)

