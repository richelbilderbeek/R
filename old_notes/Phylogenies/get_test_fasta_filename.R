get_test_fasta_filename <- function() {

  fasta_filename <- "convert_alignment_to_fasta.fasta"
  #fasta_filename <- "convert_fasta_file_to_sequences.fasta"
  if (file.exists(fasta_filename)) { return (fasta_filename) }
  fasta_filename <- paste("~/GitHubs/R/Phylogenies/",fasta_filename,sep="")
  if (file.exists(fasta_filename)) { return (fasta_filename) }
  print("get_test_fasta_filename: cannot find file")
  stop()
}


#get_test_fasta_filename()