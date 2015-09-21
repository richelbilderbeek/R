library(ape)
library(DDD)
library(plyr)
#library(phyloch) # From http://www.christophheibl.de/Rpackages.html
source("~/GitHubs/R/MyFavoritePackages/phyloch/R/write.phy.R")
#source("~/GitHubs/R/MyFavoritePackages/phyloch/R/raxml.R")
source("~/GitHubs/R/MyFavoritePackages/phyloch/R/raxml2.R")
library(geiger)
library(testit)
library(phangorn);
birth_rate <- 0.2
death_rate <- 0.1
time_stop <- 10
sequence_length <- 100
raxml_folder <- "/home/p230198/GitHubs/R/MyFavoritePrograms"
raxml_path <- paste(raxml_folder,"/standard-RAxML",sep="")
raxml_result_file <- "tmp.txt"
raxml_result_path <- paste(raxml_path,"/RAxML_bestTree.",raxml_result_file,".tre",sep="")

assert(file.exists(raxml_path))

# Create reconstructed simulated tree
phylogeny <- sim.bdtree(birth_rate, death_rate, stop="time",t=time_stop)
phylogeny <- drop.fossil(phylogeny)
plot(
  phylogeny,
  main=paste(
    "sim.bdtree(birth_rate=",birth_rate,", ",
    "death_rate=",death_rate,", t=time_stop=",time_stop,", stop=\"time\")"
  )
)

# Create simulated DNA from tree
alignments_phydat <- simSeq(phylogeny,l=sequence_length, rate = 0.001)
alignments_dnabin <- as.DNAbin(alignments_phydat)
image(alignments_dnabin)


# Clean up
file.remove(list.files(path = raxml_folder,pattern = "RAxML_",all.files = TRUE,    full.names = TRUE,recursive = FALSE,ignore.case = FALSE,include.dirs = FALSE  ))
file.remove(list.files(path = raxml_folder,pattern = "tmp"   ,all.files = TRUE,    full.names = TRUE,recursive = FALSE,ignore.case = FALSE,include.dirs = FALSE  ))

# Infer best fitting tree
# Using RAxML, citation: A. Stamatakis: "RAxML Version 8: A tool for Phylogenetic Analysis and Post-Analysis of Large Phylogenies". In Bioinformatics, 2014,
# Can be found here: https://github.com/stamatak/standard-RAxML.git
raxml(alignments_dnabin, path = raxml_folder, file = raxml_result_file)
phylogeny_inferred <- read.tree(raxml_result_path)
plot(phylogeny_inferred)

#png(filename="~/script.png")
n_cols <- 1
n_rows <- 2
par(mfrow=c(n_rows,n_cols))
plot(phylogeny,main="Truth")
plot(phylogeny_inferred,main="Inferred")
par(mfrow=c(1,1))
#dev.off()

# Compare simulated with best fitting tree


