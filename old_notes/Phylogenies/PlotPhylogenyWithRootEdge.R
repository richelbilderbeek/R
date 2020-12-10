library(ape)

PlotPhylogenyWithRootEdge <- function(phylogeny)
{
  plot(phylogeny,root.edge = TRUE)
}

DemonstratePlotPhylogenyWithRootEdge <- function()
{
  phylogeny <- read.tree(text="(A:2.0,(B:1.0,C:1.0):1.0):1.0;")
  PlotPhylogenyWithRootEdge(phylogeny)
}

# Uncomment this to view the function demonstration
DemonstratePlotPhylogenyWithRootEdge()
