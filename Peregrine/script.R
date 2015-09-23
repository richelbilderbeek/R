# The tarball must be extracted to check if the install will succeed
# system("R CMD check ~/GitHubs/Wip/RampalEtienne/R/PBD")
# system("R CMD INSTALL ~/GitHubs/Wip/RampalEtienne/R/PBD_1.1.tar.gz")

library(ape)
library(DDD)
library(plyr)
#library(phyloch) # From http://www.christophheibl.de/Rpackages.html
source("~/GitHubs/R/MyFavoritePackages/phyloch/R/write.phy.R") #Fixed bug
#source("~/GitHubs/R/MyFavoritePackages/phyloch/R/raxml.R") #Fixed bug
source("~/GitHubs/R/MyFavoritePackages/phyloch/R/raxml2.R") #Calls 'x' instead of './x'
library(geiger)
library(testit)
library(phangorn);
library(ape);
library(geiger);
library(phytools);
library(PBD);

# Adds an outgroup to phylogeny
# From www.github.com/richelbilderbeek/R
AddOutgroupToPhylogeny <- function(
  phylogeny,
  stem_length,
  outgroup_name="Outgroup"
) 
{
  n_taxa <- length(phylogeny$tip.label)
  crown_age <- dist.nodes(phylogeny)[ n_taxa + 1][1]
  phylogeny$root.edge <- stem_length
  # Add an outgroup
  # Thanks to Liam J. Revell, http://grokbase.com/t/r/r-sig-phylo/12bfqfb93a/adding-a-branch-to-a-tree
  tip<-list(
    edge=matrix(c(2,1),1,2),
    tip.label="Outgroup",
    edge.length=crown_age + stem_length,
    Nnode=1
  )
  class(tip)<-"phylo"
  # Attach to any node, in this case to the root. Note: order matters
  phylogeny<-bind.tree(tip,phylogeny)
}


# Model parameters
b_1  <- 0.2 #the speciation-initiation rate of good species
la_1 <- 1.0 #the speciation-completion rate 
b_2  <- 0.2 # the speciation-initiation rate of incipient species 
mu_1 <- 0.1 # the extinction rate of good species 
mu_2 <- 0.1 # the extinction rate of incipient species 
age <- 15
sequence_length <- 1000
n_tree_searches <- 10
n_bootstrap_replicates <- 10


# File paths for RaXML
raxml_folder <- "/home/p230198/GitHubs/R/MyFavoritePrograms"
raxml_path <- paste(raxml_folder,"/standard-RAxML",sep="")
raxml_result_file <- "tmp.txt"
raxml_result_path <- paste(raxml_folder,"/RAxML_bestTree.",raxml_result_file,".tre",sep="")

assert(file.exists(raxml_path))

# Create reconstructed protracted simulated tree
tree_full <-pbd_sim(c(b_1,la_1,b_2,mu_1,mu_2),age,soc=2,plot=0)
par(mfrow=c(1,1)) # Bug fix of https://github.com/richelbilderbeek/Wip/issues/20

phylogeny <- tree_full$tree
assert(is.rooted(phylogeny))
assert(is.ultrametric(phylogeny))
plot(phylogeny,main="True tree")
add.scale.bar()


# Add an outgroup
phylogeny_with_outgroup <- AddOutgroupToPhylogeny(phylogeny,stem_length = 0)
plot(phylogeny_with_outgroup)
add.scale.bar(x=0,y=length(phylogeny_with_outgroup$tip.label))

# Create simulated DNA from tree
alignments_phydat <- simSeq(phylogeny_with_outgroup,l=sequence_length, rate = 0.01)
alignments_dnabin <- as.DNAbin(alignments_phydat)
image(alignments_dnabin)


# Clean up possible previous RAxML run
file.remove(list.files(path = raxml_folder,pattern = "RAxML_",all.files = TRUE,    full.names = TRUE,recursive = FALSE,ignore.case = FALSE,include.dirs = FALSE  ))
file.remove(list.files(path = raxml_folder,pattern = "tmp"   ,all.files = TRUE,    full.names = TRUE,recursive = FALSE,ignore.case = FALSE,include.dirs = FALSE  ))

# Infer best fitting tree using RAxML, citation: A. Stamatakis: "RAxML Version 8: A tool for Phylogenetic Analysis and Post-Analysis of Large Phylogenies". In Bioinformatics, 2014,
# Can be found here: https://github.com/stamatak/standard-RAxML.git
raxml(
  alignments_dnabin, 
  path = raxml_folder, 
  file = raxml_result_file, 
  runs = c(n_tree_searches,n_bootstrap_replicates),
  outgroup = "Outgroup"
)

assert(file.exists(raxml_result_path))
phylogeny_inferred <- read.tree(raxml_result_path)
assert(is.rooted(phylogeny_inferred))
plot(phylogeny_inferred)

# Plot the two trees
n_cols <- 1
n_rows <- 2
par(mfrow=c(n_rows,n_cols))
plot(phylogeny_with_outgroup,main="Truth")
add.scale.bar(x=0,y=10)
plot(phylogeny_inferred,main="Inferred")
add.scale.bar()
par(mfrow=c(1,1))

# Compare simulated with best fitting tree


