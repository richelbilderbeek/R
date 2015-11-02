library(ape)

source("~/GitHubs/R/Phylogenies/GetCorrectTestNewicks.R")

ConvertNewickToPhylogeny <- function(newick) {
  phylogeny <- read.tree(text = newick)
  return (phylogeny)
}

DemonstrateConvertNewickToPhylogeny <- function() {
  # Convert to newick
  newicks <- GetCorrectTestNewicks()
  for (newick in newicks) {
    print(newick)
    phylogeny <- ConvertNewickToPhylogeny(newick)
    plot(phylogeny,main=newick)
  }
}

#DemonstrateConvertNewickToPhylogeny()