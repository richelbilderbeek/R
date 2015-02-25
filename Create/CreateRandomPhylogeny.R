rm(list=ls());
library(ape);
library(geiger);

phy_rcoal <- rcoal(10)
plot(phy_rcoal)
svg(filename="CreateRandomPhylogenyRcoal.svg")
plot(phy_rcoal)
dev.off()

phy_rtree <- rtree(10)
svg(filename="CreateRandomPhylogenyRtree.svg")
plot(phy_rtree)
dev.off()

# Birth-Death model that stops after a certain time
birth_rate <- 0.2
death_rate <- 0.1
time_stop <- 10
phy_bdtree <- sim.bdtree(birth_rate, death_rate, stop="time",t=time_stop)
# phy_bdtree <- birthdeath.tree(birth_rate, death_rate, time_stop) #Deprecated, but does the same
plot(phy_bdtree)
svg(filename="CreateRandomPhylogenyBirthDeathTreeTime.svg")
plot(phy_bdtree)
dev.off()

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




