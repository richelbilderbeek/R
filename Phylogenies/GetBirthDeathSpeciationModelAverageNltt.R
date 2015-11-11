#rm(list = ls())
library(DDD)

source("~/GitHubs/R/Phylogenies/GetAverageNltt.R")
source("~/GitHubs/R/Phylogenies/CanDropExtinct.R")

GetBirthDeathSpeciationModelAverageNltt <- function(
  birth_rate,
  death_rate,
  crown_age,
  n_trees,
  ...
)
{
  # Create a full tree
  # from a Birth-Death model 
  # that stops after a certain amount of time
  
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
    ...
  )
}

DemonstrateGetBirthDeathSpeciationModelAverageNltt <- function() {
  birth_rate <- 0.3
  death_rate <- 0.2
  crown_age <- 15
  n_trees <- 100
  
  # Compare species tree and gene tree
  GetBirthDeathSpeciationModelAverageNltt(
    birth_rate = birth_rate,
    death_rate = death_rate,
    crown_age = crown_age,
    n_trees = n_trees,
    col = "red",
    plot_nltts = FALSE,
    main = paste(
      "Average nLTT of ",n_trees,
      " BD trees (birth rate: ",birth_rate, " (red) and ",birth_rate * 1.1," (blue)",
      ", death rate: ",death_rate,
      ", crown age: ",crown_age,")",
      sep=""
    )
  )
  
  GetBirthDeathSpeciationModelAverageNltt(
    birth_rate = birth_rate * 1.1,
    death_rate = death_rate,
    crown_age = crown_age,
    n_trees = n_trees,
    col = "blue",
    plot_nltts = FALSE,
    replot = TRUE #Overlay this on a current plot
  )
}

# Uncomment this to view the function demonstration
DemonstrateGetBirthDeathSpeciationModelAverageNltt()