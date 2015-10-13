ReadLibraries <- function() {

  library(ape)
  library(DDD)
  library(plyr)
  #library(phyloch) # From http://www.christophheibl.de/Rpackages.html
  source("~/GitHubs/R/MyFavoritePackages/phyloch/R/write.phy.R") #Fixed bug
  #source("~/GitHubs/R/MyFavoritePackages/phyloch/R/raxml.R") #Fixed bug
  source("~/GitHubs/R/MyFavoritePackages/phyloch/R/raxml2.R") #Calls 'x' instead of './x'
  library(geiger)
  library(testit)
  library(ape)
  library(geiger)
  library(phytools)
  library(PBD)
  library(testit)
  library(RColorBrewer)
  library(data.table)
  library(phangorn)
  library(nLTT);
  source("~/GitHubs/R/Phylogenies/AddOutgroupToPhylogeny.R")
  source("~/GitHubs/R/Phylogenies/ConvertPhylogenyToAlignments.R")
  source("~/GitHubs/R/Phylogenies/ConvertAlignmentsToFasta.R")
}