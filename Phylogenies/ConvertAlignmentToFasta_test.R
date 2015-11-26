source("~/GitHubs/R/Phylogenies/CreateRandomAlignment.R")
source("~/GitHubs/R/Phylogenies/ConvertAlignmentToFasta.R")

demonstrate_convert_alignment_to_fasta <- function() {

  alignment <- create_random_alignment(n_taxa = 5,sequence_length = 10)
  image(alignment)
  
  filename <- "ConvertAlignmentsToFasta.fasta"
  convert_alignment_to_fasta(alignment,filename)
  file.show(filename)
}

# Uncomment this to view the function demonstration
demonstrate_convert_alignment_to_fasta()
