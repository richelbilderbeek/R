library(testit)

source("~/GitHubs/R/Phylogenies/convert_newick_to_phylogeny.R")

convert_edge_lengths_to_phylogeny <- function(edge_lengths, stem_length = 0) {
  assert(length(edge_lengths) == 2)
  newick <- paste("(A:",edge_lengths[1],",B:",edge_lengths[2],"):",stem_length,";",sep="")
  phylogeny <- convert_newick_to_phylogeny(newick)
  return (phylogeny)
}