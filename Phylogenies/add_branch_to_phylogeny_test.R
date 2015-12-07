library(ape)
library(geiger)

add_branch_to_phylogeny_test <- function() {

  # Note: to add a root to a tree, see add_root_to_phylogeny.R
  
  # Create a phylogeny to work on
  phylogeny <- read.tree(text = "(t2:2.286187509,(t5:0.3145724408,((t1:0.08394513325,t4:0.08394513325):0.1558558349,t3:0.2398009682):0.07477147256):1.971615069);")
  plot(phylogeny)
  
  # Add a branch
  # Thanks to Liam J. Revell, http://grokbase.com/t/r/r-sig-phylo/12bfqfb93a/adding-a-branch-to-a-tree
  tip <- list(
    edge = matrix(c(2,1),1,2),
    tip.label = "NEW",
    edge.length = 0.1,
    Nnode = 1
  )
  class(tip)<-"phylo"

  # Attach to any node, in this case 5 is the third branching node
  new_phylogeny <- bind.tree(phylogeny,tip,where=5)
  plot(new_phylogeny)
  
  
  # Plot both phylogenies
  n_cols <- 1
  n_rows <- 2
  par(mfrow = c(n_rows,n_cols))
  plot(phylogeny)
  plot(new_phylogeny)
  par(mfrow = c(1,1))
}

add_branch_to_phylogeny_test()