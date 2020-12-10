source("~/GitHubs/R/Phylogenies/calculate_max_likelihood_birth_death.R")

calculate_max_likelihood_birth_death_test <- function() {
  birth_rate <- 0.5
  death_rate <- 0.0
  time <- 1
  
  # Cannot result in an empty tree, thus calculate_max_likelihood_birth_death has cond == 1
  tree <- sim.bdtree(birth_rate, death_rate, stop="time",t=time,seed=42,extinct=FALSE)
  plot(
    tree,
    root.edge = TRUE # Useless, as sim.bdtree always starts with two species
  )
  ml_estimates <- calculate_max_likelihood_birth_death(tree)
  print(ml_estimates)
}

calculate_max_likelihood_birth_death_test()