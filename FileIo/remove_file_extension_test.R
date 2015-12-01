library(testit)

source("~/GitHubs/R/FileIo/remove_file_extension.R")

remove_file_extension_test <- function()
{
  assert(remove_file_extension("tmp.txt") == "tmp")
  print("remove_file_extension_test: OK")
}

remove_file_extension_test()