library(ape);
library(geiger);
library(phangorn);

# One of the many ways to create a random phylogeny
CreateRandomPhylogeny <- function(n_taxa) {
  phylogeny <- rcoal(n_taxa)
}

# Create a random alignment
CreateRandomAlignments <- function(n_taxa,sequence_length) {
  phylogeny <- CreateRandomPhylogeny(n_taxa)
  alignments_phydat <- simSeq(phylogeny,l=sequence_length)
  alignments_dnabin <- as.DNAbin(alignments_phydat)
}

# Create a random FASTA file text
ConvertAlignmentsToFasta <- function(alignments_dnabin,filename) {
  write.phyDat(alignments_dnabin, file=filename, format="fasta")
}


DemonstrateConvertAlignmentsToFasta <- function() {

  alignment <- CreateRandomAlignments(n_taxa = 5,sequence_length = 10)
  image(alignment)
  
  filename <- "ConvertAlignmentsToFasta.fasta"
  ConvertAlignmentsToFasta(alignment,filename)
  file.show(filename)
}

# Uncomment this to view the function demonstration
#DemonstrateConvertAlignmentsToFasta()