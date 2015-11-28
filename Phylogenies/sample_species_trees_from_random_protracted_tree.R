source("~/GitHubs/R/Phylogenies/sample_species_trees_from_pbd_sim_output.R")

sample_species_trees_from_random_protracted_tree <- function(
  n, #How many?
  species_initiation_rate_good_species,
  speciation_completion_rate,
  species_initiation_rate_incipient_species,
  extinction_rate_good_species,
  extinction_rate_incipient_species,
  age
) {

  random_protracted_tree <- pbd_sim(
    c(
      species_initiation_rate_good_species,
      speciation_completion_rate,
      species_initiation_rate_incipient_species,
      extinction_rate_good_species,
      extinction_rate_incipient_species
    ),
    age
  )
  species_trees <- sample_species_trees_from_pbd_sim_output(
    n = n,
    pbd_sim_output = random_protracted_tree
  )
  return (species_trees)
}


SampleSpeciesTreesFromRandomProtractedTree <- function(
  n, #How many?
  species_initiation_rate_good_species,
  speciation_completion_rate,
  species_initiation_rate_incipient_species,
  extinction_rate_good_species,
  extinction_rate_incipient_species,
  age
) {
  print("Warning: use of obsolete function 'SampleSpeciesTreesFromRandomProtractedTree', use 'sample_species_trees_from_random_protracted_tree' instead")
  return (
    sample_species_trees_from_random_protracted_tree(
      n = n,
      species_initiation_rate_good_species = species_initiation_rate_good_species,
      speciation_completion_rate = speciation_completion_rate,
      species_initiation_rate_incipient_species = species_initiation_rate_incipient_species,
      extinction_rate_good_species = extinction_rate_good_species,
      extinction_rate_incipient_species = extinction_rate_incipient_species,
      age = age
    )    
  )
}