# Create a random FASTA file and a demonstration of this

#rm(list=ls())
library(ape)
library(geiger)
library(phangorn)

source("~/GitHubs/R/Phylogenies/CreateRandomAlignment.R")

# Create a random FASTA file text
create_random_fasta <- function(n_taxa,sequence_length,filename) {
  alignments <- create_random_alignment(n_taxa,sequence_length)
  write.phyDat(alignments, file=filename, format="fasta")
}

CreateRandomFasta <- function(n_taxa,sequence_length,filename) {
  print("Warning: use of obsolete function 'CreateRandomFasta', use 'create_random_fasta' instead")
  return (
    create_random_fasta(
      n_taxa = n_taxa,
      sequence_length=sequence_length, 
      filename=filename
    )
  )
}


demonstrate_create_random_fasta <- function() {
  n_taxa <- 5
  sequence_length <- 10
  filename <- "CreateRandomFasta.fasta"
  create_random_fasta(n_taxa,sequence_length,filename)
  file.show(filename)
}


#demonstrate_create_random_fasta()
