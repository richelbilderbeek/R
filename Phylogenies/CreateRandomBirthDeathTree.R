rm(list=ls());
library(ape);
library(geiger);

# Birth-Death model that stops after a certain number of taxa
birth_rate <- 0.2
death_rate <- 0.1
n_taxa <- 10
phy_bdtree <- sim.bdtree(birth_rate, death_rate, stop="taxa",n=n_taxa)
# phy_bdtree <- birthdeath.tree(birth_rate, death_rate, time_stop) #Deprecated, but does the same
plot(phy_bdtree)
svg(filename="CreateRandomPhylogenyBirthDeathTreeTaxa.svg")
plot(phy_bdtree)
dev.off()

# Birth-Death model that stops after a certain number of taxa, with a coelescent species tree
birth_rate <- 0.2
death_rate <- 0.1
n_taxa <- 10
phy_bdtree <- sim.bdtree(birth_rate, death_rate, stop="taxa",n=n_taxa)
phy_bdtree <- drop.extinct(phy_bdtree) # Drop extinct
plot(phy_bdtree)
svg(filename="CreateRandomPhylogenyBirthDeathTreeTaxaCoalescent.svg")
plot(phy_bdtree)
dev.off()




