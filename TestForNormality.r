# Clear the working memory
rm(list = ls())

# Characterics of the normal distrubution
my_mean_expected = 100.0
my_sd_expected = 10.0

# Parameters for creating a normal distribution
# my_lower = my_mean_expected - (3.0 * my_sd_expected)
# my_upper = my_mean_expected + (3.0 * my_sd_expected)
# my_resolution = 10.0
# my_step = (my_upper - my_lower) / my_resolution

# Generate the xs, ys
# my_xs = x=seq(my_lower,my_upper,my_step)
my_ys_expected = rnorm(10000,my_mean_expected,my_sd_expected)
my_ys_measured = my_ys_expected + runif(length(my_ys_expected))

my_table <- data.frame(cbind(my_ys_measured,my_ys_expected))
my_table

my_mean_measured <- mean(my_table$my_ys_measured)
my_sd_measured <- sd(my_table$my_ys_measured)

hist(
	my_table$my_ys_measured,
	breaks = seq(50,150,1),
	freq=FALSE,
	main="Histogram of measured values",
	xlab="Measured value",
	ylab="Relative frequency"
)
curve(
	dnorm(x,mean=my_mean_measured,sd=my_sd_measured),
	col=rgb(1.0,0.75,0.0), #Orange
	lwd=3,
	add=T
)

bartlett.test(redox_calib ~ habitat, data = data6)

