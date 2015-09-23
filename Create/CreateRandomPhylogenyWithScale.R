library(ape);
library(geiger);

# Create a random tree with 10 taxa
phylogeny <- rcoal(10)

# Plot that tree
plot(phylogeny,main="CreateRandomPhylogenyWithScale")
add.scale.bar()
