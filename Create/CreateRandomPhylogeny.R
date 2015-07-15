rm(list=ls());
library(ape);
library(geiger);

# Birth-Death model that stops after a certain time
birth_rate <- 1.0
death_rate <- 0.0
n_taxa <- 4
phy_bdtree <- sim.bdtree(birth_rate, death_rate, stop="taxa",n=n_taxa)
write.tree(phy_bdtree)
plot(phy_bdtree)