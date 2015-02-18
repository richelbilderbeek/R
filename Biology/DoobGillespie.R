# Doob-Gillespie stochastic simulation
rm(list = ls())

t = 0
N = 10
b = 0.5
d = 0.45
t_max = 50
N_max = 100
plot(x=t,y=N,xlim=c(0,t_max),ylim=c(0,N_max))

while (t < t_max && N > 0 && N < N_max)
{
  dt = -log(runif(1)) / ((b + d) * N)
  p_birth = (b * N) / ((b + d) * N)
  t = t + dt
  if (runif(1) < p_birth)
  {
    N = N + 1
  } else {
    N = N - 1
  }  
  #text = paste(c("t: ",t,", N:",N),collapse="")
  #print (text)
  points(t,N)
}