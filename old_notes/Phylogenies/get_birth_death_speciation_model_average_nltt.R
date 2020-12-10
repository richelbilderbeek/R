library(DDD)

source("~/GitHubs/R/Phylogenies/get_average_nltt.R")
source("~/GitHubs/R/Phylogenies/can_drop_extinct.R")

get_birth_death_speciation_model_average_nltt <- function(
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
    if (!can_drop_extinct(phylogeny_complete)) {
     next
    }
    phylogeny_reconstructed <- drop.extinct(phylogeny_complete)
    
    phylogenies <- c(phylogenies,list(phylogeny_reconstructed))
  }
  
  get_average_nltt(
    phylogenies,
    ...
  )
}