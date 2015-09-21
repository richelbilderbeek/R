#From https://github.com/richelbilderbeek/R/blob/master/FileIo/DeleteRegularFile.R
DeleteRegularFile <- function(file_name) 
{
  file.remove(file_name)
}

library(testit)

temp_filename <- "tmp.txt"

file.create(temp_filename)
assert(file.exists(temp_filename))
DeleteRegularFile(temp_filename)
assert(!file.exists(temp_filename))
