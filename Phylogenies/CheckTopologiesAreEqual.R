library(ape)
library(geiger)
library(testit)

# TEST 1: Simple identical Newicks
newick1 <- "(A,(B,C));"
newick2 <- "(A,(B,C));"
phylogeny1 <- read.tree(text = newick1)
phylogeny2 <- read.tree(text = newick2)
assert(all.equal(phylogeny1,phylogeny2))

# TEST2: Simple differently-labeled Newicks
newick1 <- "(A,(B,C));"
newick2 <- "(B,(A,C));"
phylogeny1 <- read.tree(text = newick1)
phylogeny2 <- read.tree(text = newick2)
assert(!all.equal(phylogeny1,phylogeny2))
assert( all.equal(phylogeny1,phylogeny2,use.tip.label=FALSE))

# TEST 1: Simple Newicks with different edge lengths, with same topology
newick1 <- "(A:1,(B:3,C:3));"
newick2 <- "(A:2,(B:4,C:4));"
phylogeny1 <- read.tree(text = newick1)
phylogeny2 <- read.tree(text = newick2)
assert(!all.equal(phylogeny1,phylogeny2))
assert( all.equal(phylogeny1,phylogeny2,use.edge.length=FALSE))




# Different Newicks      V    V
newick1 <- "(L:1,(((((XD:1,ZD:1):1,CE:2):1,(FE:2,EE:2):1):1,(GD:1,ID:1):1,BD:1):3,(AC:1,EC:1):1,(((TC:1,FD:2):1,QC:1,RC:1):1,((((AE:1,BE:1):1,(WD:1,YD:1):1):1,HD:1):2,MC:1):1):1):3);"
newick2 <- "(L:1,(((((XD:2,ZD:2):1,CE:2):1,(FE:2,EE:2):1):1,(GD:1,ID:1):1,BD:1):3,(AC:1,EC:1):1,(((TC:1,FD:2):1,QC:1,RC:1):1,((((AE:1,BE:1):1,(WD:1,YD:1):1):1,HD:1):2,MC:1):1):1):3);"

# Different phylogenies, same topology
phylogeny1 <- read.tree(text = newick1)
phylogeny1 <- drop.extinct(phylogeny1)
phylogeny2 <- read.tree(text = newick2)
phylogeny2 <- drop.extinct(phylogeny2)
# Phylogenies are not exactly the same
assert(!all.equal(phylogeny1,phylogeny2))
assert( all.equal(phylogeny1,phylogeny2,use.edge.length=FALSE)) #FAILS???
