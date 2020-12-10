print_file_using_read_lines <- function(filename) {
  # Shows the file as plaintext

  assert(file.exists(filename))
  print(readLines(filename))
}
