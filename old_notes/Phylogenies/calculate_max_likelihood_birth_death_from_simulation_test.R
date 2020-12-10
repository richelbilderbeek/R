library(ape)
library(DDD)

calculate_max_likelihood_birth_death_from_simulation_test <- function() {
   
  birth_rate <- 0.5
  death_rate <- 0.1
  time <- 10
  tree_full <- sim.bdtree(
    b = birth_rate, 
    d = death_rate, 
    stop = "time",
    t = time,
    seed=42
  )
  branch_lengths <- tree_full$edge.length
  
  max_likelihood <- bd_ML(
    brts = branch_lengths, 
    cond = 1, # cond == 1 : conditioning on stem or crown age and non-extinction of the phylogeny 
    btorph = 1 # Likelihood is for (0) branching times (1) phylogeny
  )
  
  if (max_likelihood$conv == 0) { 
    print("Converged") 
  } else { 
    print("No convergence") 
  }
  print(max_likelihood)
}
calculate_max_likelihood_birth_death_from_simulation_test()