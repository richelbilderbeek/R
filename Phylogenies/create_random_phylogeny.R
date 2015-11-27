# Function to create a random phylogeny and a demonstration of this

library(ape)
library(geiger)

create_random_phylogeny <- function(n_taxa)
{
  # One of the many ways to create a random phylogeny
  phylogeny <- rcoal(n_taxa)
}

CreateRandomPhylogeny <- function(n_taxa)
{
  print("Warning: use of obsolete function 'CreateRandomPhylogeny', use 'create_random_phylogeny' instead")
  return (create_random_phylogeny(n_taxa))
}

# One of the many ways to create a random phylogeny
demonstrate_create_random_phylogeny <- function(n_taxa)
{
  # Create a random tree with 10 taxa
  phylogeny <- create_random_phylogeny(n_taxa = 10)
  
  # Plot that tree
  plot(phylogeny, main = "create_random_phylogeny")
  
  # Display the tree in Newick format
  newick <- write.tree(phylogeny)
}

#demonstrate_create_random_phylogeny()
