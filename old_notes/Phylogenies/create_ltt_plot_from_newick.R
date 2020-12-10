# Create an LTT plot from a Newick

library(ape)
library(geiger)

create_ltt_plot_from_newick <- function(newick) {
  # Create an LTT plot from a Newick

  phylogeny <- read.tree(text = newick)
  ltt.plot(phylogeny)
}