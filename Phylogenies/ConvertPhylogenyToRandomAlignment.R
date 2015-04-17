rm(list=ls());
library(ape);
library(geiger);
library(phangorn);

# One of the many ways to create a random phylogeny
CreateRandomPhylogeny <- function()
{
  phylogeny <- rcoal(5)
  return (phylogeny)
}

phylogeny <- CreateRandomPhylogeny()
# plot(phylogeny)

sequence_length <- 10
data <- simSeq(phylogeny,l=sequence_length)

write.phyDat(data, file="CreateRandomAlignment.fasta", format="fasta")
write.phyDat(data, file="CreateRandomAlignment.nexus", format="nexus")
