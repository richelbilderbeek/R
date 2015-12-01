create_list_of_nulls <- function(n) {
  # Create a list of NAs
  # FAILS: cannot create a list of NULLs

  print("ERROR: use create_list_of_nas instead")
  assert(n >= 0)
  
  # Concatenation of NULLs returns in NULL, see 'create_list_of_nulls_test'
  v <- rep(x = NULL, times = n)
  
  return (v)
}

create_list_of_nulls_test <- function() {
  print("ERROR: use create_list_of_nas instead")
  
  assert(is.null(NULL))
  assert(is.null(c(NULL)))
  assert(is.null(c(NULL,NULL)))
  assert(is.null(c(NULL,NULL,NULL)))
  assert(is.null(rep(x = NULL,times = 0)))
  assert(is.null(rep(x = NULL,times = 1)))
  assert(is.null(rep(x = NULL,times = 10)))
  
  
  n <- 10
  v <- create_list_of_nulls(n = n)
  assert(length(v) == n) #FAILS
  print(v)
}

create_list_of_nulls_test()
