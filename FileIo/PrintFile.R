# Shows the file in a tab
PrintFileUsingFileShow <- function(filename) {

  assert(file.exists(filename))
  file.show(filename)
}

# Shows the file as plaintext
PrintFileUsingReadLines <- function(filename) {

  assert(file.exists(filename))
  print(readLines(filename))
}


DemonstratePrintFile <- function() {

  # Create file
  filename <- "tmp.txt"
  text <- c("Hello","world")
  my_file <- file(filename)
  writeLines(text, my_file)
  close(my_file)

  #Print it using file.Show
  PrintFileUsingFileShow(filename)
  
  #Print it using readLines
  PrintFileUsingReadLines(filename)

  # Remove temporary file
  has_removed <- file.remove(filename)
  assert(!file.exists(filename))
}

DemonstratePrintFile()
