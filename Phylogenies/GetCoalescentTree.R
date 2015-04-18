library(ape)
library(phangorn)
library(phytools)
library(testit)
library(coalescentMCMC)
setwd("~/GitHubs/R/Phylogenies")

fasta_filename <- "ConvertFastaFileToCoalescentTree.fas"
assert("File must exist",file.exists(fasta_filename))

sequences <- read.FASTA(fasta_filename)
alignment <- as.alignment(sequences)

data(woodmouse)
sequences <- woodmouse

system.time(out <- coalescentMCMC(sequences)) # circa 12 sec.
plot(out)
plot(getMCMCtrees()) # returns 3000 trees
