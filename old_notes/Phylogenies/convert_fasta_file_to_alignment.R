library(ape)
library(phangorn)
library(phytools)
library(testit)

convert_fasta_file_to_alignment <- function(fasta_filename) {
  print("convert_fasta_file_to_alignment: FAILS")
  stop()
  assert(file.exists(fasta_filename))

  # Read the file
  sequences <- read.FASTA(fasta_filename)
  
  assert(class(sequences)=="DNAbin")

  # Convert to alignment
  alignment <- as.alignment(sequences)
  assert(class(alignment)=="alignment")
  
  # Convert to DNAbin
  alignment_dnabin <- as.DNAbin(alignment)
  assert(class(alignment_dnabin)=="DNAbin")
  
  return (alignment_dnabin)
}