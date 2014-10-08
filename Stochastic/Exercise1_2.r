rm(list = ls())

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

# Pzero to the power of the initial population
print(Pzero(t=10,b = 0.5,d = 0.6) ^ 100)
