library(testit)

load_parameters_from_file <- function(filename) {
  assert(file.exists(filename))
  my_table <- readRDS(filename)
}