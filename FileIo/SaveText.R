# Function to save text to a file and a demonstration of it

save_text <- function(filename, text) {
  my_file <- file(filename)
  writeLines(text, my_file)
  close(my_file)
}

SaveText <- function(filename, text) {
  print("Warning: use of obsolete function 'SaveText', use 'save_text' instead")
  save_text(filename = filename, text = text) 
}
  
demonstrate_save_text <- function() {

  filename <- "tmp.txt"
  text <- c("Hello","world")
  save_text(
    filename = filename,
    text = text
  )
  assert(file.exists(filename))
  file.show(filename)

  # Remove temporary file
  has_removed <- file.remove(filename)
  assert(!file.exists(filename))
}

#demonstrate_save_text()