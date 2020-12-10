source("~/GitHubs/R/FileIo/lines_to_file.R")

library(testit)

lines_to_file_test <- function()
{
  text <- c(
    "Hello",
    "World"
  )
  
  filename <- "lines_to_file.txt"
  lines_to_file(
    text = text,
    filename = filename
  )
  
  assert(file.exists(filename))
  
  print("lines_to_file_test: OK")
}

lines_to_file_test()