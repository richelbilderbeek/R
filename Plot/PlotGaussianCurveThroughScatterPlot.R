# Clear the working memory
rm(list = ls())

my_table <- data.frame(
	x = c(1,4,9,16,25),
	y = c(1,2,4,8,4)
)

plot(my_table)

my_mean = mean(my_table$x)
my_mean
my_sd = sd(my_table$x)


plot(my_table,type="b",pch=19)

??fit
x_min <- min(my_table$x)
x_max <- max(my_table$x)
xs <- seq(x_min,x_max,(x_max - x_min) / 10)
xs
ys <- dnorm(xs,my_mean,my_sd)
ys
ys <- sum(my_table$y) * ys
lines(xs,ys)

ys
# loess.smooth(
# 	x = my_table$x,
#   y = my_table$y,
#   span = 2/3, degree = 1,
#   family = c("symmetric", "gaussian"), evaluation = 50
# )
	

?curve
curve(
	pnorm(x,mean=my_mean,sd=my_sd),
	col=rgb(1.0,0.75,0.0), #Orange
	lwd=3,
	add=TRUE
)
