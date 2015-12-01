library(ape)
library(testit)

source("~/GitHubs/R/Phylogenies/ConvertNewickToPhylogeny.R")
source("~/GitHubs/R/Phylogenies/GetCorrectTestNewicks.R")
source("~/GitHubs/R/Phylogenies/GetCorrectParaphyleticTestNewicks.R")
source("~/GitHubs/R/Phylogenies/StripSubspeciesLabelFromTipLabels.R")

# Detect if a group of labels is monophyletic
IsMonophyleticGroup <- function(phylogeny, groups) {
  return (is.monophyletic(phylogeny, tips = groups))
}

DemonstrateIsMonophyleticGroup <- function() {

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
  plot(phylogeny)
  assert( IsMonophyleticGroup(phylogeny,groups = c("B","C")))
  assert(!IsMonophyleticGroup(phylogeny,groups = c("A","C")))
  assert( IsMonophyleticGroup(phylogeny,groups = c("A","B","C")))
}

#DemonstrateIsMonophyleticGroup()
