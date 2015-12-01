remove_file_extension <- function(filename) 
{
  return (strsplit(filename, "\\.")[[1]][1])
}