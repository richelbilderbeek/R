# Function to create a random phylogeny

source("~/GitHubs/R/Phylogenies/is_phylogeny.R")

library(ape)
library(testit)

create_random_phylogeny <- function(n_taxa)
{
  # One of the many ways to create a random phylogeny
  
  assert(length(n_taxa) == 1)
  assert(n_taxa >= 2)
  
  phylogeny <- rcoal(n = n_taxa) 
  
  assert(is_phylogeny(phylogeny))

  return (phylogeny)
}
