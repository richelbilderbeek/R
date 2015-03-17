rm(list=ls());
library(ape);
library(coalescentMCMC)

sim.coalescent(n = 5, TIME = 50, growth.rate = NULL, N.0 = 50, N.final = 50, col.lin = "grey", col.coal = "blue", pch = NULL)
