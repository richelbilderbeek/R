source("~/GitHubs/R/Phylogenies/convert_edge_lengths_to_phylogeny.R")

library(ape)
library(testit)

convert_edge_lengths_to_phylogeny_test <- function() {
  multiple_edgelengths <- list(c(1,2), c(3,4))

  # No stem
  for (edgelengths in multiple_edgelengths) {
    plot(
      convert_edge_lengths_to_phylogeny(edgelengths),
      main="without stem",
      root.edge = TRUE #To be sure a possible stem is draw, but can just as good be false in this case
    )
  }

  # Stem added
  for (edgelengths in multiple_edgelengths) {
    plot(
      convert_edge_lengths_to_phylogeny(edgelengths,stem_length = 1),
      main="with stem",
      root.edge = TRUE
    )
  }
  print("convert_edge_lengths_to_phylogeny_test: OK")
}

convert_edge_lengths_to_phylogeny_test()
