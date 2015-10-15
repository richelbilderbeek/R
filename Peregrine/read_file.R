ReadFile <- function(filename)
{
  assert(file.exists(filename))
  file <- readRDS(filename)
}
