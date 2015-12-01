library(testit)

delete_regular_file <- function(file_name) {
  # Delete a file

  assert(file.exists(file_name))
  file.remove(file_name)
  assert(!file.exists(file_name))
}