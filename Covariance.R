rm(list = ls())
library(testit)

# | g    e
# |    d
# | bc
# |a   f
# +-----------
#
# a | 1,1
# b | 2,2
# c | 3,2
# d | 5,5
# e | 7,7
# f | 4,1
# g | 2,4

t <- matrix(data = c(1,2,3,5,7,5,2,1,2,2,5,7,1,4),7,2)
plot(t)

my_x_variance <- var(t[,1])
my_y_variance <- var(t[,2])
my_covariance <- cov(t[,1],t[,2])
my_slope <- coef(lm(t[,2] ~ t[,1]))[2]