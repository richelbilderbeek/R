library(testit)
source("~/GitHubs/R/FileIo/print_file.R")

print_file_test <- function() {

  # Create file
  filename <- tempfile()
  text <- c("Hello","world")
  my_file <- file(filename)
  writeLines(text, my_file)
  close(my_file)

  #Print it using file.Show
  print_file_using_file_show(filename)
  
  #Print it using readLines
  print_file_using_read_lines(filename)

  # Remove temporary file
  has_removed <- file.remove(filename)
  assert(!file.exists(filename))
  
  print("print_file_test: OK")
}

print_file_test()
