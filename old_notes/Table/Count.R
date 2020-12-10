library(testit)

t <- c("A","B","C","A","B","B")

assert("",table(t)["A"] == 2)
assert("",table(t)["B"] == 3)
assert("",table(t)["C"] == 1)

# Count the number of times search_value occurs in list
Count <- function(list,search_value)
{
  count <- 0
  for (value in list)
  {
    if (value == search_value)
    {
      count <- count + 1
    }
  }
  return (count)
}

x <- c(0.0,1.1,2.2,0.0)
assert("",Count(x,0.0) == 2)
assert("",Count(x,1.1) == 1)
assert("",Count(x,2.2) == 1)


