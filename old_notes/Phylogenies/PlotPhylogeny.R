library(ape)

PlotPhylogeny <- function(phylogeny)
{
  plot(phylogeny)
}

DemonstratePlotPhylogeny <- function()
{
  phylogeny <- rcoal(10)
  PlotPhylogeny(phylogeny)
}

# Uncomment this to view the function demonstration
#DemonstratePlotPhylogeny()