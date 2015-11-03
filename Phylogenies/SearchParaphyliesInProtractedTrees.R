rm(list=ls())

source("~/GitHubs/R/Phylogenies/GetPhylogenyCrownAge.R")
source("~/GitHubs/R/Phylogenies/SampleSpeciesTreesFromRandomProtractedTree.R")
source("~/GitHubs/R/Phylogenies/HasParaphyly.R")

library(ape)
library(ggplot2)
library(gridExtra)
library(PBD)
library(testit)

?optim

n <- 4
age <- 5
seed <- 320

set.seed(seed)
b_1  <- 0.7 #runif(1,0.0,1.0) # b_1 , the speciation-initiation rate of good species 
la_1 <- 0.2 #runif(1,0.0,1.0) # la_1, the speciation-completion rate 
b_2  <- 0.6 #runif(1,0.0,1.0) # b_2 , the speciation-initiation rate of incipient species 
mu_1 <- 1.0 #runif(1,0.0,1.0) # mu_1, the extinction rate of good species 
mu_2 <- 0.6 #runif(1,0.0,1.0) # mu_2, the extinction rate of incipient species 
pbd_sim_output <- pbd_sim(c(b_1,la_1,b_2,mu_1,mu_2),age)

# Obtain the full tree with subspecies names, e.g. 1-1-32
full_tree <- pbd_sim_output$tree

# Strip the subspecies names to generat a species tree, where
# the are multiple individuals of a single species
species_tree <- pbd_sim_output$tree
species_tree$tip.label <- StripSubspeciesLabelFromTipLabels(species_tree$tip.label)
assert(HasParaphyly(species_tree))
plot(species_tree,show.node.label=TRUE,root.edge = TRUE)
nodelabels( , col = "black", bg = "gray")

