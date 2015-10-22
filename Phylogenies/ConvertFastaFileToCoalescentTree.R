library(ape)
library(phangorn)
library(phytools)
library(testit)

fasta_filename <- "ConvertFastaFileToCoalescentTree.fas"
assert(file.exists(fasta_filename))

sequences <- read.FASTA(fasta_filename)
assert(class(sequences)=="DNAbin")

alignment <- as.alignment(sequences)
assert(class(alignment)=="alignment")

alignment_dnabin <- as.DNAbin(y)
assert(class(alignment_dnabin)=="DNAbin")
image(alignment_dnabin)


# FAILS
#treeUPGMA <- upgma(dist.dna(sequences))
#treeNJ <- nj(dist.dna(sequences))