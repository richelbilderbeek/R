rm(list=ls());
library(ape);
library(coalescentMCMC);

png(filename="CreateRandomCoalescentTreeConstantSizeSim.png")
sim.coalescent(
	n = 3, 
	TIME = 30, 
	growth.rate = NULL, 
	N.0 = 20, 
	N.final = 20,
	col.lin = "grey", 
	col.coal = "black", 
	pch = NULL
)
dev.off()

phy_rcoal <- rcoal(10)
plot(phy_rcoal)

png(filename="CreateRandomCoalescentTreeConstantSize.png")
plot(phy_rcoal)
dev.off()