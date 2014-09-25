# Clear the working memory
rm(list = ls())

# Characterics of the normal distrubution
my_mean = 100.0
my_sd = 10.0

# Parameters for creating a normal distribution
my_lower = my_mean - (3.0 * my_sd)
my_upper = my_mean + (3.0 * my_sd)
my_resolution = 10.0
my_step = (my_upper - my_lower) / my_resolution

# Generate the xs, ys
my_xs = x=seq(my_lower,my_upper,my_step)
my_ys_expected = dnorm(my_xs,my_mean,my_sd) # The expected normal distribution
my_ys_measured = my_ys_expected + runif(length(my_ys_expected))

my_table <- cbind(my_xs,my_ys_measured,my_ys_expected)
my_table

plot(my_ys_measured ~ my_xs,data = my_table)
plot(c(my_ys_measured,my_ys_expected) ~ my_xs,data = my_table)

plot(my_ys_expected ~ my_xs,data = my_table)
plot(my_ys_measured ~ my_xs,data = my_table)

my_distribution
#shapiro.test(my_distibution)
chisq.test(
	my_distribution,
	y = NULL, 
	correct = TRUE,
  p = my_table, 
	rescale.p = FALSE,
  simulate.p.value = FALSE, 
	B = 2000
)
?chisq.test
