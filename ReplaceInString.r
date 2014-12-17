library(testit)

rm(list = ls())

s <- "HelloXworld"
t <- gsub("X"," ", s)

assert("", s != "Hello world")
assert("", t == "Hello world")
