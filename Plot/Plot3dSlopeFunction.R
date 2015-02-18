rm(list = ls())

# From Freek de Haas
SlopeFunction <- function(o,y)
{
	z <- (-1*(o^3-y^3+2*(1-o-y)*o^2+2*o*y^2+o*(1-o-y)^2-(1-o-y)*y^2+o*y+(1-o-y)*o)^2 
  	+ y^3+o^3+2*o*y^2+2*(1-o-y)*o^2-2*y*o^2-2*(1-o-y)*o*y+(1-o-y)*o+o*y)/(-1*(o^3-y^3+2*(1-o-y)*o^2+2*o*y^2+o*(1-o-y)^2-(1-o-y)*y^2+o*y+(1-o-y)*o)^2 
		+ y^3+o^3+2*y*o^2+2*(1-o-y)*o^2+o*y^2+(1-o-y)*y^2+o*(1-o-y)^2+o*y+(1-o-y)*o
 		+ 4*(1-o-y)*o*y)
	return (z)
}

x <- seq(0.01,0.49,0.01)
y <- seq(0.01,0.49,0.01)
z <- outer(x,y,SlopeFunction)

persp(x,y,z,theta=25,phi=10,scale=TRUE,nticks=10)
contour(x,y,z)
filled.contour(x,y,z)
