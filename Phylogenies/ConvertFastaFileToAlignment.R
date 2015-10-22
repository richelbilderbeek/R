library(ape)
library(phangorn)
library(phytools)
library(testit)

ConvertFastaFileToAlignment <- function(fasta_filename) {
  assert(file.exists(fasta_filename))

  # Read the file
  sequences <- read.FASTA(fasta_filename)
  
  assert(class(sequences)=="DNAbin")

  # Convert to alignment
  alignment <- as.alignment(sequences)
  assert(class(alignment)=="alignment")
  
  # Convert to DNAbin
  alignment_dnabin <- as.DNAbin(y)
  assert(class(alignment_dnabin)=="DNAbin")
  
  return (alignment_dnabin)
}
  
DemonstrateConvertFastaFileToAlignment <- function() {
  fasta_filename <- "ConvertFastaFileToCoalescentTree.fas"
  alignment <- ConvertFastaFileToAlignment(fasta_filename)
  image(alignment)
}


#DemonstrateConvertFastaFileToAlignment()
