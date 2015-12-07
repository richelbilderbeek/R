source("~/GitHubs/R/Phylogenies/drop_fossil.R")

drop_fossil_crash <- function()
{
  # Using drop.fossil
  newick <- "((s1:4.406520938,s2:0.2169422332):9.117964779,s3:3.063930512);"
  phylogeny_complete <- read.tree(text = newick)
  n_cols <- 1
  n_rows <- 2
  par(mfrow=c(n_rows,n_cols))
  plot(phylogeny_complete)
  assert(!can_drop_fossil(phylogeny_complete))
  
  # CRASH HERE:
  # Error in xmat[, 1] : incorrect number of dimensions 
  phylogeny_reconstructed <- drop.fossil(phylogeny_complete) 
  plot(phylogeny_reconstructed)
  par(mfrow=c(1,1))
}

drop_fossil_test <- function() {
  n_cols <- 1
  n_rows <- 2
  par(mfrow=c(n_rows,n_cols))

  newick <- "(L:1,(((((XD:1,ZD:1):1,CE:2):1,(FE:2,EE:2):1):1,(GD:1,ID:1):1,BD:1):3,(AC:1,EC:1):1,(((TC:1,FD:2):1,QC:1,RC:1):1,((((AE:1,BE:1):1,(WD:1,YD:1):1):1,HD:1):2,MC:1):1):1):3);"
  plot(read.tree(text = newick),main="Before")
  phylogeny <- drop_fossil(newick)
  plot(phylogeny,main="After")

  par(mfrow=c(1,1))
}

drop_fossil_test()
#drop_fossil_crash()