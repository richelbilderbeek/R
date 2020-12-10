# Adds an outgroup to phylogeny
# See add_outgroup_to_phylogeny_test.R for a demonstration

library(ape)
library(PBD)

add_outgroup_to_phylogeny <- function(
  phylogeny,
  stem_length,
  outgroup_name = "Outgroup"
) {
  assert(class(phylogeny) == "phylo")

  n_taxa <- length(phylogeny$tip.label)
  
  crown_age <- dist.nodes(phylogeny)[ n_taxa + 1][1]
  phylogeny$root.edge <- stem_length
  # Add an outgroup
  # Thanks to Liam J. Revell, 
  # http://grokbase.com/t/r/r-sig-phylo/12bfqfb93a/adding-a-branch-to-a-tree
  tip <- list(
    edge = matrix(c(2,1),1,2),
    tip.label = "Outgroup",
    edge.length = crown_age + stem_length,
    Nnode = 1
  )
  class(tip) <- "phylo"
  # Attach to any node, in this case to the root. Note: order matters
  phylogeny <- bind.tree(tip, phylogeny)

  assert(class(phylogeny) == "phylo")
  
  return (phylogeny)
}