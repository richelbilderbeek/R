library(testit)

is_regex_match_test_1 <- function() {
  # Simple matching as in the documentation
  my_regex <- "a+"
  my_strings <- c("abc", "def", "cba a", "aa")
  v <- grep(my_regex,  my_strings, perl = TRUE, value = TRUE)
  assert(length(v) == 3)
  print("is_regex_match_test_1: OK")
}

is_regex_match_test_2 <- function() {
  # Simple matching as in the documentation
  dutch_zip_code <- "^[[:digit:]]{4}[[:space:]][[:upper:]]{2}$"
  valid_strings <- c(
    "1000 AA"
  )
  invalid_strings <- c(
    "1000AA",
    "1000 aa",
    "1000 AAA",
    "11000 AA"
  )
  valid <- grep(dutch_zip_code,  valid_strings, perl = TRUE, value = TRUE)
  invalid <- grep(dutch_zip_code,  invalid_strings, perl = TRUE, value = TRUE)
  assert(length(valid) == length(valid_strings))
  assert(length(invalid) == 0)
  
  print("is_regex_match_test_2: OK")
}

is_regex_match_test_1()
is_regex_match_test_2()
