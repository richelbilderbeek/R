library(ape);
library(geiger);
library(phangorn);

source("~/GitHubs/R/Phylogenies/CreateRandomPhylogeny.R")

convert_phylogeny_to_alignment <- function(
  phylogeny,
  sequence_length,
  mutation_rate = 1
) {
  # Convert a phylogeny to a random DNA alignment

  alignment_phydat <- simSeq(
    phylogeny,
    l=sequence_length,
    rate=mutation_rate
  )
  assert(class(alignment_phydat)=="phyDat")
  alignment_dnabin <- as.DNAbin(alignment_phydat)
  assert(class(alignment_dnabin)=="DNAbin")
  return (alignment_dnabin)
}

ConvertPhylogenyToAlignment <- function(
  phylogeny,
  sequence_length,
  mutation_rate = 1
) {
  print("Warning: use of obsolete function 'ConvertPhylogenyToAlignment', use 'convert_phylogeny_to_alignment' instead")
  return (
    convert_phylogeny_to_alignment(
      phylogeny = phylogeny,
      sequence_length = sequence_length,
      mutation_rate = mutation_rate
    ) 
  )
}



demonstrate_convert_phylogeny_to_alignment <- function() 
{
  
  phylogeny <- create_random_phylogeny(n_taxa = 5)
  alignment <- convert_phylogeny_to_alignment(phylogeny,sequence_length = 10)
  assert(class(alignment)=="DNAbin")

  n_cols <- 1
  n_rows <- 2
  par(mfrow=c(n_rows,n_cols))
  plot(c(0, 1), c(0, 1), ann = F, bty = 'n', type = 'n', xaxt = 'n', yaxt = 'n')
  text(x = 0.5, y = 0.5, paste("convert_phylogeny_to_alignment"),cex = 1.6, col = "black")
  image(alignment)
  par(mfrow=c(1,1))
}

# Uncomment this to view the function demonstration
#demonstrate_convert_phylogeny_to_alignment()
