SaveText <- function(filename, text) {
  my_file <- file(filename)
  writeLines(text, my_file)
  close(my_file)
}

DemonstrateSaveText <- function() {

  filename <- "tmp.txt"
  text <- c("Hello","world")
  SaveText(
    filename <- filename,
    text <- text
  )
  assert(file.exists(filename))
  file.show(filename)

  # Remove temporary file
  has_removed <- file.remove(filename)
  assert(!file.exists(filename))
}

#DemonstrateSaveText()