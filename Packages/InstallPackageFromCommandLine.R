# In the folder~/GitHubs/Wip/RampalEtienne/R, there is:
#  PBD_1.1.tar.gz
#  /PBD/
#  /PBD/DESCRIPTION

# The tarball must be extracted to check if the install will succeed
system("R CMD check ~/GitHubs/Wip/RampalEtienne/R/PBD")

# For installing, only the tarball is needed
system("R CMD INSTALL ~/GitHubs/Wip/RampalEtienne/R/PBD_1.1.tar.gz")
