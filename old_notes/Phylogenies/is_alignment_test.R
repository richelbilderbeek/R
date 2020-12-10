source("~/GitHubs/R/Phylogenies/create_random_alignment.R")
source("~/GitHubs/R/Phylogenies/is_alignment.R")

library(ape)
library(testit)

is_alignment_test <- function() {
  
  alignment_a <- create_random_alignment(n_taxa = 5, sequence_length = 10)
  alignment_b <- create_random_alignment(n_taxa = 2, sequence_length = 1)
  
  assert(is_alignment(alignment_a))
  assert(is_alignment(alignment_b))
  #assert(!is_alignment(c(alignment_a,alignment_a))) # DNAbin forbids this
  #assert(!is_alignment(c(alignment_b,alignment_b))) # DNAbin forbids this
  assert(!is_alignment(list(alignment_a,alignment_a)))
  assert(!is_alignment(rmtree(N = 2, n = 10)))
  assert(!is_alignment(42))
  assert(!is_alignment(3.14))
  assert(!is_alignment("Hello"))
  
  print("is_alignment_test: OK")
}

is_alignment_test()
