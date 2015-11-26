source("~/GitHubs/R/FileIo/DeleteRegularFile.R")

demonstrate_delete_regular_file <- function() {
  temp_filename <- tempfile()
  file.create(temp_filename)
  assert(file.exists(temp_filename))
  print(paste("Created file '",temp_filename,"'",sep=""))
  
  delete_regular_file(temp_filename)
  assert(!file.exists(temp_filename))
  print(paste("Deleted file '",temp_filename,"'",sep=""))
}

# Uncomment this to view the function demonstration
demonstrate_delete_regular_file()