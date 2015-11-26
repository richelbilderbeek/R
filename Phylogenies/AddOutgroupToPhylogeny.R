# Adds an outgroup to phylogeny
# See AddOutgroupToPhylogeny_test.R for a demonstration

library(ape)
library(PBD)

add_outgroup_to_phylogeny <- function(
  phylogeny,
  stem_length,
  outgroup_name="Outgroup"
) {
  n_taxa <- length(phylogeny$tip.label)
  crown_age <- dist.nodes(phylogeny)[ n_taxa + 1][1]
  phylogeny$root.edge <- stem_length
  # Add an outgroup
  # Thanks to Liam J. Revell, http://grokbase.com/t/r/r-sig-phylo/12bfqfb93a/adding-a-branch-to-a-tree
  tip <- list(
    edge=matrix(c(2,1),1,2),
    tip.label="Outgroup",
    edge.length=crown_age + stem_length,
    Nnode=1
  )
  class(tip)<-"phylo"
  # Attach to any node, in this case to the root. Note: order matters
  phylogeny<-bind.tree(tip,phylogeny)

  return (phylogeny)
}

AddOutgroupToPhylogeny <- function(
  phylogeny,
  stem_length,
  outgroup_name="Outgroup"
) {
  print("Warning: use of obsolete function 'AddOutgroupToPhylogeny', use 'add_outgroup_to_phylogeny' instead")
  return (
    add_outgroup_to_phylogeny(
      phylogeny = phylogeny,
      stem_length = stem_length,
      outgroup_name = outgroup_name
    )  
  )
}