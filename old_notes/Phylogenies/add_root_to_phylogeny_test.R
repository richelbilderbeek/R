library(ape)
library(geiger)
library(testit)

add_root_to_phylogeny_test <- function() {

  # Create a phylogeny to work on
  phylogeny <- read.tree(text = "(a,b,c);")
  assert(!is.rooted(phylogeny))
  plot(phylogeny)
  
  #
  new_phylogeny <- root(phylogeny, 1, r = TRUE)
  assert(is.rooted(new_phylogeny))
  plot(new_phylogeny)
  
  # Plot both phylogenies
  n_cols <- 1
  n_rows <- 2
  par(mfrow=c(n_rows,n_cols))
  plot(phylogeny)
  plot(new_phylogeny)
  par(mfrow=c(1,1))
  
}

add_root_to_phylogeny_test()
