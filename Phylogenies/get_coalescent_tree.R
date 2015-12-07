library(ape)
library(phangorn)
library(phytools)
library(testit)
library(coalescentMCMC)

source("~/GitHubs/R/Phylogenies/get_test_fasta_filename.R")

get_coalescent_tree <- function() {

  fasta_filename <- get_test_fasta_filename()
  assert("File must exist",file.exists(fasta_filename))
  
  sequences <- read.FASTA(fasta_filename)
  alignment <- as.alignment(sequences)
  
  data(woodmouse)
  sequences <- woodmouse
  
  system.time(out <- coalescentMCMC(sequences)) # circa 12 sec.
  plot(out)
  plot(getMCMCtrees()) # returns 3000 trees
}

get_coalescent_tree()