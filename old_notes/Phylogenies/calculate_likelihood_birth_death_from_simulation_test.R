source("~/GitHubs/R/Phylogenies/calculate_likelihood_birth_death.R")
source("~/GitHubs/R/Phylogenies/create_random_birth_death_tree.R")


calculate_likelihood_birth_death_from_simulation_test <- function() {
  phylogeny <- create_random_birth_death_tree()

  mu <- 0.2
  lambda <- 0.1

  calculate_likelihood_birth_death(
    branch_lengths = phylogeny$edge.length,
    mu = mu,
    lambda = lambda
  )
  
}


calculate_likelihood_birth_death_from_simulation_test()
