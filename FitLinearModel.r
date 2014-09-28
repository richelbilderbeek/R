# Clear the workspace
rm(list = ls())

xs <- c(1,1,2, 3, 5, 8,13,21,34)
ys <- c(1,4,9,16,25,35,49,64,81)
r <- lm(ys ~ xs)
plot(ys ~ xs)
abline(r)
