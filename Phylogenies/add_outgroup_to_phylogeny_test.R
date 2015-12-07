source("~/GitHubs/R/Phylogenies/add_outgroup_to_phylogeny.R")

lint_add_outgroup_to_phylogeny <- function() {
  library(lint)
  lint(file = "~/GitHubs/R/Phylogenies/add_outgroup_to_phylogeny.R")
}

add_outgroup_to_phylogeny_test <- function()
{
  
  # Using the function
  phylogeny <- read.tree(text = "(t2:2.286187509,(t5:0.3145724408,((t1:0.08394513325,t4:0.08394513325):0.1558558349,t3:0.2398009682):0.07477147256):1.971615069);")
  n_taxa <- length(phylogeny$tip.label)
  plot(phylogeny)

  assert(class(phylogeny)=="phylo")
  
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

lint_add_outgroup_to_phylogeny()
add_outgroup_to_phylogeny_test()
