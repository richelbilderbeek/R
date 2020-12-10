create_list_of_nas <- function(n) {
  # Create a list of NAs
  
  assert(n >= 0)
  v <- rep(x = NA, times = n)
  return (v)
}