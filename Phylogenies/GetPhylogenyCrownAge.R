library(ape)

GetPhylogenyCrownAge <- function(
  phylogeny,
  stem_length,
  outgroup_name="Outgroup"
) {
  n_taxa <- length(phylogeny$tip.label)
  crown_age <- dist.nodes(phylogeny)[ n_taxa + 1][1]
  return (crown_age)
}


DemonstrateGetPhylogenyCrownAge <- function()
{
  # Using the function
  phylogeny <- read.tree(text = "(t2:2.286187509,(t5:0.3145724408,((t1:0.08394513325,t4:0.08394513325):0.1558558349,t3:0.2398009682):0.07477147256):1.971615069);")
  crown_age <- GetPhylogenyCrownAge(phylogeny)
  plot(phylogeny,main=paste("Phylogeny of crown age ",crown_age,sep=""))
  add.scale.bar(x=0,y=5)
}

# Uncomment this to view the function demonstration
#DemonstrateGetPhylogenyCrownAge()
