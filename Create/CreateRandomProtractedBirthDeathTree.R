rm(list=ls());
library(ape);
library(geiger);
install.packages("phytools")
library(phytools);

system("R CMD check '~/GitHubs/Wip/RampalEtienne/R/PBD'") #Works

?system
system("R CMD INSTALL -l ~/GitHubs/Wip/RampalEtienne/R/PBD_1.1.tar.gz PBD")
system("R CMD INSTALL -l ~/GitHubs/Wip/RampalEtienne/R/PBD_1.1.zip PBD")
system("R CMD INSTALL -l ~/GitHubs/Wip/RampalEtienne/R/PBD PBD")
system("R CMD INSTALL -l ~/GitHubs/Wip/RampalEtienne/R/PBD_1.1.tar.gz")
system("R CMD INSTALL -l ~/GitHubs/Wip/RampalEtienne/R/PBD_1.1.zip")
system("R CMD INSTALL PBD -l ~/GitHubs/Wip/RampalEtienne/R/PBD_1.1.tar.gz")
system("R CMD INSTALL PBD -l ~/GitHubs/Wip/RampalEtienne/R/PBD_1.1.zip")
system("R CMD INSTALL PBD -l ~/GitHubs/Wip/RampalEtienne/R/PBD")


library("PBD",lib.loc = "~/GitHubs/Wip/RampalEtienne")

n_cols <- 2
n_rows <- 2


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

