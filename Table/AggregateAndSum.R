# +------ Key
# | +---- A
# | |  +- B
# | |  |
# A 0 0
# A 0 0    1 0 0
# B 1 0 -> 2 1 1
# B 0 1    3 0 2
# C 0 1
# C 0 1

d <- data.frame(
    x = c("A","A","B","B","C","C"),
    y = c(0,0,1,0,0,0),
	  z = c(0,0,0,1,1,1)
)
d

e<-aggregate(d[-c(1)],by=list(as.factor(d$x)),sum)
e
