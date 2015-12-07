source("~/GitHubs/R/Phylogenies/create_random_alignment.R")
source("~/GitHubs/R/Phylogenies/convert_alignment_to_fasta.R")
source("~/GitHubs/R/Phylogenies/get_test_fasta_filename.R")


convert_alignment_to_fasta_test <- function() {

  alignment <- create_random_alignment(n_taxa = 5,sequence_length = 10)
  assert(class(alignment) == "DNAbin")
  image(alignment)
  
  filename <- get_test_fasta_filename()
  convert_alignment_to_fasta(alignment,filename)
  file.show(filename)
}

convert_alignment_to_fasta_test()
