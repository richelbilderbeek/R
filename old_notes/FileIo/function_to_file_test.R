source("~/GitHubs/R/FileIo/delete_regular_file.R")

library(testit)

function_to_file_test <- function() {
  temp_filename <- tempfile()
  # Write the function 'function_to_file' to file
  function_to_file(function_to_file,temp_filename)
  # Show the file its content
  print(readLines(temp_filename))
  file.remove(temp_filename)


  temp_filename <- tempfile()
  # Write the function 'function_to_file_test' to file
  function_to_file(function_to_file_test,temp_filename)
  # Show the file its content
  print(readLines(temp_filename))
  file.remove(temp_filename)
}

function_to_file_test()
