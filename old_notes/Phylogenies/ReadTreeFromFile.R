rm(list=ls())
library(ape)
library(phytools)


newick_filename <- "ReadTreeFromFile.tre"
newick <- "(A:1,B:1);"
#newick <- "((A:3,B:3):1,C:4);"

my_file <- file(newick_filename)
writeLines(newick,my_file)
close(my_file)


phylogeny <- read.tree(file = newick_filename)

plot(phylogeny)