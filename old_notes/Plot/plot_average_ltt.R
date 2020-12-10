library(ape)
source("~/GitHubs/R/Phylogenies/is_phylogeny.R")
source("~/GitHubs/R/Phylogenies/get_phylogeny_crown_age.R")

plot_average_ltt <- function(
  trees_ages_pair, 
  age, 
  nmax, #maximum number of lineages
  lwd = 1, #Line width of plot
  ...
) {
  assert(class(trees_ages_pair) == "list")
  assert(is.null(names(trees_ages_pair)))
  assert(length(trees_ages_pair) == 2) #It is a pair
  assert(is_phylogeny(trees_ages_pair[[1]][[1]]))
  assert(is_phylogeny(trees_ages_pair[[1]][[2]]))
  assert(trees_ages_pair[[2]][[1]] == age)
  assert(trees_ages_pair[[2]][[2]] == age)
  
  timemax <- age
  bound <- 10^(-12)
  ltt <- LTT.plot.gen(trees_ages_pair,bound)
  lttavg <- ltt[[1]]
  plot(c(0, -timemax), c(1, nmax), type = "l", xlab = "Time before present", 
    ylab = "Number of species", log = "y", xaxt = "n", yaxt = "n", 
    lwd = lwd, col = "white")
  axis(1, at = 5 * (0:-100), labels = 5 * (0:100))
  axis(2, at = c(1, 2, 5, 10, 50, 100, 500, 1000, 5000), labels = c(1, 
    2, 5, 10, 50, 100, 500, 1000, 5000), xpd = TRUE)
  lines(lttavg[, 1], lttavg[, 2], col = "red")
}

plot_average_ltt_with_individual_lineages <- function(trees_ages_pair, ...) {
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