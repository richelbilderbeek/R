source("~/GitHubs/R/FileIo/files_are_equal.R")

files_are_equal_test <- function() {

  # Create files
  filename1 <- "tmp1.txt"
  filename2 <- "tmp2.txt"
  filename3 <- "tmp3.txt"
  text1 <- c("Hello","world")
  text2 <- c("Not", "hello","world")
  my_file <- file(filename1)
  writeLines(text1, my_file)
  close(my_file)
  my_file <- file(filename2)
  writeLines(text1, my_file)
  close(my_file)
  my_file <- file(filename3)
  writeLines(text2, my_file)
  close(my_file)

  assert( files_are_equal(filename1,filename2))
  assert(!files_are_equal(filename1,filename3))
  
  # Remove temporary file
  has_removed1 <- file.remove(filename1)
  has_removed2 <- file.remove(filename2)
  has_removed3 <- file.remove(filename3)
  assert(!file.exists(filename1))
  assert(!file.exists(filename2))
  assert(!file.exists(filename3))
}

files_are_equal_test()
