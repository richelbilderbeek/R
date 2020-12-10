source("~/GitHubs/R/Container/are_all_identical.R")
library(testit)

are_all_identical_test <- function() {
  assert(!are_all_identical(c()))
  assert( are_all_identical(c(1)))
  assert(!are_all_identical(c(1,2)))
  assert(!are_all_identical(c(1,2,3)))
  assert(!are_all_identical(c(1,2,3,4)))
  assert(!are_all_identical(c(1,2,4,4)))
  assert(!are_all_identical(c(1,4,4,4)))
  assert( are_all_identical(c(4,4,4,4)))
  print("are_all_identical_test: OK")
}

are_all_identical_test()