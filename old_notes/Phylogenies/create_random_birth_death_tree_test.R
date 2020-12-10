
source("~/GitHubs/R/Phylogenies/create_random_birth_death_tree")

create_random_birth_death_tree_test <- function() {

  phylogeny <- create_random_birth_death_tree()
  plot(phylogeny)
}

create_random_birth_death_tree_test()