# Clear the working memory
rm(list = ls())
library(testit)

# x y z s 
# 0 0 0 0
# 0 1 0 1
# 0 0 1 0
# 0 1 1 1
# 1 0 0 1
# 1 1 0 2
# 1 0 1 1
# 1 1 1 2


t <- data.frame(
	x = c(0,0,0,0,1,1,1,1),
	y = c(0,1,0,1,0,1,0,1),
	z = c(0,0,1,1,0,0,1,1)
)

t[, "s"] <- t$x + t$y

assert("",t$s == c(0,1,0,1,1,2,1,2))