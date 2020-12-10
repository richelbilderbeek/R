rm(list = ls())
tmax = 1
t = seq(0,tmax,0.1)
#N = 10
b <- 0.9
d <- 0.7

Pzero = function(t,b,d) {
	out = (d * (exp((b - d) * t) - 1)) /  ((b * exp((b - d) * t)) - d)
}

Ut = function(t,b,d) {
	out = (b * (exp((b - d) * t) - 1)) /  ((b * exp((b - d) * t)) - d)
}

Pt = function(t,b,d,N) {
  if (N == 0) {
  	out = Pzero(t,b,d);
  	return (out)
  } else {
	  out = (1 - Pzero(t,b,d)) * (1 - Ut(t,b,d)) * (Ut(t,b,d) ^ (N-1))
	  return (out)
	}
}

plot(t,Pt(t,b,d,N=15),type='l')

IsHazard = function(num_years,b,d)
{
	sum = 1
	for (i in 0:15)
	{
	  sum = sum - Pt(t=num_years,b,d,N=i)
	}
  return (sum)
}

#IsHazard(num_years=2,b,d)
#plot(IsHazard(num_years,b,d),x=num_years,xlim=c(1,10),type="l",ylim=c(0,1),pch=19)

#plot(IsHazard(num_years,b,d),xlim=c(1,10),type="l",ylim=c(0,1))

#
# Here those values are
#
for (num_years in 1:20)
{
	sum = 1
	for (i in 0:15)
	{
	  sum = sum - Pt(t=num_years,b,d,N=i)
	}
	print(num_years)
	print(sum * 100)
}