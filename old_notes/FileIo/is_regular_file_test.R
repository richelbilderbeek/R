source("~/GitHubs/R/FileIo/is_regular_file.R")

library(testit)

is_regular_file_test <- function() {
  temp_filename <- "tmp.txt"
  
  # File does not exist yet
  assert(!is_regular_file(temp_filename))

  # Create file
  file.create(temp_filename)

  # File exists now
  assert( is_regular_file(temp_filename))

  # Delete file
  file.remove(temp_filename)

  # File does not exist anymore
  assert(!is_regular_file(temp_filename))
  
  print("is_regular_file_test: OK")
}

is_regular_file_test()