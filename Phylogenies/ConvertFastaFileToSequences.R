library(ape)
library(phangorn)
library(phytools)
library(testit)

ConvertFastaFileToSequences <- function(fasta_filename) {
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
  
DemonstrateConvertFastaFileToSequences <- function() {
  fasta_filename <- "ConvertFastaFileToCoalescentTree.fas"
  assert(file.exists(fasta_filename))
  table <- ConvertFastaFileToSequences(fasta_filename)
  table_with_labels_in_own_column <- cbind(rownames(table),table)
  
  print(table_with_labels_in_own_column)
  no_output <- apply(table_with_labels_in_own_column,1,function(row) {
      print(
        paste("Label",row[1],"has sequence",row[2])
      )
    }
  )
}

#DemonstrateConvertFastaFileToSequences()
