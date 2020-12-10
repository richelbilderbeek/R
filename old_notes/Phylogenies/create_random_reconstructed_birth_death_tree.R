# Creates a random birth-death tree that has not gone extinct, 
# with the extinct lineages removed
# Use 'create_random_birth_death_tree' for a 
# random birth-death tree that has not gone extinct, with the extinct lineages still present

source("~/GitHubs/R/Phylogenies/create_random_birth_death_tree.R")
source("~/GitHubs/R/Phylogenies/is_phylogeny.R")

library(geiger)
library(testit)

create_random_reconstructed_birth_death_tree <- function() {

  phylogeny <- create_random_birth_death_tree()
  assert(is_phylogeny(phylogeny))
  phylogeny <- drop.extinct(phylogeny) # Drop extinct
  assert(is_phylogeny(phylogeny))
  return (phylogeny)  
}