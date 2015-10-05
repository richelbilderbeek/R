rm(list=ls());
library(ape);
library(geiger);
library(phangorn);

# One of the many ways to create a random phylogeny
CreateRandomPhylogeny <- function(n_taxa)
{
  phylogeny <- rcoal(n_taxa)
}

# Create a random alignment
CreateRandomAlignments <- function(n_taxa,sequence_length) 
{
  phylogeny <- CreateRandomPhylogeny(n_taxa)
  alignments_phydat <- simSeq(phylogeny,l=sequence_length)
  alignments_dnabin <- as.DNAbin(alignments_phydat)
}
