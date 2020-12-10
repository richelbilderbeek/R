library(testit)

replace_in_string_test <- function() {
  # Replace the X by a space
  
  s <- "HelloXworld"
  t <- gsub("X"," ", s)

  assert("s is still spelled incorrectly", s != "Hello world")
  assert("t has been fixed", t == "Hello world")
}

replace_in_string_test()