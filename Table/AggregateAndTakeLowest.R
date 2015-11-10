# +------ Key
# | +---- Value
# | |
# | | 
# 1 3
# 1 2
# 1 1 <- lowest value for key == 1
# 2 2 <- lowest value for key == 2
# 2 3 
# 3 4 <- lowest value for key == 3

d <- data.frame(
    x = c(1,1,1,2,2,3),
	  y = c(3,2,1,2,3,4)
)

print(d)
d
e<-aggregate(
  x=d,
  by=list(factor(d$x)),
  FUN="min"
)
print(e)

f <- data.frame(
    x = e$x,
    y = e$y
)
print(f)
