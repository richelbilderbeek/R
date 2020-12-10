library(ape)
library(testit)

source("~/GitHubs/R/Phylogenies/can_drop_extinct.R")

drop_extinct <- function(newick)
{
  # Using drop.extinct
  phylogeny <- read.tree(text = newick)
  assert(can_drop_extinct(phylogeny))
  phylogeny <- drop.extinct(phylogeny)
  return (phylogeny)
}