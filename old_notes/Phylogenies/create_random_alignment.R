# Create a random alignment and a demonstration of this
source("~/GitHubs/R/Phylogenies/create_random_phylogeny.R")
library(ape)
library(phangorn)

create_random_alignment <- function(
  n_taxa,
  sequence_length,
  rate = 1
) {
  # Create a random alignment

  assert(n_taxa >= 2) # Cannot create trees with less then two branches
  assert(sequence_length >= 1) # Cannot create empty sequences
  
  phylogeny <- create_random_phylogeny(n = n_taxa)
  alignments_phydat <- simSeq(phylogeny, l = sequence_length, rate = rate)
  alignments_dnabin <- as.DNAbin(alignments_phydat)
}