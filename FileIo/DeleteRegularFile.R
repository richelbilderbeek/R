library(testit)

#From https://github.com/richelbilderbeek/R
DeleteRegularFile <- function(file_name) 
{
  file.remove(file_name)
}

DemonstrateDeleteRegularFile <- function() {
  temp_filename <- "tmp.txt" 
  file.create(temp_filename)
  assert(file.exists(temp_filename))
  DeleteRegularFile(temp_filename)
  assert(!file.exists(temp_filename))
}

# Uncomment this to view the function demonstration
DemonstrateDeleteRegularFile()