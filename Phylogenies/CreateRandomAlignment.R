# Create a random alignment and a demonstration of this

library(ape)
library(geiger)
library(phangorn)

source("~/GitHubs/R/Phylogenies/CreateRandomPhylogeny.R")

# Create a random alignment
create_random_alignment <- function(
  n_taxa,
  sequence_length,
  rate = 1
) {
  phylogeny <- create_random_phylogeny(n_taxa)
  alignments_phydat <- simSeq(phylogeny,l=sequence_length,rate=rate)
  alignments_dnabin <- as.DNAbin(alignments_phydat)
}

CreateRandomAlignment <- function(
  n_taxa,
  sequence_length,
  rate = 1
) {
  print("Warning: use of obsolete function 'CreateRandomAlignment', use 'create_random_alignment' instead")
  return (create_random_alignment(n_taxa = n_taxa, sequence_length = sequence_length, rate = rate))
}

demonstrate_create_random_alignment <- function() {
  # Create the alignment
  alignment <- create_random_alignment(
    n_taxa = 5, 
    sequence_length = 20,
    rate = 0.1
  )
  
  # Prepare plotting two things
  n_cols <- 1
  n_rows <- 2
  par(mfrow=c(n_rows,n_cols))

  # Plot the text
  plot(c(0, 1), c(0, 1), ann = F, bty = 'n', type = 'n', xaxt = 'n', yaxt = 'n')
  text(x = 0.5, y = 0.5, paste("demonstrate_create_random_alignment"),cex = 1.6, col = "black")
  # Plot the alignment
  image(alignment)

  # Restore plotting one thing
  par(mfrow=c(1,1))
}

# Uncomment this to view the function demonstration
#demonstrate_create_random_alignment()