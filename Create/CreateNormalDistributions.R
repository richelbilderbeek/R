# Clear the working memory
rm(list = ls())

# Characterics of the normal distrubutions
my_mean_1 <- 100.0
my_sd_1 <- 10.0
my_mean_2 <- 110.0
my_sd_2 <- 15.0

# Parameters for creating a normal distribution
my_lower_1 <- my_mean_1 - (3.0 * my_sd_1)
my_upper_1 <- my_mean_1 + (3.0 * my_sd_1)
my_lower_2 <- my_mean_2 - (3.0 * my_sd_2)
my_upper_2 <- my_mean_2 + (3.0 * my_sd_2)
my_resolution <- 10000.0
my_lower <- min(my_lower_1,my_lower_2)
my_upper <- max(my_upper_1,my_upper_2)
my_step <- (my_upper - my_lower) / my_resolution

# Generate the xs, ys and their combination is a table
my_xs <- seq(my_lower,my_upper,my_step)
my_ys_1 <- dnorm(my_xs,my_mean_1,my_sd_1)
my_ys_2 <- dnorm(my_xs,my_mean_2,my_sd_2)

# Create a random normal distribution with mean=my_mean and standard deviation = my_sd
plot(my_ys_1 ~ my_xs,
  xlab="X",
  ylab="Density",
  main="Normal distributions densities",
  col="red"
)
points(my_ys_2 ~ my_xs,col="blue")

