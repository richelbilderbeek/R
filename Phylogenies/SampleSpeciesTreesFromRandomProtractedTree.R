#rm(list=ls())

source("~/GitHubs/R/Phylogenies/GetAverageNltt.R")
source("~/GitHubs/R/Phylogenies/GetPhylogenyCrownAge.R")

library(ape)
library(PBD)

SampleSpeciesTreesFromRandomProtractedTree <- function(
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
  species_trees <- SampleSpeciesTreesFromPbdSimOutput(
    n,
    random_protracted_tree
  )
  return (species_trees)
}

# Does not use pbd_sim()$stree, but generates these like PBD does
SampleSpeciesTreesFromPbdSimOutput <- function(
  n, #How many?
  result
) {
  crown_age <- GetPhylogenyCrownAge(result$tree)
  absL = result$L0
  absL[,2] = abs(result$L0[,2])
  
  species_trees <- NULL
  for (i in c(1:n)) {
    sL = sampletree(absL,crown_age)
    species_tree = as.phylo(read.tree(text = detphy(sL,crown_age)))
    species_trees <- c(species_trees,list(species_tree))
  }
  return (species_trees)
}

PlotSpeciesTrees <- function(
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


DemonstrateSampleSpeciesTrees1 <- function() {

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
  species_trees <- SampleSpeciesTreesFromPbdSimOutput(n=n,pbd_sim_output)
  PlotSpeciesTrees(
    species_trees,
    filename="~/SampleSpeciesTreesFromRandomProtractedTree1a.png"
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
  PlotSpeciesTrees(
    species_trees,
    filename="~/SampleSpeciesTreesFromRandomProtractedTree1b.png"
  )
}

DemonstrateSampleSpeciesTrees2 <- function() {

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
  species_trees <- SampleSpeciesTreesFromPbdSimOutput(n=n,pbd_sim_output)
  
  GetAverageNltt(
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
DemonstrateSampleSpeciesTrees1()
DemonstrateSampleSpeciesTrees2()
