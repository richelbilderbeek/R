# Cannot create a list of NULLs

library(testit)

create_list_of_nulls <- function(n) {
  print("ERROR: use create_list_of_nas instead")
  assert(n >= 0)
  v <- rep(x = NULL, times = n)
  return (v)
}

demonstrate_create_list_of_nulls <- function() {
  print("ERROR: use create_list_of_nas instead")
  n <- 10
  v <- create_list_of_nulls(n = n)
  assert(length(v) == n)
  print(v)
}

demonstrate_create_list_of_nulls()
