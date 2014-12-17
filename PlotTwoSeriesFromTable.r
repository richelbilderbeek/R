# Clear the working memory
rm(list = ls())

my_table <- data.frame(
	x = seq(1:10),
	y = seq(1:10)*seq(1:10),
	z = 1/seq(1:10)
)

plot(y ~ x, data = my_table)
plot(z ~ x, data = my_table)