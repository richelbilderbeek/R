#rm(list = ls())
library(ape)
library(DDD)
library(TreeSim)
source("~/GitHubs/R/Phylogenies/CanDropExtinct.R")
source("~/GitHubs/R/MyFavoritePackages/TreeSim/R/LTT.general.R")
source("~/GitHubs/R/MyFavoritePackages/TreeSim/R/LTT.average.root.R")

GetBirthDeathSpeciationModelAverageLtt <- function(
  birth_rate,
  death_rate,
  crown_age,
  n_trees,
  ...
)
{
#   birth_rate <- 0.25
#   death_rate <- 0.1
#   crown_age <- 15
#   n_trees <- 10

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
  
  print("DOES NOT WORK YET")
  stop
  ??TreeSim
  ??LTT.average.root
  for (p in phylogenies) plot(p)
  
  LTT.average.root(phylogenies)
  LTT.plot(p)
}

DemonstrateGetBirthDeathSpeciationModelAverageLtt <- function() {
  birth_rate <- 0.3
  death_rate <- 0.2
  crown_age <- 15
  n_trees <- 100

  print("DOES NOT WORK YET")
  stop()

  # Compare species tree and gene tree
  GetBirthDeathSpeciationModelAverageLtt(
    birth_rate = birth_rate,
    death_rate = death_rate,
    crown_age = crown_age,
    n_trees = n_trees
#     col = "red",
#     main = paste(
#       "Average nLTT of ",n_trees,
#       " BD trees (birth rate: ",birth_rate, " (red) and ",birth_rate * 1.1," (blue)",
#       ", death rate: ",death_rate,
#       ", crown age: ",crown_age,")",
#       sep=""
#     )
  )
  
  GetBirthDeathSpeciationModelAverageLtt(
    birth_rate = birth_rate * 1.1,
    death_rate = death_rate,
    crown_age = crown_age,
    n_trees = n_trees
#     col = "blue"
  )
}

# Uncomment this to view the function demonstration
#DemonstrateGetBirthDeathSpeciationModelAverageLtt()