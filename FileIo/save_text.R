
save_text <- function(filename, text) {
  # Save text (a container of strings) to a file
  
  my_file <- file(filename)
  writeLines(text, my_file)
  close(my_file)
}