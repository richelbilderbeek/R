rm(list=ls())
library(ape)
library(DDD)

birth_rate <- 0.5
death_rate <- 0.0
n_taxa <- 10000
tree_full <- sim.bdtree(birth_rate, death_rate, stop="taxa",n=n_taxa,seed=42)
branch_lengths <- tree_full$edge.length

max_likelihood <- bd_ML(
  brts = branch_lengths, 
  cond = 1, # cond == 1 : conditioning on stem or crown age and non-extinction of the phylogeny 
  btorph = 1 # Likelihood is for (0) branching times (1) phylogeny
)

if (conv == 0) { print("Converged") } else { print("No convergence") }
print(max_likelihood)
