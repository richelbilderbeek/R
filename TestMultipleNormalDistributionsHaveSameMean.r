# Clear the working memory
rm(list = ls())

mean_a <- 300
mean_b <- 200
mean_c <- 100
sd_a <- 10
sd_b <- 100
sd_c <- 10
n <- 100

a <- rnorm(n,mean_a,sd_a)
b <- rnorm(n,mean_b,sd_b)
c <- rnorm(n,mean_c,sd_c)

t <- cbind(a,b,c)

hist(a)
hist(b)
hist(c)

FAILED

?ks.test
?ad.test
t.test(t)
anova.test(t)
pearson.test(t)
t.test(t)
