source("~/GitHubs/R/Phylogenies/is_monophyletic_group.R")

library(testit)

is_monophyletic_group_test <- function() {

  phylogeny <- read.tree(text="(A:2.0,(B:1.0,C:1.0):1.0):1.0;")
  #
  #      +------- C
  #      |
  #  +---+
  #  |   |
  # -+   +------- B
  #  |
  #  |
  #  |
  #  +----------- A
  #
  plot(phylogeny)
  assert( is_monophyletic_group(phylogeny,groups = c("B","C")))
  assert(!is_monophyletic_group(phylogeny,groups = c("A","C")))
  assert( is_monophyletic_group(phylogeny,groups = c("A","B","C")))
}

is_monophyletic_group_test()
