# Test the create_random_fasta function

source("~/GitHubs/R/Phylogenies/create_random_fasta.R")

create_random_fasta_test <- function() {
  n_taxa <- 5
  sequence_length <- 10
  filename <- "create_random_fasta.fasta"
  create_random_fasta(n_taxa,sequence_length,filename)
  file.show(filename)
}


create_random_fasta_test()
