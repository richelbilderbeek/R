library(testit)

delete_regular_file <- function(file_name) {
  # Delete a file

  assert(file.exists(file_name))
  file.remove(file_name)
  assert(!file.exists(file_name))
}

DeleteRegularFile <- function(file_name) {
  print("Warning: use of obsolete function 'DeleteRegularFile', use 'delete_regular_file' instead")
  delete_regular_file(filename)
}