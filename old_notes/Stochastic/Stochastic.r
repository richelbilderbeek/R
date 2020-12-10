rm(list = ls())
tmax = 5
t = seq(0,tmax,0.1)
#N = 10
b <- 7.0
d <- 6.7

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

print(Ut(10000,b,d))
plot(Ut(t,b,d),xlim=c(0,tmax))
plot(Pzero(t,b,d),xlim=c(0,tmax))
lines(Pzero(t,b,d),xlim=c(0,tmax))
plot(t,Pzero(t,b,d),xlim=c(0,tmax))
lines(t,Pzero(t,b,d),xlim=c(0,tmax))

plot(t,Pt(t,b,d,N=10),type='l')
lines(t,Pt(t,b,d,N=20),type='l')
lines(t,Pt(t,b,d,N=30),type='l')

#plot(Pt(t=1000,b,d,N),x=N)

# for (i in 1:10)
# {
#   points(Pt(t=1000,b,d,N),x=N,col=i)
# }

