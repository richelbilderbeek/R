library(ape)
library(testit)

source("~/GitHubs/R/Phylogenies/ConvertNewickToPhylogeny.R")

ConvertEdgeLengthsToPhylogeny <- function(edge_lengths, stem_length = 0) {
  assert(length(edge_lengths) == 2)
  newick <- paste("(A:",edge_lengths[1],",B:",edge_lengths[2],"):",stem_length,";",sep="")
  phylogeny <- ConvertNewickToPhylogeny(newick)
  return (phylogeny)
}

DemonstrateConvertEdgeLengthsToPhylogeny <- function() {
  multiple_edgelengths <- list(c(1,2), c(3,4))

  # No stem
  for (edgelengths in multiple_edgelengths) {
    plot(
      ConvertEdgeLengthsToPhylogeny(edgelengths),
      main="without stem",
      root.edge = TRUE #To be sure a possible stem is draw, but can just as good be false in this case
    )
  }

  # Stem added
  for (edgelengths in multiple_edgelengths) {
    plot(
      ConvertEdgeLengthsToPhylogeny(edgelengths,stem_length = 1),
      main="with stem",
      root.edge = TRUE
    )
  }
}

#DemonstrateConvertEdgeLengthsToPhylogeny()
