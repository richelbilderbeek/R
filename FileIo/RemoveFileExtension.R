library(testit)

RemoveFileExtension <- function(filename) 
{
  return (strsplit(filename, "\\.")[[1]][1])
}


DemonstrateRemoveFileExtension <- function()
{
  assert(RemoveFileExtension("tmp.txt") == "tmp")
}

#DemonstrateRemoveFileExtension()