ReadLibraries <- function() {

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
  
  
  can_install_devtools <- FALSE
  if (can_install_devtools) {
    library(devtools)
    install_github("olli0601/rBEAST")
    print("olli0601 his rBEAST package installed from his GitHub")
  } else {
    source("~/GitHubs/R/MyFavoritePackages/olli_rBEAST/R/fun.beast2output.R")
    source("~/GitHubs/R/MyFavoritePackages/olli_rBEAST/R/fun.beast2.R")
    source("~/GitHubs/R/MyFavoritePackages/olli_rBEAST/R/fun.beast.R")
    source("~/GitHubs/R/MyFavoritePackages/olli_rBEAST/R/fun.treeannotator.R")
    source("~/GitHubs/R/MyFavoritePackages/olli_rBEAST/R/script.beast.R")
    print("olli0601 his rBEAST package loaded from this GitHub")
  }
}