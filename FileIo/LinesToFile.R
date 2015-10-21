library(testit)

LinesToFile <- function(text,filename) 
{
  my_file<-file(filename)
  writeLines(text, my_file)
  close(my_file)
}


DemonstrateLinesToFile <- function()
{
  text <- c(
    "Hello",
    "World"
  )
  LinesToFile(text=text,filename="LinesToFile.txt")
}

#DemonstrateLinesToFile()