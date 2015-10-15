library(ape);
library(geiger);

# One of the many ways to create a random phylogeny
CreateRandomPhylogeny <- function(n_taxa)
{
  phylogeny <- rcoal(n_taxa)
}

# One of the many ways to create a random phylogeny
DemonstrateCreateRandomPhylogeny <- function(n_taxa)
{
  # Create a random tree with 10 taxa
  phylogeny <- CreateRandomPhylogeny(n_taxa = 10)
  
  # Plot that tree
  plot(phylogeny, main = "CreateRandomPhylogeny")
  
  # Display the tree in Newick format
  newick <- write.tree(phylogeny)
}

#DemonstrateCreateRandomPhylogeny()
