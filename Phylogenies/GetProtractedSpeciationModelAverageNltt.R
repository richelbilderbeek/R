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
    dt = 0.001,
    main = paste(
      "Average nLTT of ",n_trees,
      " PBD ",gene_tree_of_species_tree," (b_1: ",b_1,
      ", b_2: ",b_2,
      ", la_1: ",la_1,
      ", mu_1: ",mu_1,
      ", mu_2: ",mu_2,
      ", crown age: ",crown_age,")"
      ,sep=""
    ),
    ...
  )
}

DemonstrateGetProtractedSpeciationModelAverageNltt <- function() {
  GetProtractedSpeciationModelAverageNltt(
    b_1  = 0.2, #the speciation-initiation rate of good species
    la_1 = 0.1, #the speciation-completion rate 
    b_2  = 0.2, # the speciation-initiation rate of incipient species 
    mu_1 = 0.1, # the extinction rate of good species 
    mu_2 = 0.1, # the extinction rate of incipient species 
    crown_age = 15,
    n_trees = 10,
    gene_tree_of_species_tree = "species_tree",
    plot_nltts = FALSE
  )
  GetProtractedSpeciationModelAverageNltt(
    b_1  = 0.2, #the speciation-initiation rate of good species
    la_1 = 0.1, #the speciation-completion rate 
    b_2  = 0.2, # the speciation-initiation rate of incipient species 
    mu_1 = 0.1, # the extinction rate of good species 
    mu_2 = 0.1, # the extinction rate of incipient species 
    crown_age = 15,
    n_trees = 10,
    gene_tree_of_species_tree = "gene_tree",
    plot_nltts = FALSE
  )
}

# Uncomment this to view the function demonstration
DemonstrateGetProtractedSpeciationModelAverageNltt()