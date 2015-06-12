rm(list=ls())
library(ape)
library(laser)
library(DDD)

birth_rate <- 0.2
death_rate <- 0.1
n_taxa <- 10
tree_full <- sim.bdtree(birth_rate, death_rate, stop="taxa",n=n_taxa,seed=43)
branch_lengths <- tree_full$edge.length

lambda <- birth_rate
mu <- death_rate


# Use the laser package
log_likelihood_laser <- calcLHbd(x = branch_lengths, r = lambda - mu, a = mu / lambda)


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
likelihood_of_what <- 0

# Show parameters and likelihood on screen:
# - 0: no
# - 1: yes
show_parameters_and_likelihood_on_screen <- 0

# first data point is:
# - 1: stem age
# - 2: crown age
first_data_point_is <- 2

log_likelihood_ddd <- bd_loglik(
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

print("Laser and DDD give the same results:")
print(log_likelihood_laser)
print(log_likelihood_ddd)
