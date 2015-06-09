rm(list=ls());
library(ape);
library(geiger);

n_cols <- 2
n_rows <- 2


# # Birth-Death model that stops after a certain time
# birth_rate <- 0.2
# death_rate <- 0.1
# time_stop <- 10
# phy_bdtree <- sim.bdtree(birth_rate, death_rate, stop="time",t=time_stop)
# # phy_bdtree <- birthdeath.tree(birth_rate, death_rate, time_stop) #Deprecated, but does the same
# plot(phy_bdtree)
# svg(filename="CreateRandomBirthDeathTreeTime.svg")
# plot(phy_bdtree)
# dev.off()

# Create a full tree
# from a Birth-Death model 
# that stops after a certain number of taxa
birth_rate <- 0.2
death_rate <- 0.1
n_taxa <- 10
tree_full <- sim.bdtree(birth_rate, death_rate, stop="taxa",n=n_taxa)


# Create the reconstructed tree, 
# by dropping the extinct lineages
tree_reconstructed <- drop.extinct(tree_full) # Drop extinct


# Plotting
# Use PNG because that shows the labels

png(filename="CreateRandomBirthDeathTreeFull.png")
plot(tree_full)
dev.off()

png(filename="CreateRandomBirthDeathTreeReconstructed.png")
plot(tree_reconstructed)
dev.off()

# Create an LTT of the full tree
png(filename="CreateRandomBirthDeathTreeFullLtt.png")
ltt.plot(tree_full)
dev.off()

# Create an LTT of the reconstructed tree
png(filename="CreateRandomBirthDeathTreeReconstructedLtt.png")
ltt.plot(tree_reconstructed)
dev.off()

