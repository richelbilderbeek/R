rm(list=ls());
library(ape);

phy_rcoal <- rcoal(10)
plot(phy_rcoal)
svg(filename="CreateRandomCoalescentTree.svg")
plot(phy_rcoal)
dev.off()