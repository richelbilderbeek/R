library(ape);
library(geiger);
library(phangorn);

# One of the many ways to create a random phylogeny
CreateRandomPhylogeny <- function(n_taxa) {
  phylogeny <- rcoal(n_taxa)
}

# Create a random alignment
CreateRandomAlignment <- function(n_taxa,sequence_length) {
  phylogeny <- CreateRandomPhylogeny(n_taxa)
  alignment_phydat <- simSeq(phylogeny,l=sequence_length)
  alignment_dnabin <- as.DNAbin(alignment_phydat)
}

# Create a random FASTA file text
ConvertAlignmentToFasta <- function(alignment_dnabin,filename) {
  write.phyDat(alignment_dnabin, file=filename, format="fasta")
}


DemonstrateConvertAlignmentToFasta <- function() {

  alignment <- CreateRandomAlignment(n_taxa = 5,sequence_length = 10)
  image(alignment)
  
  filename <- "ConvertAlignmentsToFasta.fasta"
  ConvertAlignmentToFasta(alignment,filename)
  file.show(filename)
}

# Uncomment this to view the function demonstration
#DemonstrateConvertAlignmentToFasta()
