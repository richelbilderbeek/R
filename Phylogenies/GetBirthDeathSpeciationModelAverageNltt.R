#rm(list = ls())
library(DDD)

source("~/GitHubs/R/Phylogenies/GetAverageNltt.R")
source("~/GitHubs/R/Phylogenies/CanDropExtinct.R")

GetBirthDeathSpeciationModelAverageNltt <- function()
{
  # Create a full tree
  # from a Birth-Death model 
  # that stops after a certain amount of time
  birth_rate <- 0.3
  death_rate <- 0.1
  crown_age <- 15
  n_trees <- 100
  
  # Now random trees
  phylogenies <- NULL
  for (i in seq(1,n_trees)) {
    phylogeny_complete <- sim.bdtree(
      b = birth_rate, 
      d = death_rate, 
      stop="time",
      t=crown_age,
      n = 1
    )

    # Drop the fossils if possible
    if (!CanDropExtinct(phylogeny_complete)) {
     next
    }
    phylogeny_reconstructed <- drop.extinct(phylogeny_complete)
    
    phylogenies <- c(phylogenies,list(phylogeny_reconstructed))
  }
  
  GetAverageNltt(
    phylogenies,
    dt = 0.001,
    plot_nltts = TRUE,
    main = paste(
      "Average nLTT of ",n_trees,
      " BD trees (birth rate: ",birth_rate,
      ", death rate: ",death_rate,
      ", crown age: ",crown_age,")"
      ,sep=""
    )
  )
}

# Uncomment this to view the function demonstration
GetBirthDeathSpeciationModelAverageNltt()
