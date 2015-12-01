rm(list=ls())

library(roxygen2)
library(testit)
library(functional)

plus <- function(a,b)
{
  return (a + b)
}

minus <- function(a,b)
{
  return (a - b)
}

minus_and_multiply <- function(a,b,multiplicator)
{
  return ((a - b) * multiplicator)
}

# curried_minus_and_multiply <- function(a,b)
# {
#   return ((a - b) * 3)
# }

g <- function(any_function,c,d)
{
  return (any_function(c,d))
}


assert("",g(plus,2,4) == 6)
assert("",g(minus,2,4) == -2)
assert("",g(Curry(minus_and_multiply,multiplicator=3),2,4) == -6)
