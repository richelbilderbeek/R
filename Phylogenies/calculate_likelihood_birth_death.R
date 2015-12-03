# Calculate the likelihood of a constant-rate birth-death phylogeny

source("~/GitHubs/R/Phylogenies/calculate_likelihood_birth_death_using_ddd.R")
source("~/GitHubs/R/Phylogenies/calculate_likelihood_birth_death_using_laser.R")

# calculate_likelihood_birth_death calculates the likelihood of a phylogeny given a speciation rate (lambda) and extinction rate (mu),
# when conditioned by crown age and survival of the lineages
#
# Suppose the input is:
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
#  speciation_rate <- 0.2
#  extinction_rate <- 0.01 
#
#  Then calculate_likelihood_birth_death_using_ddd must be called by 
#  calculate_likelihood_birth_death_using_ddd(lambda = speciation_rate,mu = extinction_rate, branch_lengths = c(3,4))
#
#  What is the likelihood of this tree?
calculate_likelihood_birth_death <- function(lambda, mu, branch_lengths, test = FALSE)
{
  likelihood_ddd <- calculate_likelihood_birth_death_using_ddd(lambda = lambda, mu = mu, branch_lengths = branch_lengths)
  if(test) { 
    likelihood_laser <- calculate_likelihood_birth_death_using_laser(lambda = lambda, mu = mu, branch_lengths = branch_lengths)
    assert(likelihood_ddd == likelihood_laser)
  }
  return (likelihood_ddd) 
}