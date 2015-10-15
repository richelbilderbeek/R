library(ape);
library(geiger);
library(phangorn);

# One of the many ways to create a random phylogeny
CreateRandomPhylogeny <- function(n_taxa)
{
  phylogeny <- rcoal(n_taxa)
}

# Convert a phylogeny to a random DNA alignment
ConvertPhylogenyToRandomAlignment <- function(
  phylogeny,
  sequence_length,
  mutation_rate = 1
) 
{
  alignments_phydat <- simSeq(
    phylogeny,
    l=sequence_length,
    rate=mutation_rate
  )
  alignments_dnabin <- as.DNAbin(alignments_phydat)
}


DemonstrateConvertPhylogenyToRandomAlignment <- function() 
{
  phylogeny <- CreateRandomPhylogeny(n_taxa= 5)
  alignment <- ConvertPhylogenyToRandomAlignments(phylogeny,sequence_length = 10)
  image(alignment)
}

# Uncomment this to view the function demonstration
#DemonstrateConvertPhylogenyToRandomAlignment()