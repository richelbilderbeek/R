library(ape)
library(geiger)
library(phangorn)

source("~/GitHubs/R/Phylogenies/CreateRandomPhylogeny.R")

# Create a random alignment
CreateRandomAlignment <- function(
  n_taxa,
  sequence_length,
  rate = 1) 
{
  phylogeny <- CreateRandomPhylogeny(n_taxa)
  alignments_phydat <- simSeq(phylogeny,l=sequence_length,rate=rate)
  alignments_dnabin <- as.DNAbin(alignments_phydat)
}

DemonstrateCreateRandomAlignment <- function() {
  # Create the alignment
  alignment <- CreateRandomAlignment(
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
  text(x = 0.5, y = 0.5, paste("DemonstrateCreateRandomAlignment"),cex = 1.6, col = "black")
  # Plot the alignment
  image(alignment)

  # Restore plotting one thing
  par(mfrow=c(1,1))
}

# Uncomment this to view the function demonstration
#DemonstrateCreateRandomAlignment()