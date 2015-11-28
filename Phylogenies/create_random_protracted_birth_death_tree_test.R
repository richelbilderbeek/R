source("~/GitHubs/R/Phylogenies/create_random_protracted_birth_death_tree.R")

demonstrate_create_random_protracted_birth_death_tree <- function() {

  set.seed(3)
  
  # Simulate a tree from a protracted birth-death model 
  # that stops after a certain length of time
  pbd_sim_out <- CreateRandomProtractedBirthDeathTree(
    speciation_initiation_rate_good_species = 0.2,
    speciation_completion_rates = 0.1,
    speciation_initiation_rate_incipient_species = 0.2,
    extinction_rate_good_species = 0.1,
    extinction_rate_incipient_species = 0.1,
    crown_age = 10,
    do_plot = TRUE  
  )
  
  # You can view with names what you can zoom in on
  names(pbd_sim_out)
  
  # Or, from the documentation:
  # tree is the tree of extant species in phylo format 
  # stree is a tree with one sample per species in phylo format 
  # L is a matrix of all events in the simulation where 
  # - the first column is the incipient-level label of a species 
  # - the second column is the incipient-level label of the parent of the species 
  # - the third column is the time at which a species is born as incipient species
  # - the fourth column is the time of speciation-completion of the species 
  # If the fourth element equals -1, then the species is still incipient. - the fifth column is the time of extinction of the species 
  # If the fifth element equals -1, then the species is still extant. - The sixth column is the species-level label of the species 
  # sL is a matrix like L but for stree 
  # igtree.extinct is the tree in simmap format with incipient and good flags and including extinct species 
  # igtree.extant is the tree in simmap format with incipient and good flags without extinct species 
  # recontree is the reconstructed tree in phylo format, reconstructed using the approximation in Lambert et al. 2014 
  # reconL is the matrix corresponding to recontree 
  # L0 is a matrix where the crown age is at 0; for internal use only 
  par(mfrow=c(2,1))
  plot(pbd_sim_out$tree,main="Extant species")
  plot(pbd_sim_out$stree,main="One sample per extant species")  
  par(mfrow=c(1,1))
}


demonstrate_create_random_protracted_birth_death_tree()
