# From https://github.com/richelbilderbeek/R
IsFolder <- function(folder_name) 
{
  is_folder <- file.info(folder_name)[1,"isdir"]
  if (is.na(is_folder)) { return (FALSE) }
  if (is_folder == TRUE) { return (TRUE) }
  return (FALSE)
}

library(testit)

# Home folder always exists under Linux
assert(IsFolder("~"))

# Home folder always exists under Linux
assert(IsFolder("~/GitHubs"))
assert(!IsFolder("~/GitHub"))
