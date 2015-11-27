library(PBD)

source("~/GitHubs/R/Phylogenies/GetPhylogenyCrownAge.R")

# Does not use pbd_sim()$stree, but generates these like PBD does
sample_species_trees_from_pbd_sim_output <- function(
  n, #How many?
  pbd_sim_output
) {
  assert(typeof(pbd_sim_output)=="list")
  assert(length(pbd_sim_output)==9)
  assert(class(pbd_sim_output$tree)=="phylo")
  
  crown_age <- get_phylogeny_crown_age(pbd_sim_output$tree)
  absL = pbd_sim_output$L0
  absL[,2] = abs(pbd_sim_output$L0[,2])
  
  species_trees <- NULL
  for (i in c(1:n)) {
    sL = sampletree(absL,crown_age)
    species_tree = as.phylo(read.tree(text = detphy(sL,crown_age)))
    species_trees <- c(species_trees,list(species_tree))
  }
  
  assert(typeof(species_trees)=="list")
  assert(length(species_trees)==n)
  assert(n == 0 || class(species_trees[[1]])=="phylo")

  return (species_trees)
}