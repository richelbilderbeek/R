library(ape);
library(geiger);
library(phangorn);

source("~/GitHubs/R/Phylogenies/CreateRandomPhylogeny.R")

# Convert a phylogeny to a random DNA alignment
ConvertPhylogenyToAlignment <- function(
  phylogeny,
  sequence_length,
  mutation_rate = 1
) 
{
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


DemonstrateConvertPhylogenyToAlignment <- function() 
{
  phylogeny <- CreateRandomPhylogeny(n_taxa= 5)
  alignment <- ConvertPhylogenyToAlignment(phylogeny,sequence_length = 10)
  assert(class(alignment)=="DNAbin")
  image(alignment)
}

# Uncomment this to view the function demonstration
#DemonstrateConvertPhylogenyToAlignment()
