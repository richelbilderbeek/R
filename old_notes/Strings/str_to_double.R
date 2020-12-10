library(testit)

str_to_double <- function(s) {
  d <- as.numeric(s)
  assert(!is.na(d))
  return (d)
}

str_to_double_test <- function() {
  assert(str_to_double("42") == 42)
}

str_to_double_test()


