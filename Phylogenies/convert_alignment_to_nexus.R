library(ape)
library(testit)

convert_alignment_to_nexus <- function(
  alignment_dnabin,
  filename
) {
  # Create a nexus file text from an alignment

  assert(class(alignment_dnabin) == "DNAbin")
  write.nexus.data(alignment_dnabin, file = filename, format = "dna")
}
