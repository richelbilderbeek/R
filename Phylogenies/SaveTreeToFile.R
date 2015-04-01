rm(list=ls())
library(ape)
library(phytools)

phylogeny <- rcoal(10)
newick_filename <- "SaveTreeToFile.tre"
nexus_filename <- "SaveTreeToFile.nex"

write.tree(phylogeny,newick_filename)
print("Show Newick file:")
cat(readLines(newick_filename), sep = "\n")

writeNexus(phylogeny,nexus_filename)
print("Show Nexus file:")
cat(readLines(nexus_filename), sep = "\n")
