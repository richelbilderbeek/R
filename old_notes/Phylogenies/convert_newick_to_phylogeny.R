library(ape)

convert_newick_to_phylogeny <- function(newick) {
  phylogeny <- read.tree(text = newick)
  return (phylogeny)
}