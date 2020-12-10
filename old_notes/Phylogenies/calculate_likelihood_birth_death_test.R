# Tests multiple ways to calculate the likelihood of a constant-rate birth-death phylogeny

source("~/GitHubs/R/Phylogenies/calculate_likelihood_birth_death.R")

calculate_likelihood_birth_death_test_1 <- function()
{
  #
  #  +----+----+----+----+
  #  |
  # -+    +----+----+----+
  #  |    |
  #  +----+
  #       |
  #       +----+----+----+
  #
  #  +----+----+----+----+ time
  #  0    1    2    3    4
  #
  #  lambda = 0.2 (speciation rate)
  #  mu = 0.01 (extinction rate)
  #
  #  What is the log(likelihood) of this tree?
  #
  #  From calculations by hand (thanks to Cesar Martinez), 
  #  following Nee et al. (1996) we found 
  #  (when conditioning on crown age and survival):
  #
  #  likelihood = 0.04474506
  #  log(likelihood) = -3.106774
  # calculate_likelihood_birth_death_using_ddd 
  {
    # See test above
    lambda <- 0.2
    mu <- 0.01
    expected_likelihood <- 0.04474506 #From calculations by hand
    expected_log_likelihood <- -3.106774 #From calculations by hand
    branch_lengths <- c(4.0,3.0)
    likelihood_ddd <- calculate_likelihood_birth_death_using_ddd(lambda,mu,branch_lengths)

    assert("calculate_likelihood_birth_death_using_ddd must match the one calculated by hand",abs(likelihood_ddd - expected_likelihood) < 0.0001)
    assert("calculate_likelihood_birth_death_using_ddd must match the one calculated by hand",abs(likelihood_ddd - expected_likelihood) < 0.0001)
  }
  # calculate_likelihood_birth_death_using_laser
  {
    # Same test as calculate_likelihood_birth_death_using_ddd 
    lambda <- 0.2
    mu <- 0.01
    expected_likelihood <- 0.04474506 #From calculations by hand
    expected_log_likelihood <- -3.106774 #From calculations by hand
    branch_lengths <- c(4.0,3.0)
    likelihood_laser <- calculate_likelihood_birth_death_using_laser(lambda,mu,branch_lengths)

    assert("calculate_likelihood_birth_death_using_laser must match the one calculated by hand",abs(likelihood_laser - expected_likelihood) < 0.0001)
    assert("calculate_likelihood_birth_death_using_laser must match the one calculated by hand",abs(likelihood_laser - expected_likelihood) < 0.0001)
  }
  print("calculate_likelihood_birth_death_test_1: OK")
}

calculate_likelihood_birth_death_test_2 <- function() {
  lambda <- 0.3
  mu <- 0.02
  branching_times_from_crown <- c(0.0,1.0)
  crown_age <- 4.0
  branch_lengths <- crown_age - branching_times_from_crown
  
  likelihood_ddd <- calculate_likelihood_birth_death_using_ddd(lambda,mu,branch_lengths)
  likelihood_laser <- calculate_likelihood_birth_death_using_laser(branch_lengths = branch_lengths, lambda = lambda, mu = mu)
  
  assert("DDD and LASER package must give the same result",abs(likelihood_ddd - likelihood_laser) < 0.0000000000001)
  print("calculate_likelihood_birth_death_test_2: OK")
}

calculate_likelihood_birth_death_test_1()
calculate_likelihood_birth_death_test_2()

