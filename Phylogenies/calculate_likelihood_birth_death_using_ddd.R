# Calculate the likelihood of a constant-rate birth-death phylogeny

library(DDD)

# calculate_likelihood_birth_death_using_ddd calculates the likelihood of a phylogeny given a speciation rate (lambda) and extinction rate (mu),
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
calculate_likelihood_birth_death_using_ddd <- function(lambda,mu,branch_lengths)
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