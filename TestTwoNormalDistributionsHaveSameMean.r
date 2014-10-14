# Clear the working memory
rm(list = ls())

mean_a <- 300
mean_b <- 200
mean_c <- 100
sd_a <- 10
sd_b <- 10
sd_c <- 100
n <- 100

a <- rnorm(n,mean_a,sd_a)
b <- rnorm(n,mean_b,sd_b)
c <- rnorm(n,mean_c,sd_c)

plot(a)
plot(b)
hist(a)
hist(b)
hist(c)
t.test(a,b) #Show a low p value, as means are the same
t.test(a,b)
t.test(a,c)
t.test(b,c)
t.test(c(a,b,c))

# Welch Two Sample t-test
# 
# data:  a and c
# t = 19.847, df = 100.648, p-value < 2.2e-16
# alternative hypothesis: true difference in means is not equal to 0
# 95 percent confidence interval:
# 171.8732 210.0482
# sample estimates:
# mean of x mean of y 
# 299.9227  108.9620 
# 
# > t.test(b,c)
# 
# Welch Two Sample t-test
# 
# data:  b and c
# t = 9.3926, df = 100.803, p-value = 1.987e-15
# alternative hypothesis: true difference in means is not equal to 0
# 95 percent confidence interval:
# 71.31202 109.50112
# sample estimates:
# mean of x mean of y 
# 199.3686  108.9620 
# 
# > t.test(c(a,b,c))
# 
# One Sample t-test
# 
# data:  c(a, b, c)
# t = 36.6193, df = 299, p-value < 2.2e-16
# alternative hypothesis: true mean is not equal to 0
# 95 percent confidence interval:
# 191.8552 213.6470
# sample estimates:
# mean of x 
# 202.7511 