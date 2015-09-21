#From https://github.com/richelbilderbeek/R/blob/master/FileIo/IsRegularFile.R
IsRegularFile <- function(file_name) 
{
  return (file.exists(file_name))
}

library(testit)

temp_filename <- "tmp.txt"

assert(!IsRegularFile(temp_filename))
file.create(temp_filename)
assert( IsRegularFile(temp_filename))
file.remove(temp_filename)
assert(!IsRegularFile(temp_filename))
