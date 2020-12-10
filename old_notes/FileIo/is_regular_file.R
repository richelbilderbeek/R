is_regular_file <- function(file_name) 
{
  # Sees if a file name is the name of an existing regular file
  return (file.exists(file_name))
}

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
}

is_regular_file_test()