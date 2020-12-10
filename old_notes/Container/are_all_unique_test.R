source("~/GitHubs/R/Container/are_all_unique.R")
library(testit)

are_all_unique_test <- function() {
  assert(are_all_unique(c()))
  assert(are_all_unique(c(1)))
  assert(are_all_unique(c(1,2)))
  assert(are_all_unique(c(1,2,3)))
  assert(are_all_unique(c(1,2,3,4)))
  assert(!are_all_unique(c(1,2,4,4)))
  assert(!are_all_unique(c(1,4,4,4)))
  assert(!are_all_unique(c(4,4,4,4)))
}

are_all_unique_test()