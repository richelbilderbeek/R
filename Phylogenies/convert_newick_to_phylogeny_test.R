source("~/GitHubs/R/Phylogenies/get_correct_test_newicks.R")
source("~/GitHubs/R/Phylogenies/convert_newick_to_phylogeny.R")

convert_newick_to_phylogeny_test <- function() {
  # Convert to newick
  newicks <- get_correct_test_newicks()
  for (newick in newicks) {
    print(newick)
    phylogeny <- convert_newick_to_phylogeny(newick)
    plot(phylogeny,main=newick)
  }
  print("convert_newick_to_phylogeny_test: OK")
}

convert_newick_to_phylogeny_test()