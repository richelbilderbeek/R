# Create a random alignment and a demonstration of this

library(ape)
#library(geiger)
library(phangorn)

source("~/GitHubs/R/Phylogenies/create_random_phylogeny.R")

# Create a random alignment
create_random_alignment <- function(
  n_taxa,
  sequence_length,
  rate = 1
) {
  phylogeny <- create_random_phylogeny(n_taxa)
  alignments_phydat <- simSeq(phylogeny,l=sequence_length,rate=rate)
  alignments_dnabin <- as.DNAbin(alignments_phydat)
}

CreateRandomAlignment <- function(
  n_taxa,
  sequence_length,
  rate = 1
) {
  print("Warning: use of obsolete function 'CreateRandomAlignment', use 'create_random_alignment' instead")
  return (create_random_alignment(n_taxa = n_taxa, sequence_length = sequence_length, rate = rate))
}