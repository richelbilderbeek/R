# Create a list of NAs
source("~/GitHubs/R/Container/create_list_of_nas.R")
library(testit)

create_list_of_nas_test <- function() {
  n <- 10
  v <- create_list_of_nas(n = n)
  assert(length(v) == n)
  for (i in v) { assert(is.na(i)) }
  print("create_list_of_nas_test: OK")
}

create_list_of_nas_test()
