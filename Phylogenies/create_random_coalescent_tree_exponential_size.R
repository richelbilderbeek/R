rm(list=ls())
library(ape)
library(coalescentMCMC)
library(geiger)
setwd("~")

n_sampled <- 10
phy_constant <- rcoal(n_sampled)

growth_rate <- 0.5
time <- 30

phy_exponential <- rcoal(
	n = n_sampled, 
	TIME = time, 
	growth.rate = growth_rate 
)


png(filename="CreateRandomConstantCoalescentTree.png")
plot(phy_constant,main=paste("Constant-size coalescent tree\n#sampled: ",n_sampled,sep=""))
dev.off()

png(filename="CreateRandomConstantCoalescentLtt.png")
ltt.plot(phy_constant,main=paste("LTT plot of constant-size coalescent tree\n#sampled: ",n_sampled,sep=""))
dev.off()

png(filename="CreateRandomExponentialCoalescentTree.png")
plot(phy_exponential,main=paste("Exponential-size coalescent tree\n#sampled: ",n_sampled,", growth rate:", growth_rate,sep=""))
dev.off()

png(filename="CreateRandomExponentialCoalescentLtt.png")
ltt.plot(phy_exponential,main=paste("LTT plot of exponential-size coalescent tree\n#sampled: ",n_sampled,", growth rate:", growth_rate,sep=""))
dev.off()


#For the simulations, 
# - n_sampled should be small
# - growth_rate should be small
n_sampled <- 3
growth_rate <- 0.05

png(filename="CreateRandomCoalescentTreeConstantSizeSim.png")
sim.coalescent(
	n = n_sampled, 
	TIME = time, 
	growth.rate = NULL, 
	N.0 = n_sampled * 10, 
	N.final = n_sampled * 10,
	col.lin = "grey", 
	col.coal = "black", 
	pch = NULL
)
dev.off()

png(filename="CreateRandomCoalescentTreeExponentialSizeSim.png")
sim.coalescent(
	n = n_sampled, 
	TIME = time, 
	growth.rate = growth_rate, 
	N.0 = n_sampled * 5, 
	col.lin = "grey", 
	col.coal = "black", 
	pch = NULL
)
dev.off()
