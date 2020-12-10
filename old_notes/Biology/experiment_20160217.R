library(ape)
library(PBD)

# Create the following tree:
# 
#      +...... 1a
#  +...+
#  |   +...X-- 2
# -+   
#  +---------- 1b
#

set.seed(3)
pbd <- pbd_sim(c(0.1,0.2,0.1,0.1,0.1),3.1,plotit = FALSE) 
colors<-setNames(c("black","red"),c("g","i"))
svg("~/ProgressReport2016_7_1.svg")
plot(pbd$igtree.extant, colors, lwd = 10, fsize = 2)
dev.off()

# Replace labels: simple
pbd$igtree.extant$tip.label <- c("1a","2","1b")
plot(pbd$igtree.extant, colors, lwd = 10, fsize = 2)

# Replace labels: to be used by BEAST
pbd$igtree.extant$tip.label <- c("1.a","2.a","1.b")
plot(pbd$igtree.extant, colors, lwd = 10, fsize = 2)

# Extract the tree to p
p <- rcoal(10)
p$edge <- pbd$igtree.extant$edge
p$edge.length <- pbd$igtree.extant$edge.length
p$tip.label <- pbd$igtree.extant$tip.label
p$Nnode <- pbd$igtree.extant$Nnode
plot(p)

library(testit)
source("~/GitHubs/R/Phylogenies/convert_phylogeny_to_alignment.R")
set.seed(3)
a <- convert_phylogeny_to_alignment(
  phylogeny = p,
  sequence_length = 1000,
  mutation_rate = 0.05
)
image(a)

# Convert to NEXUS, as *BEAST needs this format
source("~/GitHubs/R/Phylogenies/convert_alignment_to_nexus.R")
convert_alignment_to_nexus(
  alignment = a,
  filename = "~/ProgressReport2016_8_1.nexus"
)
