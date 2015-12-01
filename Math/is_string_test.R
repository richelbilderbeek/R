source("~/GitHubs/R/Math/is_string.R")
library(testit)

is_string_test <- function() {
  assert(!is_string(42)) 
  assert(!is_string(42.1))
  assert(is_string("Hello")) 
  assert(!is_string(c(1,2))) 
  assert(!is_string(c("Hello","World"))) 
  
  print("is_string_test: OK")
}

is_string_test()