#From https://github.com/richelbilderbeek/R/blob/master/FileIo/IsRegularFile.R
IsRegularFile <- function(file_name) 
{
  return (file.exists(file_name))
}

library(testit)

DemonstrateIsRegularFile <- function() {
  temp_filename <- "tmp.txt"
  
  # File does not exist yet
  assert(!IsRegularFile(temp_filename))

  # Create file
  file.create(temp_filename)

  # File exists now
  assert( IsRegularFile(temp_filename))

  # Delete file
  file.remove(temp_filename)

  # File does not exist anymore
  assert(!IsRegularFile(temp_filename))
}

# Uncomment this to view the function demonstration
#DemonstrateIsRegularFile()