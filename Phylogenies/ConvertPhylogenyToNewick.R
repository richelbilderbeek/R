library(ape)
library(testit)

ConvertPhylogenyToNewick <- function(phylogeny) {
  newick <- write.tree(phylogeny,file="")
  return (newick)
  
}

DemonstrateConvertPhylogenyToNewick <- function() {
  # Create a random tree
  phylogeny <- rcoal(10)
  plot(phylogeny)

  # Convert to newick
  newick <- write.tree(phylogeny,file="")
  print(newick)
}

#DemonstrateConvertPhylogenyToNewick()

