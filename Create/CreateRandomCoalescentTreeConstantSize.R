rm(list=ls());
library(ape);
library(coalescentMCMC);
library(coalesceR)
?rcoal
phylogeny <- rcoal(n = 10)
plot(phylogeny)
vignette("CoalescentModels")
?dcoal
