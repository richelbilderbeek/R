library(ape)
source("~/GitHubs/R/Phylogenies/is_phylogeny.R")

plot_average_ltt <- function(trees_ages_pair, ...) {
  assert(class(trees_ages_pair) == "list")
  assert(is.null(names(trees_ages_pair)))
  assert(length(trees_ages_pair) == 2) #It is a pair
  assert(is_phylogeny(trees_ages_pair[[1]][[1]]))
  assert(is_phylogeny(trees_ages_pair[[1]][[2]]))
  #assert(trees_ages_pair[[2]][[1]] == age)
  #assert(trees_ages_pair[[2]][[2]] == age)

  LTT.plot(
    trees_ages_pair, 
    avg = TRUE,  #Show the average LTT
    ...
    #timemax = age, # Set the x axis its length, which is the timespan between now and past
    #nmax = 100  # Set the y axis its length, which is the number of species
  )


}