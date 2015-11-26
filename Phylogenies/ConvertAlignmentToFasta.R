library(ape)
library(phangorn)

convert_alignment_to_fasta <- function(
  alignment_dnabin,
  filename
) {
  # Create a FASTA file text from an alignment

  write.phyDat(alignment_dnabin, file=filename, format="fasta")
}

ConvertAlignmentToFasta <- function(alignment_dnabin, filename) {
  print("Warning: use of obsolete function 'ConvertAlignmentToFasta', use 'convert_alignment_to_fasta' instead")
  return (
    convert_alignment_to_fasta(
      alignment_dnabin = alignment_dnabin,
      filename = filename
    )
  )
}