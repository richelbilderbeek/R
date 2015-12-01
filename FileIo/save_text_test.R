# Test the save_text function

source("~/GitHubs/R/FileIo/save_text.R")

save_text_test <- function() {

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

save_text_test()