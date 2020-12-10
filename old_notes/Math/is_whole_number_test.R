source("~/GitHubs/R/Math/is_whole_number.R")
library(testit)

is_whole_number_test <- function() {
  assert(is_whole_number(42))
  assert(!is_whole_number(42.01))
  assert(!is_whole_number("Hello")) 
  assert(!is_whole_number(c(1,2))) 
  
  print("is_whole_number_test: OK")
}
is_whole_number_test()

