library(ape)
library(testit)

source("~/GitHubs/R/Phylogenies/IsMonophyletic.R")

# Detect if the phylogeny has a paraphyly
HasParaphyly <- function(phylogeny) {
  return (!IsMonophyletic(phylogeny))
}

DemonstrateHasParaphyly <- function() {

  phylogeny <- read.tree(text="(A:2.0,(B:1.0,C:1.0):1.0):1.0;")
  #
  #      +------- C
  #      |
  #  +---+
  #  |   |
  # -+   +------- B
  #  |
  #  |
  #  |
  #  +----------- A
  #
  plot(phylogeny,show.node.label=TRUE,root.edge = TRUE)
  nodelabels( , col = "black", bg = "gray")
  assert(!HasParaphyly(phylogeny))

  phylogeny <- read.tree(text="(A:2.0,(B:1.0,A:1.0):1.0):1.0;")
  #
  #      +------- A
  #      |
  #  +---+
  #  |   |
  # -+   +------- B
  #  |
  #  |
  #  |
  #  +----------- A
  #
  plot(phylogeny,show.node.label=TRUE,root.edge = TRUE)
  nodelabels( , col = "black", bg = "gray")
  assert(HasParaphyly(phylogeny))
  
  for (monophyletic_newick in GetCorrectTestNewicks()) {
    monophyletic_phylogeny <- ConvertNewickToPhylogeny(monophyletic_newick)
    plot(monophyletic_phylogeny,show.node.label=TRUE,root.edge = TRUE)
    nodelabels( , col = "black", bg = "gray")
    assert(!HasParaphyly(monophyletic_phylogeny))
  }

  for (paraphyletic_newick in GetCorrectParaphyleticTestNewicks()) {
    paraphyletic_phylogeny <- ConvertNewickToPhylogeny(paraphyletic_newick)
    paraphyletic_phylogeny$tip.label <- StripSubspeciesLabelFromTipLabels(paraphyletic_phylogeny$tip.label)
    plot(paraphyletic_phylogeny,show.node.label=TRUE,root.edge = TRUE)
    nodelabels( , col = "black", bg = "gray")
    assert(HasParaphyly(paraphyletic_phylogeny))
  }
}

#DemonstrateHasParaphyly()
