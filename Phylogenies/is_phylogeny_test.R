source("~/GitHubs/R/Phylogenies/is_phylogeny.R")

library(ape)
library(testit)

is_phylogeny_test <- function() {
  assert(is_phylogeny(rcoal(n = 5)))
  assert(!is_phylogeny(rmtree(N = 2, n = 10)))
  assert(!is_phylogeny(42))
  assert(!is_phylogeny(3.14))
  assert(!is_phylogeny("Hello"))
  
  print("is_phylogeny_test: OK")
}

is_phylogeny_test()