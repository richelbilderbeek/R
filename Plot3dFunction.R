rm(list = ls())

f <- function(x,y)
{
	z <- sin(x) + cos(y)
	return (z)
}

x <- seq(0.0,10,0.1)
y <- seq(0.0,10,0.1)
z <- outer(x,y,f)

persp(x,y,z,theta=25,phi=10,scale=TRUE,nticks=10)
contour(x,y,z)
filled.contour(x,y,z)
