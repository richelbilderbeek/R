library(ape)
library(testit)
source("~/GitHubs/R/Phylogenies/is_monophyletic.R")
source("~/GitHubs/R/Phylogenies/convert_newick_to_phylogeny.R")


source("~/GitHubs/R/Phylogenies/GetCorrectTestNewicks.R")
source("~/GitHubs/R/Phylogenies/GetCorrectParaphyleticTestNewicks.R")
source("~/GitHubs/R/Phylogenies/StripSubspeciesLabelFromTipLabels.R")

library(testit)

source("~/GitHubs/R/Phylogenies/ConvertNewickToPhylogeny.R")
source("~/GitHubs/R/Phylogenies/GetCorrectTestNewicks.R")
source("~/GitHubs/R/Phylogenies/GetCorrectParaphyleticTestNewicks.R")
source("~/GitHubs/R/Phylogenies/StripSubspeciesLabelFromTipLabels.R")
source("~/GitHubs/R/Phylogenies/is_monophyleticGroup.R")

is_monophyletic_test <- function() {

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
  assert(is_monophyletic(phylogeny))

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
  assert(!is_monophyletic(phylogeny))
  
  for (monophyletic_newick in GetCorrectTestNewicks()) {
    monophyletic_phylogeny <- ConvertNewickToPhylogeny(monophyletic_newick)
    plot(monophyletic_phylogeny,show.node.label=TRUE,root.edge = TRUE)
    nodelabels( , col = "black", bg = "gray")
    assert(is_monophyletic(monophyletic_phylogeny))
  }

  for (paraphyletic_newick in GetCorrectParaphyleticTestNewicks()) {
    paraphyletic_phylogeny <- ConvertNewickToPhylogeny(paraphyletic_newick)
    paraphyletic_phylogeny$tip.label <- StripSubspeciesLabelFromTipLabels(paraphyletic_phylogeny$tip.label)
    plot(paraphyletic_phylogeny,show.node.label=TRUE,root.edge = TRUE)
    nodelabels( , col = "black", bg = "gray")
    assert(!is_monophyletic(paraphyletic_phylogeny))
  }
}

is_monophyletic_test()
