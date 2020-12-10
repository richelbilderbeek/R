print("FAILS")
stop()

library(ape)
library(phangorn)
library(phytools)
library(testit)

source("~/GitHubs/R/Phylogenies/get_test_fasta_filename.R")

fasta_filename <- get_test_fasta_filename()
assert(file.exists(fasta_filename))

sequences <- read.FASTA(fasta_filename)
assert(class(sequences)=="DNAbin")

alignment <- as.alignment(sequences)
assert(class(alignment)=="alignment")

alignment_dnabin <- as.DNAbin(alignment)
assert(class(alignment_dnabin)=="DNAbin")
image(alignment_dnabin)


# FAILS
#treeUPGMA <- upgma(dist.dna(sequences))
#treeNJ <- nj(dist.dna(sequences))