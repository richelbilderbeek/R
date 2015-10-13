library(testit)

DemonstrateReplaceInString <- function() {
  s <- "HelloXworld"
  t <- gsub("X"," ", s)

  assert("s is still spelled incorrectly", s != "Hello world")
  assert("t has been fixed", t == "Hello world")
}

# Uncomment this to view the function demonstration
# DemonstrateReplaceInString()
