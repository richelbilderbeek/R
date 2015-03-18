rm(list=ls());
library(ape);
library(coalescentMCMC)


svg(filename="CreateEmersonEtAl2001.svg")
sim.coalescent(n = 3, TIME = 50, growth.rate = NULL, N.0 = 10, N.final = 10, col.lin = "grey", col.coal = "blue", pch = NULL)
dev.off()
