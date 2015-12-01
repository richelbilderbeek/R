source("~/GitHubs/R/Phylogenies/is_alignment.R")
library(ape)
library(testit)

get_genetic_distance <- function(
  alignment,
  model
) {
  # Obtain the genetic distance between the alignments
  assert(is_alignment(alignment))
  return (
    dist.dna(
      x = alignment, 
      model = model
    )
  )
}