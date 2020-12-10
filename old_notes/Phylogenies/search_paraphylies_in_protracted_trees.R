source("~/GitHubs/R/Phylogenies/get_phylogeny_crown_age.R")
source("~/GitHubs/R/Phylogenies/sample_species_trees_from_random_protracted_tree.R")
source("~/GitHubs/R/Phylogenies/has_paraphyly.R")

library(ape)
library(ggplot2)
library(gridExtra)
library(PBD)
library(testit)

search_paraphylies_in_protracted_trees <- function() {

  n <- 4
  age <- 5
  seed <- 320
  set.seed(seed)
  b_1  <- 0.7 # b_1 , the speciation-initiation rate of good species 
  la_1 <- 0.2 # la_1, the speciation-completion rate 
  b_2  <- 0.6 # b_2 , the speciation-initiation rate of incipient species 
  mu_1 <- 1.0 # mu_1, the extinction rate of good species 
  mu_2 <- 0.6 # mu_2, the extinction rate of incipient species 
  pbd_sim_output <- pbd_sim(c(b_1,la_1,b_2,mu_1,mu_2),age)

  # Obtain the full tree with subspecies names, e.g. 1-1-32
  full_tree <- pbd_sim_output$tree

  # Strip the subspecies names to generat a species tree, where
  # the are multiple individuals of a single species
  species_tree <- pbd_sim_output$tree
  species_tree$tip.label <- strip_subspecies_label_from_tip_labels(species_tree$tip.label)
  assert(has_paraphyly(species_tree))
  plot(species_tree,show.node.label=TRUE,root.edge = TRUE)
  nodelabels( , col = "black", bg = "gray")
}