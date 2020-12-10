# Are there lineages in a phylogeny that are extinct and thus can be dropped?
# Can only create a reconstructed tree if at least 2 species are extant

source("~/GitHubs/R/Phylogenies/can_drop_extinct.R")

library(ape)
library(geiger)
library(testit)

can_drop_extinct_test <- function() {
  n_cols <- 1
  n_rows <- 3
  par(mfrow=c(n_rows,n_cols))

  newick <- "(L:1,(((((XD:1,ZD:1):1,CE:2):1,(FE:2,EE:2):1):1,(GD:1,ID:1):1,BD:1):3,(AC:1,EC:1):1,(((TC:1,FD:2):1,QC:1,RC:1):1,((((AE:1,BE:1):1,(WD:1,YD:1):1):1,HD:1):2,MC:1):1):1):3);"
  phylogeny_complete <- read.tree(text = newick)
  plot(phylogeny_complete,main="Multiple extant species, can remove extinct")
  assert(can_drop_extinct(phylogeny_complete))
  phylogeny_reconstructed <- drop.extinct(phylogeny_complete)
  plot(phylogeny_reconstructed,main="Reconstructed tree")

  newick <- "((s1:4.406520938,s2:0.2169422332):9.117964779,s3:3.063930512);"
  phylogeny_complete <- read.tree(text = newick)
  plot(phylogeny_complete,main="Only one extant species, cannot remove extinct")
  assert(!can_drop_extinct(phylogeny_complete))

  par(mfrow=c(1,1))

}

can_drop_extinct_test()