library(testit)
library(rgl)

# Lemma: (1-x)^y is about exp(-x*t) for x << 1

f <- function(x,t)
{
  y <- ((1.0-x) ^ t)
  return (y)
}

g <- function(x,t)
{
  y <- exp(-x * t)
  return (y)
}


x_res <- 100
y_res <- 100
n_rows <- x_res*y_res
t <- matrix(0.0,n_rows,3)
for (x_i in c(1:x_res))
{
  for (y_i in c(1:y_res))
  {
    i <- 1 + ((x_i-1) * y_res) + (y_i - 1)
    assert("",i >= 1 && i <= n_rows)
    x <- (x_i-1) / (x_res - 1) * 0.1
    y <- (y_i-1) / (y_res - 1) * 10.0
    t[i,1] <- x
    t[i,2] <- y
    t[i,3] <- f(x=x,t=y) - g(x=x,t=y)
  }
}

plot3d(t,xlab="x",ylab="t",zlab="f-g")