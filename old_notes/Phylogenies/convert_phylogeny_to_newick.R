library(ape)

convert_phylogeny_to_newick <- function(phylogeny) {
  newick <- write.tree(phylogeny,file="")
  return (newick)
}
