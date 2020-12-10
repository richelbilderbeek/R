# Started from script from Diana
rm(list = ls())

b = 7
d = 6.7
t = seq(0,5,0.1)

b1 = 7
d1 = 6.7
N = 10
t1 = seq(0,5,0.1)

Pzero = function(t,b,d) {out = d*(exp((b-d)*t)-1)/(b*exp((b-d)*t)-d); return(out) }
ut = function(t,b,d) {out = b*(exp((b-d)*t)-1)/(b*exp((b-d)*t)-d); return(out) }
Pt = function(t,b,d,N) {if(N>0) {out = (1-Pzero(t,b,d))*(1-ut(t,b,d))*ut(t,b,d)^(N-1)} else {out = (Pzero(t,b,d))}}


plot(t1,Pt(t,b,d,N),type='l')