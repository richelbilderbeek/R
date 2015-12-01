source("~/GitHubs/R/Math/is_integer.R")
library(testit)

is_integer_test <- function() {
  assert(is_integer(as.integer(42))) 
  assert(!is_integer(42)) #Use is_whole_number instead
  assert(!is_integer("Hello")) 
  assert(!is_integer(c(1,2))) 
  
  print("is_integer_test: OK")
}

is_integer_test()