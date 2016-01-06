library(testit)
source("~/GitHubs/R/FileIo/get_base_filename.R")

get_base_filename_test <- function() {
  assert(get_base_filename("/home/luke/the_force.txt") == "the_force")
}

get_base_filename_test()


