source("~/GitHubs/R/FileIo/delete_regular_file.R")

delete_regular_file_test <- function() {
  temp_filename <- tempfile()
  file.create(temp_filename)
  assert(file.exists(temp_filename))
  print(paste("Created file '",temp_filename,"'",sep=""))
  
  delete_regular_file(temp_filename)
  assert(!file.exists(temp_filename))
  print(paste("Deleted file '",temp_filename,"'",sep=""))
}

delete_regular_file_test()