rm(list = ls())

if (1 || 1/0) print("OK")
if (1  | 1/0) print("OK")


library(testit)
z = 1:6
assert(all.equal( (z > 2) & (z < 5) , c(FALSE,FALSE,TRUE,TRUE,FALSE,FALSE) ) )
assert(all.equal( z[(z>2) & (z<5)]  , c(3,4) ) )
assert(all.equal( (z > 2) && (z < 5) , c(FALSE) ) )
assert(all.equal(  z > 2  &&  z < 5  , c(FALSE) ) )
assert(all.equal( z[(z > 2) && (z < 5)] , c(0) ) )
assert(all.equal( z[ z > 2  &&  z < 5 ] , c(0) ) )

say_hello <- function() 
{
  print("Hello")
  return (TRUE)
}

# say_hello should not be called
# operator| evaluates all arguments, even if the first one is true
# operator|| evaluates the arguments until it finds the first true condition (and thus the complete if can never be false anymore)
if (1 + 1 == 2  | say_hello()) { }
if (1 + 1 == 2 || say_hello()) { }

# Also for more arguments
if (1 + 1 == 2  | 1 + 2 == 3  | say_hello()) { }
if (1 + 1 == 2 || 1 + 2 == 3 || say_hello()) { }
