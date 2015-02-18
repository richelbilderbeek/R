# Clear the working memory
rm(list = ls())

my_table <- data.frame(
	x = seq(1:10),
	y = seq(1:10)*seq(1:10),
	z = 1/seq(1:10)
)
plot(y ~ x, data = my_table)
plot(z ~ x, data = my_table)

par(mar = c(5, 4, 4, 4) + 0.3)  # Leave space for z axis
plot(y ~ x, data = my_table, main = "My title", xlab = "My x label", ylab = "My left y label") # first plot
par(new = TRUE) # Prevents R from clearing the area 
plot(z ~ x, axes = FALSE, bty = "n", xlab = "", ylab = "", data = my_table)
axis(side=4, at = pretty(range(my_table$z)))
mtext("My right y label", side=4, line=3)

