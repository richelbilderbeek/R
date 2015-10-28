#From https://github.com/richelbilderbeek/R/blob/master/FileIo/IsFolder.R
IsFolder <- function(folder_name) 
{
  is_folder <- file.info(folder_name)[1,"isdir"]
  if (is.na(is_folder)) { return (FALSE) }
  if (is_folder == TRUE) { return (TRUE) }
  return (FALSE)
}

install.package

folder_with_libraries <- "~/GitHubs/R/MyFavoritePackages/ape"
if (!IsFolder(folder_with_libraries))
{
  print("ERROR: folder with libraries does not exist")
}

library(lib.loc = folder_with_libraries)
