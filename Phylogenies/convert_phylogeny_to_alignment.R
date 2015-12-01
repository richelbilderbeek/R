library(ape)
library(phangorn)

convert_phylogeny_to_alignment <- function(
  phylogeny,
  sequence_length,
  mutation_rate = 1
) {
  # Convert a phylogeny to a random DNA alignment

  assert(class(phylogeny)=="phylo")
  assert(sequence_length > 0)
  assert(mutation_rate >= 0)

  alignment_phydat <- simSeq(
    phylogeny,
    l=sequence_length,
    rate=mutation_rate
  )
  assert(class(alignment_phydat)=="phyDat")
  
  alignment_dnabin <- as.DNAbin(alignment_phydat)
  assert(class(alignment_dnabin)=="DNAbin")
  
  return (alignment_dnabin)  
}