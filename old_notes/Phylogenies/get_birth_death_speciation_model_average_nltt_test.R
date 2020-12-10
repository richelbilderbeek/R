source("~/GitHubs/R/Phylogenies/get_birth_death_speciation_model_average_nltt.R")

library(DDD)

source("~/GitHubs/R/Phylogenies/get_average_nltt.R")
source("~/GitHubs/R/Phylogenies/can_drop_extinct.R")

get_birth_death_speciation_model_average_nltt_test_1 <- function() {
  birth_rate <- 0.3
  death_rate <- 0.2
  crown_age <- 15
  n_trees <- 1000
  
  # Compare species tree and gene tree
  get_birth_death_speciation_model_average_nltt(
    birth_rate = birth_rate,
    death_rate = death_rate,
    crown_age = crown_age,
    n_trees = n_trees,
    col = "red",
    lwd = 4,
    cex.lab = 1.5,
    cex.axis = 1.5,
    plot_nltts = FALSE,
    main = paste(
      "Average nLTT of ",n_trees,
      " BD trees (birth rate: ",birth_rate,
      ", death rate: ",death_rate,
      ", crown age: ",crown_age,")",
      sep=""
    )
  )
}

get_birth_death_speciation_model_average_nltt_test_2 <- function() {
  birth_rate <- 0.3
  death_rate <- 0.2
  crown_age <- 15
  n_trees <- 100
  
  # Compare species tree and gene tree
  get_birth_death_speciation_model_average_nltt(
    birth_rate = birth_rate,
    death_rate = death_rate,
    crown_age = crown_age,
    n_trees = n_trees,
    col = "red",
    plot_nltts = FALSE,
    main = paste(
      "Average nLTT of ",n_trees,
      " BD trees (birth rate: ",birth_rate, " (red) and ",birth_rate * 1.1," (blue)",
      ", death rate: ",death_rate,
      ", crown age: ",crown_age,")",
      sep=""
    )
  )
  
  get_birth_death_speciation_model_average_nltt(
    birth_rate = birth_rate * 1.1,
    death_rate = death_rate,
    crown_age = crown_age,
    n_trees = n_trees,
    col = "blue",
    plot_nltts = FALSE,
    replot = TRUE #Overlay this on a current plot
  )
}

get_birth_death_speciation_model_average_nltt_test_1()
get_birth_death_speciation_model_average_nltt_test_2()