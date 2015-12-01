source("~/GitHubs/R/FileIo/get_files_in_folder.R")

get_files_in_folder_test <- function() {
  print("All files in the current folder:")
  print(get_files_in_folder("."))
}

get_files_in_folder_test()

