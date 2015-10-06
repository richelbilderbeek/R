rm(list=ls());
library(ape);
library(geiger);

CreateRandomPhylogeny <- function(n_taxa) {
  phylogeny <- rcoal(n_taxa)
}


phylogeny <- CreateRandomPhylogeny(n_taxa = 5)
plot(phylogeny)
gammaStat(phylogeny)

n_cols <- 1
n_rows <- 3
par(mfrow=c(n_rows,n_cols))

stemmy_tree <- read.tree(text = "((t1:0.1,t5:0.1):0.9,(t3:0.2,(t4:0.1,t2:0.1):0.1):0.8);")
plot(
  stemmy_tree,
  main = paste("Stemmy tree with gamma = ",gammaStat(stemmy_tree)) # gamma = 1.5
)

basic_tree <- read.tree(text = "((t1:0.4,t5:0.4):0.6,(t3:0.3,(t4:0.1,t2:0.1):0.2):0.7);")
plot(
  basic_tree,
  main = paste("Basic tree with gamma = ",gammaStat(basic_tree))
)

tippy_tree <- read.tree(text = "((t1:0.9,t5:0.9):0.1,(t3:0.9,(t4:0.8,t2:0.8):0.1):0.1);")
plot(
  tippy_tree, 
  main = paste("Tippy tree with gamma = ",gammaStat(tippy_tree)) # gamma = -2.6
)

par(mfrow=c(1,1))
