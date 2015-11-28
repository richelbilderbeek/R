#rm(list=ls())

source("~/GitHubs/R/Phylogenies/SampleSpeciesTreesFromRandomProtractedTree.R")
source("~/GitHubs/R/Phylogenies/GetAverageNltt.R")

# source("~/GitHubs/R/Phylogenies/GetPhylogenyCrownAge.R")
# 
# library(ape)
# library(PBD)

# Helper function
plot_species_trees <- function(
  species_trees,
  filename
) {
  png(filename=filename,width = 480, height = 480 * length(species_trees))
  n_cols <- 1
  n_rows <- length(species_trees)
  par(mfrow=c(n_rows,n_cols))
  
  for (species_tree in species_trees) {
    plot(species_tree,cex = 2)
  }
  dev.off()
}


demonstrate_sample_species_trees_1 <- function() {

  n <- 6
  age <- 10
  seed <- 320
  set.seed(seed)
  
  species_initiation_rate_good_species  <- 0.7
  speciation_completion_rate <- 0.2
  species_initiation_rate_incipient_species <- 0.6
  extinction_rate_good_species <- 1.0
  extinction_rate_incipient_species <- 0.6
  
  # Work on the pbd_sim output  
  pbd_sim_output <- pbd_sim(
    c(
      species_initiation_rate_good_species = species_initiation_rate_good_species,
      speciation_completion_rate = speciation_completion_rate,
      species_initiation_rate_incipient_species = species_initiation_rate_incipient_species,
      extinction_rate_good_species = extinction_rate_good_species,
      extinction_rate_incipient_species = extinction_rate_incipient_species
    ),
    age
  )
  species_trees <- sample_species_trees_from_pbd_sim_output(n = n, pbd_sim_output = pbd_sim_output)
  plot_species_trees(
    species_trees,
    filename = "~/SampleSpeciesTreesFromRandomProtractedTree1a.png"
  )

  # Call pbd_sim in SampleSpeciesTreesFromRandomProtractedTree
  set.seed(seed)
  species_trees <- SampleSpeciesTreesFromRandomProtractedTree(
    n = n, #How many?
    species_initiation_rate_good_species = species_initiation_rate_good_species,
    speciation_completion_rate = speciation_completion_rate,
    species_initiation_rate_incipient_species = species_initiation_rate_incipient_species,
    extinction_rate_good_species = extinction_rate_good_species,
    extinction_rate_incipient_species = extinction_rate_incipient_species,
    age
  )
  plot_species_trees(
    species_trees,
    filename="~/SampleSpeciesTreesFromRandomProtractedTree1b.png"
  )
}

demonstrate_sample_species_trees_2 <- function() {

  n <- 10
  age <- 10
  seed <- 320
  set.seed(seed)
  
  species_initiation_rate_good_species  <- 0.7
  speciation_completion_rate <- 0.2
  species_initiation_rate_incipient_species <- 0.6
  extinction_rate_good_species <- 1.0
  extinction_rate_incipient_species <- 0.6
  
  # Work on the pbd_sim output  
  pbd_sim_output <- pbd_sim(
    c(
      species_initiation_rate_good_species = species_initiation_rate_good_species,
      speciation_completion_rate = speciation_completion_rate,
      species_initiation_rate_incipient_species = species_initiation_rate_incipient_species,
      extinction_rate_good_species = extinction_rate_good_species,
      extinction_rate_incipient_species = extinction_rate_incipient_species
    ),
    age
  )
  species_trees <- sample_species_trees_from_pbd_sim_output(n=n,pbd_sim_output)
  
  get_average_nltt(
    species_trees,
    plot_nltts = TRUE, 
    main = "Sampled species trees (black) versus gene tree (red)"
  )
  nLTT.lines(
    pbd_sim_output$tree,
    col = "red"
  )

}

# Uncomment this to view the function demonstration
demonstrate_sample_species_trees_1()
demonstrate_sample_species_trees_2()
