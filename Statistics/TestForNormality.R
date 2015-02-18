# Clear the working memory
rm(list = ls())

# Do a Shapiro-Wilk normality test on data known to follow a normal distribution
t <- shapiro.test(rnorm(1000, mean = 5, sd = 3))
print(t)
if (t$p >= 0.05) { print("Cannot reject distribution is normal") }
if (t$p < 0.05)  { print("Reject distribution is normal") }
# Possible output:
#
# Shapiro-Wilk normality test
#
# data:  rnorm(1000, mean = 5, sd = 3)
# W = 0.998, p-value = 0.2915
#
# [1] "Cannot reject distribution is normal"

# Do a Shapiro-Wilk normality test on data known to follow a uniform (non-normal) distribution
t <- shapiro.test(runif(1000, min = 2, max = 4))
print(t)
if (t$p >= 0.05) { print("Cannot reject distribution is normal") }
if (t$p < 0.05)  { print("Reject distribution is normal") }
# Possible output:
#
# Shapiro-Wilk normality test
#
# data:  runif(1000, min = 2, max = 4)
# W = 0.9499, p-value < 2.2e-16
#
# [1] "Reject distribution is normal"

# Characterics of the normal distrubution
my_mean_expected = 100.0
my_sd_expected = 10.0

# Shapiro-Wilk must have between 3 and 5000 values
n_values = 1000

# Generate the xs, ys
my_ys = rnorm(n_values,my_mean_expected,my_sd_expected)


my_table <- data.frame(cbind(my_ys))
my_table

my_mean <- mean(my_table$my_ys)
my_sd <- sd(my_table$my_ys)

hist(
	my_table$my_ys,
	breaks = seq(50,150,1),
	freq=FALSE,
	main="Histogram of measured values",
	xlab="Measured value",
	ylab="Relative frequency"
)
curve(
	dnorm(x,mean=my_mean,sd=my_sd),
	col=rgb(1.0,0.75,0.0), #Orange
	lwd=3,
	add=TRUE
)

shapiro.test(my_table$my_ys)
# Shapiro-Wilk normality test
# 
# data:  my_table$my_ys_measured
# W = 0.998, p-value = 0.3031

shapiro.test(my_table$my_ys)
# Shapiro-Wilk normality test
# 
# data:  my_table$my_ys_expected
# W = 0.9984, p-value = 0.4669

# Conclusions:
# p: the chance the data follows a normal distribution
# p <  0.05: reject that data does follow a normal distribution
# p >= 0.05: cannot reject that data does follow a normal distribution, 
#            or: 'data probably follows a normal distribution'

