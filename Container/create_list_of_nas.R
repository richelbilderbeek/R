# Create a list of NAs

library(testit)

create_list_of_nas <- function(n) {
  assert(n >= 0)
  v <- rep(x = NA, times = n)
  return (v)
}

demonstrate_create_list_of_nas <- function() {
  n <- 10
  v <- create_list_of_nas(n = n)
  assert(length(v) == n)
  for (i in v) { assert(is.na(i)) }
  print(v)
}

demonstrate_create_list_of_nas()
