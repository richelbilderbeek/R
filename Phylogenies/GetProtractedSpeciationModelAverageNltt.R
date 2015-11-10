#rm(list = ls())
library(PBD)

source("~/GitHubs/R/Phylogenies/GetAverageNltt.R")

GetProtractedSpeciationModelAverageNltt <- function(
  b_1,  #the speciation-initiation rate of good species
  la_1, #the speciation-completion rate 
  b_2,  # the speciation-initiation rate of incipient species 
  mu_1, # the extinction rate of good species 
  mu_2, # the extinction rate of incipient species 
  crown_age,
  n_trees,
  gene_tree_of_species_tree,
  ...
)
{
  assert(gene_tree_of_species_tree == "gene_tree" || gene_tree_of_species_tree == "species_tree")
  
  phylogenies <- NULL
  for (i in seq(1,n_trees)) {
    trees_full <-pbd_sim(c(b_1,la_1,b_2,mu_1,mu_2),crown_age,soc=2,plot=0)
    
    if (gene_tree_of_species_tree == "gene_tree") {
      phylogeny <- trees_full$tree #Will be similar to a BD tree
    } else {
      phylogeny <- trees_full$stree #Species tree
    }
    phylogenies <- c(phylogenies,list(phylogeny))
  }
  
  GetAverageNltt(
    phylogenies,
    ...
  )
}

DemonstrateGetProtractedSpeciationModelAverageNltt1 <- function() {
  #
  # Compare gene tree and species tree
  #  
  
  speciation_initiation_rate_good_species <- 0.2
  speciation_completion_rate <- 0.1
  speciation_initiation_rate_incipient_species <- 0.2
  extinction_rate_good_species <- 0.1
  extinction_rate_incipient_species <- 0.1
  crown_age <- 15
  n_trees <- 10
  
  # Compare species tree and gene tree
  GetProtractedSpeciationModelAverageNltt(
    b_1  = speciation_initiation_rate_good_species,
    la_1 = speciation_completion_rate,
    b_2  = speciation_initiation_rate_incipient_species,
    mu_1 = extinction_rate_good_species,
    mu_2 = extinction_rate_incipient_species,
    crown_age = crown_age,
    n_trees = n_trees,
    gene_tree_of_species_tree = "species_tree",
    col = "red",
    plot_nltts = FALSE,
    main = paste(
      "Average nLTT of ",n_trees,
      " PBD species trees (red) and gene trees (blue).\n",
      "  b_1: ",speciation_initiation_rate_good_species,
      ", b_2: ",speciation_initiation_rate_incipient_species,
      ", la_1: ",speciation_completion_rate,
      ", mu_1: ",extinction_rate_good_species,
      ", mu_2: ",extinction_rate_incipient_species,
      ", crown age: ",crown_age,")"
      ,sep=""
    ),
  )
  
  GetProtractedSpeciationModelAverageNltt(
    b_1  = speciation_initiation_rate_good_species,
    la_1 = speciation_completion_rate,
    b_2  = speciation_initiation_rate_incipient_species,
    mu_1 = extinction_rate_good_species,
    mu_2 = extinction_rate_incipient_species,
    crown_age = crown_age,
    n_trees = n_trees,
    gene_tree_of_species_tree = "gene_tree",
    col = "blue",
    plot_nltts = FALSE,
    replot = TRUE #Overlay this on a current plot
  )
}

DemonstrateGetProtractedSpeciationModelAverageNltt2 <- function() {
  #
  # Species tree become more like BD for higher speciation completion rates
  #  
  
  speciation_initiation_rate_good_species <- 0.2
  speciation_completion_rates <- rep(x=0.01,times=5)
  speciation_initiation_rate_incipient_species <- 0.2
  extinction_rate_good_species <- 0.1
  extinction_rate_incipient_species <- 0.1
  crown_age <- 15
  n_trees <- 10
  
  # Compare species tree and gene tree
  GetProtractedSpeciationModelAverageNltt(
    b_1  = speciation_initiation_rate_good_species,
    la_1 = speciation_completion_rates[1],
    b_2  = speciation_initiation_rate_incipient_species,
    mu_1 = extinction_rate_good_species,
    mu_2 = extinction_rate_incipient_species,
    crown_age = crown_age,
    n_trees = n_trees,
    gene_tree_of_species_tree = "species_tree",
    col = "blue",
    plot_nltts = FALSE,
    main = paste(
      "Average nLTT of ",n_trees,
      " PBD species trees (red) and gene trees (blue).\n",
      "  b_1: ",speciation_initiation_rate_good_species,
      ", b_2: ",speciation_initiation_rate_incipient_species,
      ", la_s: variable",
      ", mu_1: ",extinction_rate_good_species,
      ", mu_2: ",extinction_rate_incipient_species,
      ", crown age: ",crown_age,")"
      ,sep=""
    ),
  )
  
  speciation_completion_rates <- speciation_completion_rates[-1]
  
  for (speciation_completion_rate in speciation_completion_rates) {
    GetProtractedSpeciationModelAverageNltt(
      b_1  = speciation_initiation_rate_good_species,
      la_1 = speciation_completion_rate,
      b_2  = speciation_initiation_rate_incipient_species,
      mu_1 = extinction_rate_good_species,
      mu_2 = extinction_rate_incipient_species,
      crown_age = crown_age,
      n_trees = n_trees,
      gene_tree_of_species_tree = "gene_tree",
      col = "blue",
      plot_nltts = FALSE,
      replot = TRUE #Overlay this on a current plot
    )
  }
}

# Uncomment this to view the function demonstration
DemonstrateGetProtractedSpeciationModelAverageNltt1()
DemonstrateGetProtractedSpeciationModelAverageNltt2()
