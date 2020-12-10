library(testit)

convert_alignment_to_fasta <- function(
  alignment_dnabin,
  filename
) {
  # Create a FASTA file text from an alignment

  assert(class(alignment_dnabin) == "DNAbin")

  phangorn::write.phyDat(alignment_dnabin, file = filename, format = "fasta")
}