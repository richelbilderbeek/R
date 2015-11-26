library(ape)
library(PBD)

# Adds an outgroup to phylogeny
# From www.github.com/richelbilderbeek/R
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

demonstrate_add_outgroup_to_phylogeny <- function()
{
  # Using the function
  phylogeny <- read.tree(text = "(t2:2.286187509,(t5:0.3145724408,((t1:0.08394513325,t4:0.08394513325):0.1558558349,t3:0.2398009682):0.07477147256):1.971615069);")
  n_taxa <- length(phylogeny$tip.label)
  plot(phylogeny)

  new_phylogeny_1 <- add_outgroup_to_phylogeny(phylogeny,stem_length = 0.0)
  plot(new_phylogeny_1)

  # crown_age gets added to the tree
  crown_age <- dist.nodes(phylogeny)[ n_taxa + 1][1]
  new_phylogeny_2 <- add_outgroup_to_phylogeny(phylogeny,stem_length = crown_age)
  plot(new_phylogeny_2)

  # Plot the two trees
  n_cols <- 1
  n_rows <- 3
  par(mfrow=c(n_rows,n_cols))
  plot(phylogeny,main = "add_outgroup_to_phylogeny")
  add.scale.bar(x=0,y=5)
  plot(new_phylogeny_1)
  add.scale.bar(x=0,y=6)
  plot(new_phylogeny_2)
  add.scale.bar(x=0,y=6)
  par(mfrow=c(1,1))
}

# Uncomment this to view the function demonstration
#demonstrate_add_outgroup_to_phylogeny()
