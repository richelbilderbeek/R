# Function to create a random phylogeny

library(ape)
library(testit)

create_random_phylogeny <- function(n_taxa)
{
  # One of the many ways to create a random phylogeny
  phylogeny <- rcoal(n = n_taxa) 
  
  assert(class(phylogeny) == "phylo")
  assert(length(phylogeny) == 4) #phylo classes have length 4
  assert(names(phylogeny) == c("edge", "edge.length", "tip.label", "Nnode"))

  return (phylogeny)
}