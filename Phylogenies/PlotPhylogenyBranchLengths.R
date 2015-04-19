rm(list=ls());
library(ape);
library(geiger);
setwd("~")

newick <- "((((XD:1,ZD:1):1,CE:2):1,(FE:2,EE:2):1):4,((AE:1,BE:1):1,(WD:1,YD:1):1):5);"
phylogeny <- read.tree(text = newick)
branch_lengths <- phylogeny$edge.length

svg(filename="PlotPhylogenyBranchLengths.svg")
hist(branch_lengths)
dev.off()
