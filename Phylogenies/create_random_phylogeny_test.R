source("~/GitHubs/R/Phylogenies/create_random_phylogeny.R")

# One of the many ways to create a random phylogeny
create_random_phylogeny_test <- function(n_taxa)
{
  # Create a random tree with 10 taxa
  phylogeny <- create_random_phylogeny(n_taxa = 10)
  
  assert(class(phylogeny) == "phylo")
  assert(length(phylogeny) == 4) #phylo classes have length 4
  assert(names(phylogeny) == c("edge", "edge.length", "tip.label", "Nnode"))
  
  # Plot that tree
  plot(phylogeny, main = "create_random_phylogeny")
  
  # Display the tree in Newick format
  newick <- write.tree(phylogeny)
}

create_random_phylogeny_test()
