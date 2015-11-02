library(ape)

PlotPhylogenyWithScale <- function(phylogeny)
{
  plot(phylogeny)
  add.scale.bar()
}

DemonstratePlotPhylogenyWithScale <- function()
{
  phylogeny <- rcoal(10)
  PlotPhylogenyWithScale(phylogeny)
}

# Uncomment this to view the function demonstration
#DemonstratePlotPhylogenyWithScale()