rm(list = ls())
library(testit)

# Calculate the dot product of:
#        
# [a c]   [e]
# [b d] x [f]
#
# [1 2]   [5]   [1*5 + 2*6]   [17]
# [3 4] x [6] = [3*5 + 4*6] = [39]
#
#
fs <- data.frame(matrix(0,2,1))
fs[1,1] <- 5
fs[2,1] <- 6
rownames(fs) = c("frow1","frow2")
colnames(fs) = c("fcol1")

gs <- data.frame(matrix(0,2,2))
gs[1,1] <- 1
gs[2,1] <- 3
gs[1,2] <- 2
gs[2,2] <- 4
rownames(gs) = c("grow1","grow2")
colnames(gs) = c("gcol1","gcol2")

expected <- data.frame(matrix(0,2,1))
expected[1,1] <- 17
expected[2,1] <- 39

hs <- data.matrix(gs) %*% data.matrix(fs)
hs
assert("hs should be as expected",hs == expected)
