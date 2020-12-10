# Create a random FASTA file

library(ape)
#library(geiger)
#library(phangorn)

source("~/GitHubs/R/Phylogenies/create_random_alignment.R")

# Create a random FASTA file text
create_random_fasta <- function(n_taxa,sequence_length,filename) {
  alignments <- create_random_alignment(n_taxa,sequence_length)
  write.phyDat(alignments, file=filename, format="fasta")
}