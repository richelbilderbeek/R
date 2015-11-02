library(testit)

x <- 3
str = cat("A",x,"B",sep="")
assert(all.equal(str,"A3B"))
