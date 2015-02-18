# Clear the working memory
rm(list = ls())

# Characterics of the normal distrubution
my_mean = 100.0
my_sd = 10.0

# Parameters for creating a normal distribution
my_lower = my_mean - (3.0 * my_sd)
my_upper = my_mean + (3.0 * my_sd)
my_resolution = 1000.0
my_step = (my_upper - my_lower) / my_resolution

# Generate the xs, ys and their combination is a table
my_xs = x=seq(my_lower,my_upper,my_step)
my_ys = dnorm(my_xs,my_mean,my_sd)
my_table <- cbind(my_xs,my_ys)

# Create a random normal distribution with mean=my_mean and standard deviation = my_sd
plot(my_table,
  xlab="X",
  ylab="Density",
  main=paste(c("Normal distribution densities (mean=",my_mean,", sd=",my_sd,")"),collapse = "")
)