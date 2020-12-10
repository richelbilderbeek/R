# Obtain the maximum likelihood estimate of a phylogeny, assuming
# it being a constant-rate birth-death tree,
# conditioned on stem or crown age and non-extinction of the phylogeny

library(DDD)

calculate_max_likelihood_birth_death <- function(phylogeny) {

  branch_lengths <- phylogeny$edge.length

  temp_filename <- tempfile()
  sink(file = temp_filename) # To remove output from bd_ML
  max_likelihood_estimations <- bd_ML(
    brts = branch_lengths, 
    cond = 1,  # cond == 1 : conditioning on stem or crown age and non-extinction of the phylogeny 
    btorph = 1,  # Likelihood is for (0) branching times (1) phylogeny
    soc = 2  # Sets whether stem age (1) or crown age (2) should be used
  )
  sink()
  file.remove(temp_filename)

  return (max_likelihood_estimations)
}