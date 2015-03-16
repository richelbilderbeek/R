library(testit)

f <- function(a,b)
{
  assert("Denominator cannot be zero",b != 0)
  result <- a / b
}

print(f(a = 3, b = 4))

print(f(b = 4, a = 3))


