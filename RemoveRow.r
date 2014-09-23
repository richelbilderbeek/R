d <- data.frame(
    x = c(1,1,1,2,2,2,3,3,3), 
    y = c(1,2,3,1,2,3,1,2,3), 
    z = c(1,2,3,4,5,6,7,8,9)
)
d

# Assume y is a type treatment
# Only select treatment 2
e <- subset(d,y == 2)
e

f <- d[d$y == 2,]
f

e == f
