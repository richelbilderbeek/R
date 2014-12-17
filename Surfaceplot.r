rm(list = ls())
library(fields)
library(testit)
library(rgl)
library(akima)

# Use of x,y,z table

x_res <- 3
y_res <- 3
n_rows <- x_res*y_res
t <- matrix(0.0,n_rows,3)
for (x_i in c(1:x_res))
{
	for (y_i in c(1:y_res))
	{
    i <- 1 + ((x_i-1) * y_res) + (y_i - 1)
		print(i)
		assert("",i >= 1 && i <= n_rows)
		x <- (x_i-1) / (x_res - 1)
		y <- (y_i-1) / (y_res - 1)
		t[i,1] <- x
		t[i,2] <- y
		t[i,3] <- sin(x) + cos(y)
	}
}

plot3d(t,xlab="f(A)",ylab="f(B)",zlab="Fitness")

s <- interp(t[,1],t[,2],t[,3])
image.plot(s)
