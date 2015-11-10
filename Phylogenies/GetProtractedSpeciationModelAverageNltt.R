#rm(list = ls())
library(PBD)

source("~/GitHubs/R/Phylogenies/GetAverageNltt.R")

GetProtractedSpecationModelAverageNltt <- function()
{
  b_1  <- 0.2 #the speciation-initiation rate of good species
  la_1 <- 0.01 #the speciation-completion rate 
  b_2  <- 0.2 # the speciation-initiation rate of incipient species 
  mu_1 <- 0.1 # the extinction rate of good species 
  mu_2 <- 0.1 # the extinction rate of incipient species 
  crown_age <- 15
  n_trees <- 1000
  
  # Now random trees
  phylogenies <- NULL
  for (i in seq(1,n_trees)) {
    trees_full <-pbd_sim(c(b_1,la_1,b_2,mu_1,mu_2),crown_age,soc=2,plot=0)
    phylogeny <- trees_full$tree
    phylogenies <- c(phylogenies,list(phylogeny))
  }
  
  GetAverageNltt(
    phylogenies,
    dt = 0.001,
    plot_nltts = TRUE,
    main = paste(
      "Average LTT of ",n_trees,
      " PBD trees (b_1: ",b_1,
      ", b_2: ",b_2,
      ", la_1: ",la_1,
      ", mu_1: ",mu_1,
      ", mu_2: ",mu_2,
      ", crown age: ",crown_age,")"
      ,sep=""
    )
  )
}

# Uncomment this to view the function demonstration
GetProtractedSpecationModelAverageNltt()
