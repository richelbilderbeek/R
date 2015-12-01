lines_to_file <- function(text,filename) {
  # Save a text (that is a container of strings) as a file
  
  my_file<-file(filename)
  writeLines(text, my_file)
  close(my_file)
}


library(testit)

DemonstrateLinesToFile <- function()
{
  text <- c(
    "Hello",
    "World"
  )
  LinesToFile(text=text,filename="LinesToFile.txt")
}

#DemonstrateLinesToFile()