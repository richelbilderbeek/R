my_mean = 100.0
my_sd = 10.0

# Create a random normal distribution with mean=my_mean and standard deviation = my_sd
my_distibution <- rnorm(10000,my_mean,my_sd)

my_normal_distibution <- norm(10000,my_mean,my_sd)
?normal
?norm

hist(my_distibution)

#shapiro.test(my_distibution)
chisq.test(my_distibution, y = NULL, correct = TRUE,
           p = norm(my_distibution), length(my_distibution)), rescale.p = FALSE,
           simulate.p.value = FALSE, B = 2000)
?chisq.test
