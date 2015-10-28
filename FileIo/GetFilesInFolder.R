GetFilesInFolder <- function(folder) {
  return (list.files(path = folder))
}

DemonstrateGetFilesInFolder <- function() {
  print("All files in the current folder:")
  print(GetFilesInFolder("."))
}

#DemonstrateGetFilesInFolder()

