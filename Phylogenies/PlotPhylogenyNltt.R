library(ape)
library(geiger)
library(nLTT)

PlotPhylogenyNltt <- function(phylogeny)
{
  nLTT.plot(phylogeny)
}

DemonstratePhylogenyPlotNltt <- function()
{
  newick <- "((((XD:1,ZD:1):1,CE:2):1,(FE:2,EE:2):1):4,((AE:1,BE:1):1,(WD:1,YD:1):1):5);"
  phylogeny <- read.tree(text = newick)
  #plot(phylogeny)
  
  PlotPhylogenyNltt(phylogeny)

  png(filename="PlotPhylogenyNltt.png")
  PlotPhylogenyNltt(phylogeny)
  dev.off()
}

# Uncomment this to view the function demonstration
#DemonstratePhylogenyPlotNltt()
