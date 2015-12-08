#rm(list = ls())
source("~/GitHubs/R/Plot/plot_average_ltt.R")
source("~/GitHubs/R/Phylogenies/is_phylogeny.R")

library(TreeSim)
library(ape)
library(testit)

plot_ltt_test <- function() {
  
  age <- 10
  n_trees <- 100
  trees <- NULL
  ages <- NULL
  
  assert(age > 0) # 
  assert(n_trees >= 2) # Otherwise some tests will fail
  
  for (i in seq(1,n_trees)) {

    #Create a tree
    tree <- sim.bdtree(
      b = 0.4, 
      d = 0.1, 
      stop = "time",
      t = age,
      extinct = FALSE
    )
    tree <- drop.fossil(tree)
    trees <- c(trees,list(tree))
    ages <- c(ages,age)
  }
  assert(length(trees) == length(ages))

  trees_ages_pair <- c(list(trees),list(ages))
  
  assert(class(trees_ages_pair) == "list")
  assert(is.null(names(trees_ages_pair)))
  assert(length(trees_ages_pair) == 2) #It is a pair
  assert(is_phylogeny(trees_ages_pair[[1]][[1]]))
  assert(is_phylogeny(trees_ages_pair[[1]][[2]]))
  assert(trees_ages_pair[[2]][[1]] == age)
  assert(trees_ages_pair[[2]][[2]] == age)

  #Plot two trees
  #plot(trees_ages_pair[[1]][[1]])
  #add.scale.bar()
  #plot(trees_ages_pair[[1]][[2]])
  #add.scale.bar()
  
#   LTT.plot(
#     trees_ages_pair, 
#     timemax = age, # Set the x axis its length, which is the timespan between now and past
#     avg = TRUE,  #Show the average LTT
#     nmax = 100  # Set the y axis its length, which is the number of species  
#   )

  plot_average_ltt(
    trees_ages_pair,
    age = age, # Set the x axis its length, which is the timespan between now and past
    nmax = 10  # Set the y axis its length, which is the number of species  
  )

  plot_average_ltt_with_individual_lineages(
    trees_ages_pair,
    nmax = 10  # Set the y axis its length, which is the number of species  
  )
}

plot_ltt_test()
