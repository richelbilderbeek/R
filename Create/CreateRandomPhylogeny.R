library(ape);

phy_rcoal = rcoal(10)

svg(filename="CreateRandomPhylogenyRcoal.svg")
plot(phy_rcoal)
dev.off()
?rtree
phy_rtree = rtree(10)

svg(filename="CreateRandomPhylogenyRtree.svg")
plot(phy_rtree)
dev.off()
