library(ape)
library(testit)

source("~/GitHubs/R/Phylogenies/can_drop_fossil.R")

drop_fossil <- function(newick)
{
  # Using drop.fossil
  #newick <- "(L:1,(((((XD:1,ZD:1):1,CE:2):1,(FE:2,EE:2):1):1,(GD:1,ID:1):1,BD:1):3,(AC:1,EC:1):1,(((TC:1,FD:2):1,QC:1,RC:1):1,((((AE:1,BE:1):1,(WD:1,YD:1):1):1,HD:1):2,MC:1):1):1):3);"
  phylogeny <- read.tree(text = newick)
  assert(can_drop_fossil(phylogeny))
  phylogeny <- drop.fossil(phylogeny)
  return (phylogeny)
}