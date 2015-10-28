# rm(list=ls());
# install.packages("phytools")
# The tarball must be extracted to check if the install will succeed
# system("R CMD check ~/GitHubs/Wip/RampalEtienne/R/PBD")
# system("R CMD INSTALL ~/GitHubs/Wip/RampalEtienne/R/PBD_1.1.tar.gz")

library(ape);
library(geiger);
library(phytools);
library(PBD);


n_cols <- 2
n_rows <- 2

# Simulate a tree from a protracted birth-death model 
# that stops after a certain length of time

# Want to read the documentation?
?PBD
?pbd_sim

b_1  <- 0.2 #the speciation-initiation rate of good species
la_1 <- 1.0 #the speciation-completion rate 
b_2  <- 0.2 # the speciation-initiation rate of incipient species 
mu_1 <- 0.1 # the extinction rate of good species 
mu_2 <- 0.1 # the extinction rate of incipient species 
age <- 15
tree_full <-pbd_sim(c(b_1,la_1,b_2,mu_1,mu_2),age,soc=2,plot=1)
par(mfrow=c(1,1)) # Bug fix, already fixed in next release

pbd_sim
tree_full
detphy
# You can view with names what you can zoom in on
names(tree_full)

class(tree_full$stree)
sampletree()


# Or, from the documentation:
# tree is the tree of extant species in phylo format 
# stree is a tree with one sample per species in phylo format 
# L is a matrix of all events in the simulation where 
# - the first column is the incipient-level label of a species 
# - the second column is the incipient-level label of the parent of the species 
# - the third column is the time at which a species is born as incipient species
# - the fourth column is the time of speciation-completion of the species 
# If the fourth element equals -1, then the species is still incipient. - the fifth column is the time of extinction of the species 
# If the fifth element equals -1, then the species is still extant. - The sixth column is the species-level label of the species 
# sL is a matrix like L but for stree 
# igtree.extinct is the tree in simmap format with incipient and good flags and including extinct species 
# igtree.extant is the tree in simmap format with incipient and good flags without extinct species 
# recontree is the reconstructed tree in phylo format, reconstructed using the approximation in Lambert et al. 2014 
# reconL is the matrix corresponding to recontree 
# L0 is a matrix where the crown age is at 0; for internal use only 
plot(tree_full$tree,main="Extant species")
plot(tree_full$stree,main="One sample per extant species")


