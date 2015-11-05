library(ape)
library(nLTT)

# Two different phylogenies
newick1 <- "((((XD:1,ZD:1):1,CE:2):1,(FE:2,EE:2):1):4,((AE:1,BE:1):1,(WD:1,YD:1):1):5);"
phylogeny1 <- read.tree(text = newick1)
plot(phylogeny1)
nLTT.plot(phylogeny1)
nLTT.plot


newick2 <- "((A:0.3,B:0.3):0.7,(C:0.6,D:0.6):0.4);"
phylogeny2 <- read.tree(text = newick2)
plot(phylogeny2)
nLTT.plot(phylogeny2)

# Combine these
GetAverageNltt(phylogeny1)


nLTT.plot(phylogeny1);
nLTT.lines(phylogeny2,lty=2);

