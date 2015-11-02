library(ape)
library(DDD)

# Conditioned on stem or crown age and non-extinction of the phylogeny
CalculateMaxLikelihoodBirthDeath <- function(phylogeny) {

  branch_lengths <- phylogeny$edge.length

  temp_filename <- "temp_file.R"
  sink(file=temp_filename) # To remove output from bd_ML
  max_likelihood_estimations <- bd_ML(
    brts = branch_lengths, 
    cond = 1, # cond == 1 : conditioning on stem or crown age and non-extinction of the phylogeny 
    btorph = 1, # Likelihood is for (0) branching times (1) phylogeny
    soc = 2 # Sets whether stem age (1) or crown age (2) should be used
  )
  sink()
  file.remove(temp_filename)

  return (max_likelihood_estimations)
}

DemonstrateCalculateMaxLikelihoodBirthDeath <- function() {
  birth_rate <- 0.5
  death_rate <- 0.0
  time <- 1
  
  # Cannot result in an empty tree, thus CalculateMaxLikelihoodBirthDeath has cond == 1
  tree <- sim.bdtree(birth_rate, death_rate, stop="time",t=time,seed=42,extinct=FALSE)
  plot(
    tree,
    root.edge = TRUE # Useless, as sim.bdtree always starts with two species
  )
  ml_estimates <- CalculateMaxLikelihoodBirthDeath(tree)
  print(ml_estimates)
}

DemonstrateCalculateMaxLikelihoodBirthDeath()