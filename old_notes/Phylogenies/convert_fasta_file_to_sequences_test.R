library(testit)

source("~/GitHubs/R/Phylogenies/convert_fasta_file_to_sequences.R")
  
convert_fasta_file_to_sequences_test <- function() {
  
  # Find the FASTA file
  fasta_filename <- "convert_fasta_file_to_sequences.fasta"
  if (!file.exists(fasta_filename)) {
    fasta_filename <- paste("~/GitHubs/R/Phylogenies/", fasta_filename, sep="")
  }
  assert(file.exists(fasta_filename))
  
  # Do the work
  table <- convert_fasta_file_to_sequences(fasta_filename)
  table_with_labels_in_own_column <- cbind(rownames(table),table)
  
  print(table_with_labels_in_own_column)
  no_output <- apply(table_with_labels_in_own_column,1,function(row) {
      print(
        paste("Label",row[1],"has sequence",row[2])
      )
    }
  )
}

convert_fasta_file_to_sequences_test()
