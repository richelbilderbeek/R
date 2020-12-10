print_file_using_file_show <- function(filename) {
  # Shows the file in a tab

  assert(file.exists(filename))
  file.show(filename)
}