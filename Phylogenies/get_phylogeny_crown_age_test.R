source("~/GitHubs/R/Phylogenies/get_phylogeny_crown_age.R")

get_phylogeny_crown_age_test <- function()
{
  # Using the function
  phylogeny <- read.tree(text = "(t2:2.286187509,(t5:0.3145724408,((t1:0.08394513325,t4:0.08394513325):0.1558558349,t3:0.2398009682):0.07477147256):1.971615069);")
  crown_age <- get_phylogeny_crown_age(phylogeny)
  plot(phylogeny,main=paste("Phylogeny of crown age ",crown_age,sep=""))
  add.scale.bar(x=0,y=5)
}

get_phylogeny_crown_age_test()
