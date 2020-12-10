library(testit)

xs <- c(4,9,16)
assert("",length(xs) == 3)
assert("",xs[1] ==  4)
assert("",xs[2] ==  9)
assert("",xs[3] == 16)

for (i in seq(-1,5))
{
  if (i >= 1 && i <= length(xs)) 
  {
    assert("Must be a valid index",i >= 1 && i <= length(xs)) # Just a line I copy for debugging other programs
    print(xs[i])
  }
}
