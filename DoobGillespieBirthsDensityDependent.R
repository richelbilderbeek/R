# Doob-Gillespie stochastic simulation
# With births being density-dependent

rm(list = ls())
library(testit)


# Current time
t = 0
# Current population size
N = 10
# Death rate
d = 0.45
# End time
t_max = 50
# The population size at which no births occur
K = 100 
# Fecundity: the higher b_zero, the more births
b_zero = 1
assert(K > 0)

# The carrying capacity of the system as a whole
true_K = K * ((-d / b_zero) + 1) 

# Create an empty plot
plot(x=t,y=N,xlim=c(0,t_max),ylim=c(0,K))

while (t < t_max && N > 0)
{
	birth_rate = max(b_zero * (1 - (N/K)),0)
	assert(birth_rate >= 0)

	death_rate = d
	assert(death_rate >= 0)

	dt = -log(runif(1)) / ((birth_rate + death_rate) * N)
	assert(dt > 0)
	
	p_birth = (birth_rate * N) / ((birth_rate + death_rate) * N)
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
segments(0,true_K,t_max,true_K)