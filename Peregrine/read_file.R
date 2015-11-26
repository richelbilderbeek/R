ReadFile <- function(filename)
{
  if (!file.exists(filename)) {
    print(paste("ERROR: file '", filename, "' not found", sep=""))
  }
  assert(file.exists(filename))
  file <- readRDS(filename)
}
