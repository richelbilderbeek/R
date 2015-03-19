library(testit)
library(rgl)

Poisson <- function(k,lambda)
{
  assert("The number of trials (k) must be integer",is.integer(k))
  assert("The number of trials (k) must be more than one",k > 0)
  assert("The chance of success (lambda) must be at least zero",lambda >= 0.0)
  result <- (lambda ^ k) * exp(-lambda) / factorial(k)
  return (result)
}





x_res <- 10
y_res <- 100
n_rows <- x_res*y_res
t <- matrix(0.0,n_rows,3)
for (x_i in c(1:x_res))
{
  for (y_i in c(1:y_res))
  {
    i <- 1 + ((x_i-1) * y_res) + (y_i - 1)
    assert("",i >= 1 && i <= n_rows)
    x <- 1 + ((x_i-1) / (x_res - 1) * 10)
    y <- (y_i-1) / (y_res - 1) * 10.0
    t[i,1] <- x
    t[i,2] <- y
    t[i,3] <- Poisson(k=as.integer(x),lambda=y)
  }
}

plot3d(t,xlab="k",ylab="lambda",zlab="Poisson(k,lambda)")