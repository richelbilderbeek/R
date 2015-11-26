source("~/GitHubs/R/Phylogenies/GetPhylogenyNlttMatrix.R")
source("~/GitHubs/R/Phylogenies/StretchNlttMatrix.R")

demonstrate_get_phylogeny_nltt_matrix <- function() {
  newick <- "((((XD:1,ZD:1):1,CE:2):1,(FE:2,EE:2):1):4,((AE:1,BE:1):1,(WD:1,YD:1):1):5);"
  phylogeny <- read.tree(text = newick)
  plot(phylogeny)
  add.scale.bar()

  # Create nLTT plot
  nLTT.plot(phylogeny)
  
  # Demonstrate the get_phylogeny_nltt_matrix function
  nltt <- get_phylogeny_nltt_matrix(phylogeny)
  points(nltt, pch = 19,col="red")

  # Demonstrate the StretchMatrix function
  stretch_matrix <- stretch_nltt_matrix(nltt,dt = 0.05)
  points(stretch_matrix, pch = 19,col="blue")
}

demonstrate_get_phylogeny_nltt_matrix()