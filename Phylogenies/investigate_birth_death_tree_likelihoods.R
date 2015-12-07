# Assume a BD tree with a certain stem age
# What is the most likely crown age?
# Anwer: 0 years old

source("~/GitHubs/R/Phylogenies/convert_edge_lengths_to_phylogeny.R")

library(ape)
library(DDD)

investigate_birth_death_tree_likelihoods <- function() {
  # Assume a BD tree with a certain stem age
  # What is the most likely crown age?
  # Anwer: 0 years old

  stem_age <- 10
  log_likelihoods <- NULL
  crown_ages <- seq(from = stem_age,to = 0,by = -stem_age/10)
  for (crown_age in crown_ages)
  {
    edge_lengths <- c(crown_age,crown_age)
    phylogeny <- convert_edge_lengths_to_phylogeny(edge_lengths = edge_lengths, stem_length = stem_age - crown_age)
  
    temp_filename <- "temp_file.R" # To remove output from bd_ML
    sink(file=temp_filename) # To remove output from bd_ML
  
    max_likelihood_estimations <- bd_ML(
      brts = phylogeny$edge.length, 
      cond = 1, # cond == 1 : conditioning on stem or crown age and non-extinction of the phylogeny 
      btorph = 1, # Likelihood is for (0) branching times (1) phylogeny
      soc = 1, # Sets whether stem age (1) or crown age (2) should be used
      tdmodel = 0, # tdmodel == 0 : constant speciation and extinction rates 
      idparsfix = c(3,4), # The ids of the parameters that should not be optimized, id == 3 corresponds to lamda1 (parameter controlling decline in speciation rate with time) , id == 4 corresponds to mu1 (parameter controlling decline in extinction rate with time)
      parsfix = c(0.0,0.0) # The values of the parameters that should not be optimized
    )
    
    sink() # To remove output from bd_ML
  
    log_likelihood <- max_likelihood_estimations$loglik
    log_likelihoods <- c(log_likelihoods, log_likelihood)
  
    plot(
      phylogeny,
      main=paste("crown_age: ",crown_age,", log_likelihood: ",log_likelihood,sep=""),
      root.edge = TRUE
    )
    add.scale.bar()
  
  }
  
  plot(log_likelihoods, crown_ages)
}

investigate_birth_death_tree_likelihoods()