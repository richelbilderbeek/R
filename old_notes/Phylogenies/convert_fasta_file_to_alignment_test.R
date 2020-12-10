source("~/GitHubs/R/Phylogenies/convert_fasta_file_to_alignment.R")
source("~/GitHubs/R/Phylogenies/get_test_fasta_filename.R")
  
convert_fasta_file_to_alignment_test <- function() {
  fasta_filename <- get_test_fasta_filename()
  
  assert(file.exists(fasta_filename))

  alignment <- convert_fasta_file_to_alignment(fasta_filename)
  image(alignment)
}


convert_fasta_file_to_alignment_test()