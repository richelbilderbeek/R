# 1 2 3    1 3
# 1 2 3    1 3
# 1 2 3    1 3
# 1 2 3    1 3
# 1 2 3 -> 1 3
# 1 2 3    1 3
# 1 2 3    1 3
# 1 2 3    1 3
# 1 2 3    1 3
# 1 2 3    1 3

d <- data.frame(
    x = rep(1,10), 
    y = rep(2,10), 
    z = rep(3,10)
)
d

sum_to_delete <- sum(d$y) #20
sum_to_delete

e <- d[, colSums(d) != 20]
e

