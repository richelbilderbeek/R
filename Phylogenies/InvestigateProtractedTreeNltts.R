rm(list=ls())

library(ape)
library(ggplot2)
library(gridExtra)
library(nLTT)
library(PBD)
library(testit)

age <- 5
seed <- 320
set.seed(seed)

differences_within <- NULL
differences_between <- NULL

for (i in seq(1,1000)) {
  b_1  <- 0.5 # b_1 , the speciation-initiation rate of good species 
  la_1 <- 0.1 # la_1, the speciation-completion rate 
  b_2  <- 0.5 # b_2 , the speciation-initiation rate of incipient species 
  mu_1 <- 0.1 # mu_1, the extinction rate of good species 
  mu_2 <- 0.1 # mu_2, the extinction rate of incipient species 

  pbd_tree_1 <- pbd_sim(c(b_1,   la_1,b_2,mu_1,mu_2),age)$tree
  pbd_tree_2 <- pbd_sim(c(b_1,   la_1,b_2,mu_1,mu_2),age)$tree
   bd_tree   <- pbd_sim(c(b_1,1000000,b_2,mu_1,mu_2),age)$tree
  
  difference_within  <- nLTTstat(pbd_tree_1,pbd_tree_2,distanceMethod = "abs")
  difference_between <- nLTTstat(pbd_tree_1, bd_tree  ,distanceMethod = "abs")
  
  differences_within  <- c(differences_within , difference_within )
  differences_between <- c(differences_between, difference_between)
}


p1 <- hist(differences_within)
p2 <- hist(differences_between)
maxx <- max(c(differences_within,differences_between))
col1 <- rgb(0,0,1,1/4)
col2 <- rgb(1,0,0,1/4)
plot( p1, col=col1, xlim=c(0,maxx), xlab = "nLTT statistic", main = "Comparison between BD and PBD model")
plot( p2, col=col2, xlim=c(0,maxx), add=T)
#legend(x = 0.4, y = 2500, legend = c("PBD to PBD","PBD to PB"), fill = c(col1,col2))
