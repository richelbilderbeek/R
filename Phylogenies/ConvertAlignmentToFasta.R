library(ape)
library(geiger)
library(phangorn)

source("~/GitHubs/R/Phylogenies/CreateRandomAlignment.R")

convert_alignment_to_fasta <- function(
  alignment_dnabin,
  filename
) {
  # Create a FASTA file text from an alignment

  write.phyDat(alignment_dnabin, file=filename, format="fasta")
}

ConvertAlignmentToFasta <- function(alignment_dnabin, filename) {
  print("Warning: use of obsolete function 'ConvertAlignmentToFasta', use 'convert_alignment_to_fasta' instead")
  return (
    convert_alignment_to_fasta(
      alignment_dnabin = alignment_dnabin,
      filename = filename
    )
  )
}


demonstrate_convert_alignment_to_fasta <- function() {

  alignment <- create_random_alignment(n_taxa = 5,sequence_length = 10)
  image(alignment)
  
  filename <- "ConvertAlignmentsToFasta.fasta"
  convert_alignment_to_fasta(alignment,filename)
  file.show(filename)
}

# Uncomment this to view the function demonstration
#demonstrate_convert_alignment_to_fasta()
