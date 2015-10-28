rm(list=ls())

source("~/GitHubs/R/Phylogenies/GetPhylogenyCrownAge.R")

library(ape) # As suggested in PBD issue #3

# Load all PBD functions
pbd_path <- "~/GitHubs/PBD/PBD/R"
for (file in list.files(path = pbd_path)) {
  source(paste(pbd_path,"/",file,sep=""));
}

SampleSpeciesTreesFromRandomProtractedTree <- function(
  n   , #How many?
  b_1 , #the speciation-initiation rate of good species 
  la_1, #the speciation-completion rate 
  b_2 , #the speciation-initiation rate of incipient species 
  mu_1, #the extinction rate of good species 
  mu_2, #the extinction rate of incipient species 
  age
) {
  random_protracted_tree <- pbd_sim(c(b_1,la_1,b_2,mu_1,mu_2),age)
  species_trees <- SampleSpeciesTreesFromPbdSimOutput(
    n,
    random_protracted_tree
  )
  return (species_trees)
}

# Does not use pbd_sim()$stree, but generates these like PBD does
SampleSpeciesTreesFromPbdSimOutput <- function(
  n, #How many?
  result
) {
  crown_age <- GetPhylogenyCrownAge(result$tree)
  absL = result$L0
  absL[,2] = abs(result$L0[,2])
  
  species_trees <- NULL
  for (i in c(1:n)) {
    sL = sampletree(absL,crown_age)
    species_tree = as.phylo(read.tree(text = detphy(sL,crown_age)))
    species_trees <- c(species_trees,list(species_tree))
  }
  return (species_trees)
}

PlotSpeciesTrees <- function(species_trees,filename) {
  png(filename=filename,width = 480, height = 480 * length(species_trees))
  n_cols <- 1
  n_rows <- length(species_trees)
  par(mfrow=c(n_rows,n_cols))

  for (species_tree in species_trees) {
    plot(species_tree,cex = 2)
  }
  dev.off()
}


DemonstrateSampleSpeciesTrees <- function() {

  n <- 10
  age <- 10
  seed <- 320
  
  set.seed(seed)
  b_1  <- 0.7 #runif(1,0.0,1.0) # b_1 , the speciation-initiation rate of good species 
  la_1 <- 0.2 #runif(1,0.0,1.0) # la_1, the speciation-completion rate 
  b_2  <- 0.6 #runif(1,0.0,1.0) # b_2 , the speciation-initiation rate of incipient species 
  mu_1 <- 1.0 #runif(1,0.0,1.0) # mu_1, the extinction rate of good species 
  mu_2 <- 0.6 #runif(1,0.0,1.0) # mu_2, the extinction rate of incipient species 
  pbd_sim_output <- pbd_sim(c(b_1,la_1,b_2,mu_1,mu_2),age)
  
  species_trees <- SampleSpeciesTreesFromPbdSimOutput(n=n,pbd_sim_output)
  PlotSpeciesTrees(species_trees,filename="~/1.png")

  set.seed(seed)
  species_trees <- SampleSpeciesTreesFromRandomProtractedTree(
    n   , #How many?
    b_1 , #the speciation-initiation rate of good species 
    la_1, #the speciation-completion rate 
    b_2 , #the speciation-initiation rate of incipient species 
    mu_1, #the extinction rate of good species 
    mu_2, #the extinction rate of incipient species 
    age
  )
  PlotSpeciesTrees(species_trees,filename="~/2.png")
}


# Uncomment this to view the function demonstration
#DemonstrateSampleSpeciesTrees()