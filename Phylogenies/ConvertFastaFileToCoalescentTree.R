rm(list=ls())
library(ape)
library(phangorn)
library(phytools)
library(testit)
setwd("~/GitHubs/R/Phylogenies")

fasta_filename <- "ConvertFastaFileToCoalescentTree.fas"
assert("File must exist",file.exists(fasta_filename))

sequences <- read.FASTA(fasta_filename)
alignment <- as.alignment(sequences)

# FAILS
#treeUPGMA <- upgma(dist.dna(sequences))
#treeNJ <- nj(dist.dna(sequences))