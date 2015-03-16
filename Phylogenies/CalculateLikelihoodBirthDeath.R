rm(list=ls())
library(ape)
library(DDD)
library(expoTree)
library(laser)
library(testit)

# CalcLikelihoodDdd calculates the likelihood of a phylogeny given a speciation rate (lambda) and extinction rate (mu),
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
#  Then CalcLikelihoodDdd must be called by 
#  CalcLikelihoodDdd(lambda = speciation_rate,mu = extinction_rate, branch_lengths = c(3,4))
#
#  What is the likelihood of this tree?
CalcLikelihoodDdd <- function(lambda,mu,branch_lengths)
{
  # Use the DDD package

  # model of time-dependence: 
  # - 0: no time dependence 
  # - 1: speciation and/or extinction rate is exponentially declining with time 
  # - 2: stepwise decline in speciation rate as in diversity-dependence without extinction 
  # - 3: decline in speciation rate following deterministic logistic equation for ddmodel = 1 
  model_of_time_dependence <- 0

  # conditioning: 
  # - 0: conditioning on stem or crown age 
  # - 1: conditioning on stem or crown age and non-extinction of the phylogeny 
  # - 2: conditioning on stem or crown age and on the total number of extant taxa (including missing species) 
  # - 3: conditioning on the total number of extant taxa (including missing species) 
  conditioning <- 1

  # Likelihood of what:
  # - 0: branching times
  # - 1: the phylogeny
  likelihood_of_what <- 1

  # Show parameters and likelihood on screen:
  # - 0: no
  # - 1: yes
  show_parameters_and_likelihood_on_screen <- 0

  # first data point is:
  # - 1: stem age
  # - 2: crown age
  first_data_point_is <- 2

  # I call the result of bd_loglik 'log_likelihood_ddd_without_combinational_term', because
  # it is not the true likelihood (true as in: when integrated over all parameters these probabilities sum up to one).
  # The true likelihood is given in Nee et al., 1994:
  #
  # Equation 20:
  #
  # lik = (N-1)!*(lambda^(N-2))*PRODUCT{i=3,N}(P(t_i,T))*((1-u_x_2)^2)*PRODUCT{i=3,N}(1 - u_x_i)
  #
  # Etienne & Haegeman, 2012, use:
  #
  # lik =        (lambda^(N-2))*PRODUCT{i=3,N}(P(t_i,T))*((1-u_x_2)^2)*PRODUCT{i=3,N}(1 - u_x_i)
  #       ^^^^^^ 
  #          
  # The bd_loglik function return the log of (the non-combinatorial) likelihood,
  # so it is transformed back afterwards
  #
  log_likelihood_ddd_without_combinational_term <- bd_loglik(
    pars1 = c(lambda,mu),
    pars2 = c(
      model_of_time_dependence,
      conditioning,
      likelihood_of_what,
      show_parameters_and_likelihood_on_screen,
      first_data_point_is
    ), 
    brts=branch_lengths,
    missnumspec = 0
  )

  likelihood_ddd_without_combinational_term  <- exp(log_likelihood_ddd_without_combinational_term )
  likelihood_ddd <- likelihood_ddd_without_combinational_term * 2
  return (likelihood_ddd)
}

# CalcLikelihoodDdd calculates the likelihood of a phylogeny given a speciation rate (lambda) and extinction rate (mu),
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
#  Then CalcLikelihoodLaser must be called by 
#  CalcLikelihoodLaser(lambda = speciation_rate,mu = extinction_rate, branch_lengths = c(3,4))
#
#  What is the likelihood of this tree?
CalcLikelihoodLaser <- function(lambda,mu,branch_lengths)
{
  # Use the LASER package
  log_likelihood_laser <- calcLHbd(x = branch_lengths, r = lambda - mu, a = mu / lambda)
  likelihood_laser <- exp(log_likelihood_laser)
  return (likelihood_laser)
}

Test <- function()
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
  # CalcLikelihoodDdd 
  {
    # See test above
    lambda <- 0.2
    mu <- 0.01
    expected_likelihood <- 0.04474506 #From calculations by hand
    expected_log_likelihood <- -3.106774 #From calculations by hand
    branch_lengths <- c(4.0,3.0)
    likelihood_ddd <- CalcLikelihoodDdd(lambda,mu,branch_lengths)

    assert("CalcLikelihoodDdd must match the one calculated by hand",abs(likelihood_ddd - expected_likelihood) < 0.0001)
    assert("CalcLikelihoodDdd must match the one calculated by hand",abs(likelihood_ddd - expected_likelihood) < 0.0001)
  }
  # CalcLikelihoodLaser
  {
    # Same test as CalcLikelihoodDdd 
    lambda <- 0.2
    mu <- 0.01
    expected_likelihood <- 0.04474506 #From calculations by hand
    expected_log_likelihood <- -3.106774 #From calculations by hand
    branch_lengths <- c(4.0,3.0)
    likelihood_laser <- CalcLikelihoodLaser(lambda,mu,branch_lengths)

    assert("CalcLikelihoodLaser must match the one calculated by hand",abs(likelihood_laser - expected_likelihood) < 0.0001)
    assert("CalcLikelihoodLaser must match the one calculated by hand",abs(likelihood_laser - expected_likelihood) < 0.0001)
  }
}

Test()


lambda <- 0.3
mu <- 0.02
branching_times_from_crown <- c(0.0,1.0)
T <- 4.0
branch_lengths <- T - branching_times_from_crown

likelihood_ddd <- CalcLikelihoodDdd(lambda,mu,branch_lengths)
likelihood_laser <- CalcLikelihoodLaser(branch_lengths = branch_lengths, lambda = lambda, mu = mu)

assert("DDD and LASER package must give the same result",abs(likelihood_ddd - likelihood_laser) < 0.0000000000001)
print(likelihood_ddd)
print(likelihood_laser)