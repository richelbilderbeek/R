library(testit)


IsPrime <- function(x)
{
	assert(x >= 1)
	
	if (x == 1) return (TRUE)
	if (x == 2) return (TRUE)
  
	max <- floor(sqrt(x)) + 1

  for (i in c(2:max))
  {
    if (x %% i == 0) return (FALSE);
  }

  return (TRUE);
}

Main <- function()
{
	assert("1 is prime",IsPrime(1) == TRUE)
	assert("2 is prime",IsPrime(2) == TRUE)
	assert("3 is prime",IsPrime(3) == TRUE)
	assert("4 is not prime",IsPrime(4) == FALSE)
	assert("5 is prime",IsPrime(5) == TRUE)
	assert("6 is not prime",IsPrime(6) == FALSE)
	assert("7 is prime",IsPrime(7) == TRUE)
	assert("8 is not prime",IsPrime(8) == FALSE)
	assert("9 is not prime",IsPrime(9) == FALSE)
	assert("10 is not prime",IsPrime(10) == FALSE)
	assert("11 is prime",IsPrime(11) == TRUE)
	assert("12 is not prime",IsPrime(12) == FALSE)
	assert("13 is prime",IsPrime(13) == TRUE)
	assert("14 is not prime",IsPrime(14) == FALSE)
	assert("15 is not prime",IsPrime(15) == FALSE)
	assert("16 is not prime",IsPrime(16) == FALSE)
	assert("17 is prime",IsPrime(17) == TRUE)
}

Main()

