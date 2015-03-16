library(testit)

rm(list = ls())

s <- "HelloXworld"
t <- gsub("X"," ", s)

assert("s is still spelled incorrectly", s != "Hello world")
assert("t has been fixed", t == "Hello world")
