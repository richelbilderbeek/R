library(ape)
library(phangorn)

convert_phylogeny_to_alignment <- function(
  phylogeny,
  sequence_length,
  mutation_rate = 1
) {
  # Convert a phylogeny to a random DNA alignment

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

ConvertPhylogenyToAlignment <- function(
  phylogeny,
  sequence_length,
  mutation_rate = 1
) {
  print("Warning: use of obsolete function 'ConvertPhylogenyToAlignment', use 'convert_phylogeny_to_alignment' instead")
  return (
    convert_phylogeny_to_alignment(
      phylogeny = phylogeny,
      sequence_length = sequence_length,
      mutation_rate = mutation_rate
    ) 
  )
}