source("~/GitHubs/R/Math/calculate_factorial.R")

library(testit)

calculate_factorial_test <- function() {

  assert("1! equals 1"  ,calculate_factorial(x = 1) ==   1)
  assert("2! equals 2"  ,calculate_factorial(x = 2) ==   2)
  assert("3! equals 6"  ,calculate_factorial(x = 3) ==   6)
  assert("4! equals 24" ,calculate_factorial(x = 4) ==  24)
  assert("5! equals 120",calculate_factorial(x = 5) == 120)
  print("calculate_factorial_test: OK")
}

calculate_factorial_test()