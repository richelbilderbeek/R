library(testit)

get_subregex_match_test_1 <- function() {
  # From http://stackoverflow.com/questions/22334028/how-to-extract-a-part-from-a-string-in-r

  s <- "buy 1000 shares of Google at 1100 GBP"
  x <- sub(".* (\\d+) shares.*", "\\1", s)
  assert(x == 1000)  
}

get_subregex_match_test_2 <- function() {

  s <- "STATE_1234"
  x <- sub("STATE_(\\d+)", "\\1", s)
  x
  assert(x == 1234)  
}

get_subregex_match_test_1()
get_subregex_match_test_2()
