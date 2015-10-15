rm(list=ls());
library(ape);
library(geiger);

# Create a full tree
# from a Birth-Death model 
# that stops after a certain number of taxa
birth_rate <- 0.2
death_rate <- 0.0
n_taxa <- 10
tree_full <- sim.bdtree(birth_rate, death_rate, stop="taxa",n=n_taxa)

# Create the reconstructed tree, 
# by dropping the extinct lineages
tree_reconstructed <- drop.extinct(tree_full) # Drop extinct


# Plotting
# Use PNG because that shows the labels

png(filename="CreateRandomBirthTreeFull.png")
plot(tree_full)
dev.off()

png(filename="CreateRandomBirthTreeReconstructed.png")
plot(tree_reconstructed)
dev.off()

# Create an LTT of the full tree
png(filename="CreateRandomBirthTreeFullLtt.png")
ltt.plot(tree_full)
dev.off()

# Create an LTT of the reconstructed tree
png(filename="CreateRandomBirthTreeReconstructedLtt.png")
ltt.plot(tree_reconstructed)
dev.off()

