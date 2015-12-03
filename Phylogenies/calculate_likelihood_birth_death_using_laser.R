# Calculate the likelihood of a constant-rate birth-death phylogeny

library(laser)

# calculate_likelihood_birth_death_using_laser calculates the likelihood of a phylogeny given a speciation rate (lambda) and extinction rate (mu),
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
#  Then calculate_likelihood_birth_death_using_laser must be called by 
#  calculate_likelihood_birth_death_using_laser(lambda = speciation_rate,mu = extinction_rate, branch_lengths = c(3,4))
#
#  What is the likelihood of this tree?
calculate_likelihood_birth_death_using_laser <- function(lambda,mu,branch_lengths)
{
  # Use the LASER package
  log_likelihood_laser <- calcLHbd(x = branch_lengths, r = lambda - mu, a = mu / lambda)
  likelihood_laser <- exp(log_likelihood_laser)
  return (likelihood_laser)
}