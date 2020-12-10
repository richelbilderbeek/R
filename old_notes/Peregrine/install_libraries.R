InstallLibraries <- function() {
  install.packages("ape", repos="http://cran.r-project.org")
  install.packages("DDD", repos="http://cran.r-project.org")
  install.packages("plyr", repos="http://cran.r-project.org")
  install.packages("data.table", repos="http://cran.r-project.org")
  install.packages("geiger", repos="http://cran.r-project.org")
  install.packages("testit", repos="http://cran.r-project.org")
  install.packages("phytools", repos="http://cran.r-project.org")
  install.packages("PBD", repos="http://cran.r-project.org")
  install.packages("RColorBrewer", repos="http://cran.r-project.org")
  install.packages("data.table", repos="http://cran.r-project.org")
  install.packages("phangorn", repos="http://cran.r-project.org")
  install.packages("nLTT", repos="http://cran.r-project.org")

  if (!file.exists("~/GitHubs/R/MyFavoritePackages/phyloch/R/write.phy.R"))
  {
    print("(hacked) phyloch package absent, will now download and install it")
    system("cd ~/GitHubs/R; ./DownloadPhyloch.sh")
  }
  
  can_install_devtools <- FALSE
  if (can_install_devtools) {
    library(devtools)
    install_github("olli0601/rBEAST")
    print("olli0601 his rBEAST package installed from his GitHub")
  } else {
    if (!file.exists("~/GitHubs/R/MyFavoritePackages/olli_rBEAST/R/fun.beast2output.R"))
    {
      print("olli0601/rBEAST absent, will now download and install it")
      system("cd ~/GitHubs/R; ./DownloadOlliRbeast.sh")
    }
    source("~/GitHubs/R/MyFavoritePackages/olli_rBEAST/R/fun.beast2output.R")
    source("~/GitHubs/R/MyFavoritePackages/olli_rBEAST/R/fun.beast2.R")
    source("~/GitHubs/R/MyFavoritePackages/olli_rBEAST/R/fun.beast.R")
    source("~/GitHubs/R/MyFavoritePackages/olli_rBEAST/R/fun.treeannotator.R")
    source("~/GitHubs/R/MyFavoritePackages/olli_rBEAST/R/script.beast.R")
    print("olli0601 his rBEAST package loaded from this GitHub")
  }
}