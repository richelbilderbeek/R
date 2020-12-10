library(ape)
library(phangorn)
library(testit)

convert_phylogeny_to_nexus <- function(
  phylogeny,
  filename
) {
  # Create a nexus file text from an phylogeny

  assert(class(phylogeny) == "phylo")

  write.nexus(phylogeny, file = filename)
}
