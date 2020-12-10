source("~/GitHubs/R/Phylogenies/convert_phylogeny_to_newick.R")

library(testit)

convert_phylogeny_to_newick_test <- function() {
  # Create a random tree
  phylogeny <- rcoal(10)
  plot(phylogeny)

  # Convert to newick
  newick <- write.tree(phylogeny,file="")
  print(newick)
}

convert_phylogeny_to_newick_test()

