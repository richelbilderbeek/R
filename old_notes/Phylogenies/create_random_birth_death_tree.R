# Creates a random birth-death tree that has not gone extinct, 
# including the extinct lineages
# Use 'create_random_reconstructed_birth_death_tree' for a 
# random birth-death tree that has not gone extinct, with the extinct lineages removed
source("~/GitHubs/R/Phylogenies/is_phylogeny.R")
library(geiger)
library(testit)

create_random_birth_death_tree <- function() {

  # Birth-Death model that stops after a certain number amount of time
  birth_rate <- 0.2
  death_rate <- 0.1
  tim <- 15
  phylogeny <- sim.bdtree(
    b = birth_rate, 
    d = death_rate, 
    stop = "time",
    n = time,
    extinct = FALSE
  )
  
  assert(is_phylogeny(phylogeny))
  return (phylogeny)  
}