source("~/GitHubs/R/FileIo/is_folder.R")

library(testit)

is_folder_test <- function() {

  # Home folder always exists under Linux
  assert(is_folder("~"))

  # Home folder always exists under Linux
  assert(is_folder("~/GitHubs"))
  assert(!is_folder("~/GitHub"))
}

is_folder_test()
