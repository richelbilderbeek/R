#From https://github.com/richelbilderbeek/R/blob/master/FileIo/IsFolder.R
IsFolder <- function(folder_name) 
{
  is_folder <- file.info(folder_name)[1,"isdir"]
  if (is.na(is_folder)) { return (FALSE) }
  if (is_folder == TRUE) { return (TRUE) }
  return (FALSE)
}

library(testit)

DemonstrateIsFolder <- function() {

  # Home folder always exists under Linux
  assert(IsFolder("~"))

  # Home folder always exists under Linux
  assert(IsFolder("~/GitHubs"))
  assert(!IsFolder("~/GitHub"))
}

# Uncomment this to view the function demonstration
#DemonstrateIsFolder()
