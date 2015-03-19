rm(list=ls());
library(ape);
library(coalescentMCMC)

svg(filename="CreateFisherWrightExample.svg")
sim.coalescent(n = 3, TIME = 20, growth.rate = NULL, N.0 = 10, N.final = 10, col.lin = "grey", col.coal = "blue", pch = 21)
dev.off()


svg(filename="CreateEmersonEtAl2001.svg")
sim.coalescent(n = 5, TIME = 50, growth.rate = NULL, N.0 = 50, N.final = 50, col.lin = "grey", col.coal = "blue", pch = NULL)
dev.off()

