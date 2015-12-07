rm(list=ls());
library(ape);
library(geiger);
setwd("~/")

n_taxa <- 10
phylogeny <- rcoal(n_taxa)
phylogeny <- drop.extinct(phylogeny) # Drop extinct

svg(filename="GetPhylogenyBranchLengths.svg")
n_cols <- 1
n_rows <- 2
par(mfrow=c(n_rows,n_cols))
branching_times <- branching.times(phylogeny)
plot(phylogeny,show.tip.label = FALSE)

# When saving to file
align_with_phylogeny_factor <- 1.56 # Makes the phylogeny and branching times align vertically

# When on screen
# align_with_phylogeny_factor <- 1.04 # Makes the phylogeny and branching times align vertically

plot(
  y = rep(1,length(branching_times)),
  x = (max(branching_times) - branching_times),
  xlim=c(0,max(branching_times)*align_with_phylogeny_factor),
  xlab="Branching time",
  ylab="",yaxt='n'
)
dev.off()