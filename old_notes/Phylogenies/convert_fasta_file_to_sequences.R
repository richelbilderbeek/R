library(ape)
#library(phangorn)
#library(phytools)
library(testit)

convert_fasta_file_to_sequences <- function(fasta_filename) {
  assert(file.exists(fasta_filename))

  # Read the file
  sequences_dnabin <- read.FASTA(fasta_filename)
  assert(class(sequences_dnabin)=="DNAbin")

  # Convert the file to a table with labels and sequences
  labels <- names(sequences_dnabin)
  chars <- as.character(sequences_dnabin)
  sequences <- NULL

  for (line in chars)
  {
    sequence <- capture.output(cat(line,sep=""))
    sequences <- c(sequences,sequence)
  }
  
  table <- data.frame(sequences,row.names = labels)
  #table <- data.frame(cbind(labels,sequences))
  #names(table) <- c("label","sequence")
  #rownames(table) <- labels
  return (table)
}