library(testit)
source("~/GitHubs/R/FileIo/get_temp_filename.R")


get_temp_filename_test <- function() {
  filename <- get_temp_filename()
  print(paste("Filename '",filename,"' obtained",sep=""))
  assert(!file.exists(filename))
  print(paste("Filename '",filename,"' confirmed not to exist",sep=""))

  filename <- get_temp_filename(full_path = FALSE)
  print(paste("Filename '",filename,"' obtained",sep=""))
  print(basename(filename))
}

get_temp_filename_test()

